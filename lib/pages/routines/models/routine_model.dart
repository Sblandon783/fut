class RoutinesModel {
  List<RoutineModel> teams;

  RoutinesModel({required this.teams});

  factory RoutinesModel.fromJson(dynamic response) => RoutinesModel(
        teams: response.isNotEmpty
            ? List<RoutineModel>.from(
                response.map((x) => RoutineModel.fromJson(x)))
            : [],
      );
}

class RoutineModel {
  int id;
  String name;
  String image;
  bool pendingToday;
  String dateHistory;

  RoutineModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.pendingToday,
      required this.dateHistory});

  factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel(
      id: json["id"],
      name: json["name"],
      image: _getImage(json["image"]),
      pendingToday: json["pending_today"],
      dateHistory: json["date_history"] ?? '');
}

String _getImage(dynamic image) {
  if (image == null || image.length < 10) {
    return 'https://hnkccsemqnrobnjqxufs.supabase.co/storage/v1/object/public/Images/profile_icon.jpg';
  } else {
    return image;
  }
}
