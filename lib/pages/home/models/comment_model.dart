class CommentModel {
  int id;
  int idPost;
  int idUser;
  String comment;
  String username;
  String userImage;
  String date;

  CommentModel({
    required this.id,
    required this.idPost,
    required this.idUser,
    required this.username,
    required this.userImage,
    required this.comment,
    required this.date,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        idPost: json["id_post"],
        idUser: json["id_user"],
        username: json["username"],
        userImage: json["user_image"],
        comment: json["comment"],
        date: json["date"],
      );
}
