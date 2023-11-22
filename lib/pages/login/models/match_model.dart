import '../utils/utils.dart'; // for other locales

class MatchModel {
  int id;
  int idField;
  String name;
  String date;
  String hour;
  Map<int, int> assistants;
  Map<int, int> substitutes;
  DateTime parsedDate;

  MatchModel({
    required this.id,
    required this.idField,
    required this.name,
    required this.date,
    required this.hour,
    required this.assistants,
    required this.substitutes,
    required this.parsedDate,
  });

  factory MatchModel.fromJson(dynamic json) => MatchModel(
        id: json["id"],
        idField: json["id_field"],
        name: "",
        date: Utils().getDate(date: json["date"]),
        hour: Utils().getHour(date: json["date"]),
        assistants: Utils().getMap(text: json['list_assistants']),
        substitutes: Utils().getMap(text: json['list_substitutes']),
        parsedDate: Utils().getParsedDate(date: json["date"]),
      );

  setDate({required List<DateTime?> dates}) {
    String date =
        '${dates.first!.year}-${dates.first!.month}-${dates.first!.day}';

    final String currentDate = '$date $hour';
    date = Utils().getDate(date: currentDate);
    parsedDate = Utils().getParsedDate(date: currentDate);
  }
}
