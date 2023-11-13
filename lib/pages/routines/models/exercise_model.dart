class ExercisesModel {
  List<ExerciseModel> exercises;

  ExercisesModel({required this.exercises});

  factory ExercisesModel.fromJson(dynamic response) => ExercisesModel(
        exercises: response.isNotEmpty
            ? List<ExerciseModel>.from(
                response.map((x) => ExerciseModel.fromJson(x)))
            : [],
      );
}

class ExerciseModel {
  int id;
  int idRoutine;
  String name;
  String date;
  String example;
  int weigth;
  int rep;
  int type;
  int idHstory;
  int idRE;
  int difficulty;

  ExerciseModel({
    required this.id,
    required this.idRoutine,
    required this.name,
    required this.date,
    required this.example,
    required this.weigth,
    required this.rep,
    required this.type,
    required this.idHstory,
    required this.idRE,
    required this.difficulty,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        id: json["id_exercise"] ?? -1,
        idRoutine: json["id_routine"] ?? -1,
        name: json["name"] ?? '',
        date: json["date"] ?? '',
        example: json["example"] ?? '',
        weigth: _getInt(json["info"], 0),
        rep: _getInt(json["info"], 1),
        type: _getInt(json["info"], 2),
        idHstory: json["id_history"] ?? 0,
        idRE: json["id_r_e"] ?? 0,
        difficulty: json["difficulty"] ?? 1,
      );
}

int _getInt(dynamic value, int pos) {
  if (value == null) {
    return 0;
  }
  return value[pos];
}
