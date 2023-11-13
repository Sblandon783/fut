class MatchesModel {
  List<MatchModel> teams;

  MatchesModel({required this.teams});

  factory MatchesModel.fromJson(dynamic response) => MatchesModel(
        teams: response.isNotEmpty
            ? List<MatchModel>.from(response.map((x) => MatchModel.fromJson(x)))
            : [],
      );
}

class MatchModel {
  int id;
  int idTeamOne;
  String teamNameOne;
  String teamImageOne;
  int goalsOneTeam;
  int idTeamTwo;
  String teamNameTwo;
  String teamImageTwo;
  int goalsSecondTeam;
  String date;
  bool isPlayed;

  MatchModel({
    required this.id,
    required this.idTeamOne,
    required this.teamNameOne,
    required this.teamImageOne,
    required this.goalsOneTeam,
    required this.idTeamTwo,
    required this.teamNameTwo,
    required this.teamImageTwo,
    required this.goalsSecondTeam,
    required this.date,
    required this.isPlayed,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json["id"],
        idTeamOne: json["id_team_one"],
        teamNameOne: json["team_name_one"],
        teamImageOne: json["team_image_one"],
        goalsOneTeam: json["goals_one_team"],
        idTeamTwo: json["id_team_two"],
        teamNameTwo: json["team_name_two"],
        teamImageTwo: json["team_image_two"],
        goalsSecondTeam: json["goals_second_team"],
        date: json["date"],
        isPlayed: json["is_played"],
      );

  factory MatchModel.copyObject(MatchModel match) => MatchModel(
        id: match.id,
        idTeamOne: match.idTeamOne,
        teamNameOne: match.teamNameOne,
        teamImageOne: match.teamImageOne,
        goalsOneTeam: match.goalsOneTeam,
        idTeamTwo: match.idTeamTwo,
        teamNameTwo: match.teamNameTwo,
        teamImageTwo: match.teamImageTwo,
        goalsSecondTeam: match.goalsSecondTeam,
        date: match.date,
        isPlayed: match.isPlayed,
      );
}
