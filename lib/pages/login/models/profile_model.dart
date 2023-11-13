import 'package:soccer/pages/profile/models/pet_model.dart';

class ProfileModel {
  String name;
  String image;
  int countPosts;
  List<PetModel> pets;

  ProfileModel({
    required this.name,
    required this.image,
    required this.pets,
    required this.countPosts,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["username"] ?? '',
        image: json["user_image"] ?? '',
        countPosts: json["count_posts"] ?? 0,
        pets: json["pets"] != null
            ? List<PetModel>.from(json["pets"].map((x) => PetModel.fromJson(x)))
            : [],
      );
  insertAllPets(List<dynamic> list) {
    pets = List<PetModel>.from(list.map((x) => PetModel.fromJson(x)));
  }
}
