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
  int id;
  String name;
  String image;

  TeamModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
