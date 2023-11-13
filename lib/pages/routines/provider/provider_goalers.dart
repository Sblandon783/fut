import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/goalers_model.dart';

class ProviderGoalers {
  final Supabase _supabase = Supabase.instance;
  List<GoalerModel> goalers = [];
  final _goalersStreamController =
      StreamController<List<GoalerModel>>.broadcast();
  Function(List<GoalerModel>) get goalersSink =>
      _goalersStreamController.sink.add;
  Stream<List<GoalerModel>> get goalersStream =>
      _goalersStreamController.stream;

  ProviderGoalers();

  Future getGoalers() async {
    final List<dynamic> response = await _supabase.client.rpc('get_goalers');
    GoalersModel goalersResponse = GoalersModel.fromJson(response);
    goalersSink(goalersResponse.goalers);
  }
}
