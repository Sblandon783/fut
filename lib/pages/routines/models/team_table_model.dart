class TeamTableModel {
  String team;
  int matchPlayed;
  int wins;
  int lose;
  int like;
  List<String> data;

  TeamTableModel({
    required this.team,
    required this.matchPlayed,
    required this.wins,
    required this.lose,
    required this.like,
    required this.data,
  });

  factory TeamTableModel.fromJson(Map<String, dynamic> json) => TeamTableModel(
        team: json["team"],
        matchPlayed: json["PJ"],
        wins: json["G"],
        lose: json["D"],
        like: json["E"],
        data: [
          json["PJ"],
          json["G"],
          json["D"],
          json["E"],
          json['GF'],
          json['GA'],
          json['GD'],
          json['PTS'],
        ],
      );
}
