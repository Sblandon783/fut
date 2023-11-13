class TeamModel {
  String hourStart;
  String hourFinish;
  String nameTeam_1;
  String nameTeam_2;
  bool isCompleted;

  TeamModel(
      {required this.hourStart,
      required this.hourFinish,
      required this.nameTeam_1,
      required this.nameTeam_2,
      required this.isCompleted});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        hourStart: json["hourStart"],
        hourFinish: json["hourFinish"],
        nameTeam_1: json["nameTeam_1"],
        nameTeam_2: json["nameTeam_2"],
        isCompleted: json["isCompleted"],
      );
}
