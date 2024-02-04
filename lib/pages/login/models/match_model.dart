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
  Map<dynamic, dynamic> listPerformance;
  int idOneTeam;
  String imageOneTeam;
  int idSecondTeam;
  String imageSecondTeam;
  Map<dynamic, dynamic> listGoals;

  MatchModel(
      {required this.id,
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
      required this.listPerformance,
      required this.idOneTeam,
      required this.imageOneTeam,
      required this.idSecondTeam,
      required this.imageSecondTeam,
      this.listGoals = const {}});

  factory MatchModel.fromJson(dynamic json) => MatchModel(
        id: json["id"] ?? -1,
        idField: json["id_field"] ?? -1,
        idAlign: json["id_align"] ?? -1,
        name: "",
        date: json["date"] != null ? Utils().getDate(date: json["date"]) : '',
        hour: json["date"] != null ? Utils().getHour(date: json["date"]) : '',
        assistants: Utils().getMap(text: json['list_assistants']),
        substitutes: Utils().getMap(text: json['list_substitutes']),
        parsedDate: Utils().getParsedDate(date: json["date"]),
        idMPV: Utils().getMVP(json["list_mvp"]),
        mapMVP: json["list_mvp"] != ""
            ? Utils().getMap(text: json["list_mvp"])
            : {},
        isFinished: json["is_finished"] ?? false,
        teamOneGoals: json["team_1_goals"] ?? 0,
        teamSecondGoals: json["team_2_goals"] ?? 0,
        listPerformance: setPerformance(json["list_performance"]),
        idOneTeam: -1,
        imageOneTeam: json["image_team_one"] ?? '',
        idSecondTeam: -1,
        imageSecondTeam: json["image_team_second"] ?? '',
        listGoals: json["list_goals"] ?? {},
      );

  setDate({required List<DateTime?> dates}) {
    String day = dates.first!.day < 10
        ? '0${dates.first!.day}'
        : dates.first!.day.toString();
    String month = dates.first!.month < 10
        ? '0${dates.first!.month}'
        : dates.first!.month.toString();
    String dateN = '${dates.first!.year}-$month-$day';

    final String currentDate = '$dateN $hour';
    date = Utils().getDate(date: currentDate);
    parsedDate = Utils().getParsedDate(date: currentDate);
  }

  Map<dynamic, dynamic> json() {
    return {
      "id": id,
      "id_field": idField,
      "id_align": idAlign,
      "name": name,
      "date": parsedDate.toString(),
      /*
      "list_assistants": assistants,
      "list_substitutes": substitutes,
      */
      "is_finished": isFinished,
      "team_1_goals": teamOneGoals,
      "team_2_goals": teamSecondGoals,
      "list_performance": listPerformance,
      "idOneTeam": idOneTeam,
      "image_team_one": imageOneTeam,
      "idSecondTeam": idSecondTeam,
      "image_team_second": imageSecondTeam,
    };
  }
}

setPerformance(dynamic perfomance) {
  Map<dynamic, dynamic> map = {};
  if (perfomance == null || perfomance == {}) {
    return map;
  }

  return perfomance;
}
