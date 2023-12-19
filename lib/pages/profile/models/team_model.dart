class TeamsModel {
  List<TeamModel> teams;

  TeamsModel({required this.teams});

  factory TeamsModel.fromJson(dynamic response) => TeamsModel(
        teams: response.isNotEmpty
            ? List<TeamModel>.from(response.map((x) => TeamModel.fromJson(x)))
            : [],
      );
}

class TeamModel {
  final int id;

  final String name;
  final String image;
  final int idCaptain;

  int winner;
  int loose;
  int equals;
  int totalMembers;

  TeamModel({
    required this.id,
    required this.name,
    required this.image,
    required this.idCaptain,
    required this.winner,
    required this.loose,
    this.equals = 0,
    this.totalMembers = 0,
  });

  factory TeamModel.fromJson(dynamic json) => TeamModel(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
        idCaptain: json["captain"],
        winner: json["winner"],
        loose: json["loose"],
      );
}
