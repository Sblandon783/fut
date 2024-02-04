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
  bool isCaptain;
  int status;
  int goals;

  MemberModel({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
    required this.idPosition,
    required this.date,
    this.included = false,
    this.added = false,
    this.titular = false,
    this.isMPV = false,
    required this.attributes,
    this.isCaptain = false,
    this.status = 1,
    this.goals = 0,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        idPosition: json["position"] ?? json["pos"] ?? -1,
        position: _getPosition(position: json["position"] ?? json["pos"] ?? -1),
        date: json["date_match"] ?? '',
        attributes: json["attributes"] != null
            ? AttributesModel.fromJson(json["attributes"])
            : AttributesModel.fromJson(Utils().attributesDefault),
        isCaptain: json["is_captain"] ?? false,
        status: json["status"] ?? 1,
        goals: json["goals"] ?? 0,
      );

  json() => {
        "id": id,
        "name": name,
        "number": number,
        "position": idPosition,
        "date_match": date,
        "goals": goals,
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
