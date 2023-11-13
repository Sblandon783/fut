class MatchModel {
  int id;
  int idTeamOne;
  String teamNameOne;
  int idTeamTwo;
  String teamNameTwo;
  String date;
  bool isPlayed;

  MatchModel({
    this.id = -1,
    this.idTeamOne = -1,
    this.teamNameOne = "",
    this.idTeamTwo = -1,
    this.teamNameTwo = "",
    this.date = "",
    this.isPlayed = false,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json["id"],
        idTeamOne: json["id_team_one"],
        teamNameOne: json["team_name_one"],
        idTeamTwo: json["id_team_two"],
        teamNameTwo: json["team_name_two"],
        date: json["date"],
        isPlayed: json["is_played"],
      );
}
