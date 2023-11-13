import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart'; // for other locales

class MatchModel {
  int id;
  String name;
  String date;
  String hour;

  MatchModel(
      {required this.id,
      required this.name,
      required this.date,
      required this.hour});

  factory MatchModel.fromJson(dynamic json) => MatchModel(
        id: json["id"],
        name: json["name_field"],
        date: _getDate(date: json["date"]),
        hour: _getHour(date: json["date"]),
      );
}

_getDate({required String date}) {
  final DateTime parsedDate = DateTime.parse(date);
  initializeDateFormatting('es');
  return DateFormat.MMMEd('es').format(parsedDate).toUpperCase();
}

_getHour({required String date}) {
  final DateTime parsedDate = DateTime.parse(date);
  return DateFormat.jms().format(parsedDate);
}
