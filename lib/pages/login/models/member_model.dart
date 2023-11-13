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
  String date;
  bool included;
  bool added;

  MemberModel({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
    required this.idPosition,
    required this.date,
    required this.included,
    this.added = false,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        idPosition: json["position"],
        position: _getPosition(position: json["position"]),
        date: json["date_match"] ?? '',
        included: _isIncluded(date: json["date_match"]),
      );
}

const Map<int, String> _mapPosition = {
  1: 'POR',
  2: 'LTD',
  3: 'LTI',
  4: 'DFC',
  5: 'MD',
  6: 'MC',
  7: 'MI',
  8: 'MD',
  9: 'DC'
};
_getPosition({required int position}) =>
    _mapPosition[position] ?? _mapPosition[1];

_isIncluded({required dynamic date}) {
  if (date == null) {
    return false;
  }
  DateTime now = DateTime.now();
  DateTime dateCurrent = DateTime(now.year, now.month, now.day);
  DateTime dt1 = DateTime.parse(date);
  return !(dateCurrent.compareTo(dt1) > 0);
}
