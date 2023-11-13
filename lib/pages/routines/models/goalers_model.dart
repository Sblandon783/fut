class GoalersModel {
  List<GoalerModel> goalers;

  GoalersModel({required this.goalers});

  factory GoalersModel.fromJson(dynamic response) => GoalersModel(
        goalers: response.isNotEmpty
            ? List<GoalerModel>.from(
                response.map((x) => GoalerModel.fromJson(x)))
            : [],
      );
}

class GoalerModel {
  int id;
  String player;
  String team;
  String teamImage;
  int goals;
  int pos;

  GoalerModel({
    this.id = 0,
    this.player = "",
    this.team = "",
    this.teamImage = "",
    this.goals = 0,
    this.pos = 0,
  });

  factory GoalerModel.fromJson(Map<String, dynamic> json) => GoalerModel(
      id: json["id"] ?? 0,
      player: json["name"] ?? '',
      team: json["team"] ?? '',
      teamImage: json["team_image"] ?? '',
      goals: json["goals"],
      pos: json['pos'] ?? 0);
}
