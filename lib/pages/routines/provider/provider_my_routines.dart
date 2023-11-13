import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/exercise_model.dart';
import '../models/history_model.dart';
import '../models/routine_model.dart';
import '../models/teams_model.dart';

class ProviderMyRoutines {
  ProviderMyRoutines();

  final Supabase _supabase = Supabase.instance;
  late int _idHistory;

  List<RoutineModel> routines = [];
  final _teamsStreamController =
      StreamController<List<RoutineModel>>.broadcast();

  Function(List<RoutineModel>) get routinesSink =>
      _teamsStreamController.sink.add;
  Stream<List<RoutineModel>> get routinesStream =>
      _teamsStreamController.stream;

  List<ExerciseModel> _exercises = [];
  final _exercisesStreamController =
      StreamController<List<ExerciseModel>>.broadcast();
  Function(List<ExerciseModel>) get exercisesSink =>
      _exercisesStreamController.sink.add;
  Stream<List<ExerciseModel>> get exercisesStream =>
      _exercisesStreamController.stream;

  //History
  List<RecordModel> _progress = [];
  final _progressStreamController =
      StreamController<List<RecordModel>>.broadcast();
  Function(List<RecordModel>) get progressSink =>
      _progressStreamController.sink.add;
  Stream<List<RecordModel>> get progressStream =>
      _progressStreamController.stream;

  Future getRoutines({required int idUser}) async {
    final Map<String, dynamic> params = {'_id_user': idUser};
    final List<dynamic> response =
        await _supabase.client.rpc('get_routines_by_user', params: params);
    RoutinesModel teamResponse = RoutinesModel.fromJson(response);
    print('API: get routines -- params: $params');
    print(response);
    routines = teamResponse.teams;
    routinesSink(routines);
  }

  Future getExercises({required int idRoutine}) async {
    final Map<String, dynamic> params = {'_id_routine': idRoutine};
    final List<dynamic> response =
        await _supabase.client.rpc('get_exercises_by_routine', params: params);
    print('API: get get_exercises_by_routine -- params: $params');

    ExercisesModel exercisesResponse = ExercisesModel.fromJson(response);
    _exercises = exercisesResponse.exercises;
    exercisesSink(_exercises);
  }

  //exercises history
  Future getExercisesToDo({required int idRoutine}) async {
    print(idRoutine);
    final List<dynamic> response = await _supabase.client.rpc(
        'get_exercises_by_routine_to_do',
        params: {'_id_routine': idRoutine});
    ExercisesModel exercisesResponse = ExercisesModel.fromJson(response);
    _exercises = exercisesResponse.exercises;
    exercisesSink(_exercises);
    _idHistory = _exercises.first.idHstory;
  }

  Future getExercisesByRecord({required int idRecord}) async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_exercises_by_record', params: {'_id_history': idRecord});
    ExercisesModel exercisesResponse = ExercisesModel.fromJson(response);
    _exercises = exercisesResponse.exercises;
    exercisesSink(_exercises);
    _idHistory = _exercises.first.idHstory;
  }

  Future getHistoryRoutine({required int idRoutine}) async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_history_routine_by_user', params: {'_id_routine': idRoutine});
    ProgressModel progressResponse = ProgressModel.fromJson(response);
    _progress = progressResponse.progress;
    progressSink(_progress);
  }

  /////

  Future<bool> addRoutine(
      {required RoutineModel routine, required int userId}) async {
    final Map<String, dynamic> params = {
      '_id_user': userId,
      '_name': routine.name,
      '_image': routine.image
    };
    final List<dynamic> response =
        await _supabase.client.rpc('add_routine', params: params);
    print('API: get add_routine -- params: $params');
    print(response.first["id"]);
    return response.first["id"] != null;
  }

  Future<bool> addRoutineToUser({required RoutineModel routine}) async {
    await _supabase.client
        .from('routine')
        .insert({'name': routine.name, 'image': routine.image});
    return true;
  }

  Future<bool> addExercise({required ExerciseModel exercise}) async {
    final Map<String, dynamic> params = {
      '_id_routine': exercise.idRoutine,
      '_name': exercise.name,
      '_example': exercise.example,
      '_difficulty': exercise.difficulty
    };
    print('API: get add_routine -- params: $params');
    final List<dynamic> response =
        await _supabase.client.rpc('add_exercise', params: params);
    print('API: get add_routine -- params: $params');
    print(response.first["id"]);
    return response.first["id"] != null;
  }

  Future<bool> editSesion() async {
    final Map<String, dynamic> json = _generateJson();

    await _supabase.client
        .from('exercise_history')
        .update({'data': json}).eq('id', _idHistory);
    return true;
  }

  Future<bool> createSesion({required idRoutine}) async {
    final Map<String, dynamic> json = _generateJson();
    await _supabase.client
        .from('exercise_history')
        .insert({'data': json, 'id_routine': idRoutine});
    print(json);
    return true;
  }

  Future<bool> deleteExercise({required ExerciseModel exercise}) async {
    final Map<String, dynamic> json = {};

    for (var i = 0; i < _exercises.length; i++) {
      ExerciseModel tempExercise = _exercises[i];
      if (tempExercise.id != exercise.id) {
        json[tempExercise.id.toString()] = [
          tempExercise.weigth,
          tempExercise.rep,
          tempExercise.type
        ];
      }
    }

    await _supabase.client
        .from('exercise_history')
        .update({'data': json}).eq('id', exercise.idHstory);
    await _supabase.client
        .from('routine_exercise')
        .delete()
        .eq('id', exercise.idRE);
    return true;
  }
  //

  void afterEditExercise({required ExerciseModel exercise}) {
    final List<ExerciseModel> exercises = _exercises;
    for (var i = 0; i < exercises.length; i++) {
      if (exercises[i].id == exercise.id) {
        exercises[i] = exercise;
      }
    }
    _exercises = exercises;
    exercisesSink(_exercises);
  }

  void afterrDeleteExercise({required ExerciseModel exercise}) {
    _exercises.removeWhere((tempExercise) => tempExercise.id == exercise.id);
    exercisesSink(_exercises);
  }

  Map<String, dynamic> _generateJson() {
    final Map<String, dynamic> json = {};
    for (var i = 0; i < _exercises.length; i++) {
      ExerciseModel tempExercise = _exercises[i];

      json[tempExercise.id.toString()] = [
        tempExercise.weigth,
        tempExercise.rep,
        tempExercise.type
      ];
    }
    return json;
  }

  //other endPoints

  Future<bool> editEachExercise({required ExerciseModel exercise}) async {
    final Map<String, dynamic> json = {};

    for (var i = 0; i < _exercises.length; i++) {
      ExerciseModel tempExercise =
          _exercises[i].id == exercise.id ? exercise : _exercises[i];

      json[tempExercise.id.toString()] = [
        tempExercise.weigth,
        tempExercise.rep,
        tempExercise.type
      ];
    }
    await _supabase.client
        .from('exercise_history')
        .update({'data': json}).eq('id', exercise.idHstory);
    return true;
  }
}
