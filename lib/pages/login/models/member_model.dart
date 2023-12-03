import 'package:soccer/pages/login/models/atribbute_model.dart';

import '../utils/utils.dart';

class MembersModel {
  List<MemberModel> members;

  MembersModel({required this.members});

  factory MembersModel.fromJson(dynamic response) => MembersModel(
        members: response.isNotEmpty
            ? List<MemberModel>.from(
                response.map((x) => MemberModel.fromJson(x)))
            : [],
      );
}

class MemberModel {
  int id;
  String name;
  int number;
  int idPosition;
  String position;
  int idPositionNew = -1;
  String positionNew = '';
  String date;
  bool included;
  bool added;
  bool titular;
  bool isMPV;
  AttributesModel attributes;

  MemberModel({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
    required this.idPosition,
    required this.date,
    required this.included,
    this.added = false,
    this.titular = true,
    this.isMPV = false,
    required this.attributes,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        idPosition: json["position"],
        position: _getPosition(position: json["position"]),
        date: json["date_match"] ?? '',
        included: _isIncluded(date: json["date_match"]),
        attributes: json["attributes"] != null
            ? AttributesModel.fromJson(json["attributes"])
            : AttributesModel.fromJson(Utils().attributesDefault),
      );

  json() => {
        "id": id,
        "name": name,
        "number": number,
        "position": idPosition,
        "date_match": date,
      };

  setPosition({required int pos}) {
    idPosition = pos;
    position = _getPosition(position: pos);
  }

  setPositionNew({required int pos}) {
    idPositionNew = pos;
    positionNew = _getPosition(position: pos);
  }
}

_getPosition({required int position}) =>
    Utils().mapPosition[position] ?? Utils().mapPosition[1];

_isIncluded({required dynamic date}) {
  if (date == null || date == "") {
    return false;
  }
  DateTime now = DateTime.now();
  DateTime dateCurrent = DateTime(now.year, now.month, now.day);
  DateTime dt1 = DateTime.parse(date);
  return !(dateCurrent.compareTo(dt1) > 0);
}
