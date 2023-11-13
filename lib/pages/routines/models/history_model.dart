class ProgressModel {
  List<RecordModel> progress;

  ProgressModel({required this.progress});

  factory ProgressModel.fromJson(dynamic response) => ProgressModel(
        progress: response.isNotEmpty
            ? List<RecordModel>.from(
                response.map((x) => RecordModel.fromJson(x)))
            : [],
      );
}

class RecordModel {
  int id;
  String name;
  String date;

  RecordModel({
    required this.id,
    required this.name,
    required this.date,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        id: json["id_history"],
        name: json["name"],
        date: json["date"] ?? '',
      );
}
