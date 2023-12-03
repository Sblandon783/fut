import '../utils/utils.dart'; // for other locales

class MatchesModel {
  List<MatchModel> matches;

  MatchesModel({required this.matches});

  factory MatchesModel.fromJson(dynamic response) => MatchesModel(
        matches: response.isNotEmpty
            ? List<MatchModel>.from(response.map((x) => MatchModel.fromJson(x)))
            : [],
      );
}

class MatchModel {
  int id;
  int idField;
  int idAlign;
  String name;
  String date;
  String hour;
  Map<int, int> assistants;
  Map<int, int> substitutes;
  DateTime parsedDate;
  int idMPV;
  Map<int, int> mapMVP;
  bool isFinished;
  int teamOneGoals;
  int teamSecondGoals;

  MatchModel({
    required this.id,
    required this.idField,
    required this.idAlign,
    required this.name,
    required this.date,
    required this.hour,
    required this.assistants,
    required this.substitutes,
    required this.parsedDate,
    this.idMPV = -1,
    this.mapMVP = const {},
    this.isFinished = false,
    required this.teamOneGoals,
    required this.teamSecondGoals,
  });

  factory MatchModel.fromJson(dynamic json) => MatchModel(
        id: json["id"],
        idField: json["id_field"],
        idAlign: json["id_align"],
        name: "",
        date: Utils().getDate(date: json["date"]),
        hour: Utils().getHour(date: json["date"]),
        assistants: Utils().getMap(text: json['list_assistants']),
        substitutes: Utils().getMap(text: json['list_substitutes']),
        parsedDate: Utils().getParsedDate(date: json["date"]),
        idMPV: Utils().getMVP(json["list_mvp"]),
        mapMVP: json["list_mvp"] != ""
            ? Utils().getMap(text: json["list_mvp"])
            : {},
        isFinished: json["isFinished"],
        teamOneGoals: json["team_1_goals"] ?? 0,
        teamSecondGoals: json["team_2_goals"] ?? 0,
      );

  setDate({required List<DateTime?> dates}) {
    String day = dates.first!.day < 10
        ? '0${dates.first!.day}'
        : dates.first!.day.toString();
    String dateN = '${dates.first!.year}-${dates.first!.month}-$day';

    final String currentDate = '$dateN $hour';
    date = Utils().getDate(date: currentDate);
    parsedDate = Utils().getParsedDate(date: currentDate);
  }
}
