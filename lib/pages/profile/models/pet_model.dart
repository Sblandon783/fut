class PetModel {
  int owner;
  String name;
  String image;

  PetModel({
    this.owner = -1,
    required this.name,
    required this.image,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        name: json["name"],
        image: json["image"],
      );
}
