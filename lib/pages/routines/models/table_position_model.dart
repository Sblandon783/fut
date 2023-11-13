class TablePositionModel {
  List<TeamInfoModel> teams;

  TablePositionModel({required this.teams});

  factory TablePositionModel.fromJson(dynamic response) => TablePositionModel(
        teams: response.isNotEmpty
            ? List<TeamInfoModel>.from(
                response.map((x) => TeamInfoModel.fromJson(x)))
            : [],
      );
}

class TeamInfoModel {
  String team;
  int pj;
  int g;
  int d;
  int e;
  int gf;
  int ga;
  int gd;
  int pts;
  int pos;
  List<int> data;

  TeamInfoModel({
    required this.team,
    required this.pj,
    required this.g,
    required this.d,
    required this.e,
    required this.gf,
    required this.ga,
    required this.gd,
    required this.pts,
    required this.data,
    required this.pos,
  });

  factory TeamInfoModel.fromJson(Map<String, dynamic> json) => TeamInfoModel(
          team: json["name"],
          pj: json["pj"],
          g: json["g"],
          d: json["d"],
          e: json["e"],
          gf: json['gf'],
          ga: json['ga'],
          gd: json['gd'],
          pts: json['pts'],
          pos: json['pos'],
          data: [
            json["pj"],
            json["g"],
            json["d"],
            json["e"],
            json['gf'],
            json['ga'],
            json['gd'],
            json['pts'],
          ]);
}
