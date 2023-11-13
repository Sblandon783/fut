class UserModel {
  String name;
  String date;

  UserModel({
    required this.name,
    required this.date,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"] ?? '',
        date: json["date"] ?? '',
      );
}
