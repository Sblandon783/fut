class MembersModel {
  List<MemberModel> teams;

  MembersModel({required this.teams});

  factory MembersModel.fromJson(dynamic response) => MembersModel(
        teams: response.isNotEmpty
            ? List<MemberModel>.from(
                response.map((x) => MemberModel.fromJson(x)))
            : [],
      );
}

class MemberModel {
  int id;
  String name;
  String image;

  MemberModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        image: _getImage(json["image"]),
      );
}

String _getImage(dynamic image) {
  if (image == null || image.isEmpty) {
    return 'https://hnkccsemqnrobnjqxufs.supabase.co/storage/v1/object/public/Images/profile_icon.jpg';
  } else {
    return image;
  }
}
