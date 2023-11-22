class FieldsModel {
  List<FieldModel> fields;

  FieldsModel({required this.fields});

  factory FieldsModel.fromJson(dynamic response) => FieldsModel(
        fields: response.isNotEmpty
            ? List<FieldModel>.from(response.map((x) => FieldModel.fromJson(x)))
            : [],
      );
}

class FieldModel {
  int id;
  String name;
  List<String> hours;

  FieldModel({
    required this.id,
    required this.name,
    required this.hours,
  });

  factory FieldModel.fromJson(dynamic json) => FieldModel(
        id: json["id"],
        name: json["name"],
        hours: _getHours(hours: json["hours"]),
      );
}

_getHours({required String hours}) => hours.split(", ");
