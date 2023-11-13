class PetModel {
  String name;
  String image;

  PetModel({
    required this.name,
    required this.image,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        name: json["name"],
        image: json["image"],
      );
}
