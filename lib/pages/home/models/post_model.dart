class PostModel {
  int idUser;
  String username;
  String userImage;
  String post;
  int idPost;
  String image;
  int countLike;
  int countComment;
  bool isLiKed;

  PostModel({
    this.idUser = -1,
    this.username = "",
    this.userImage = "",
    this.image = "",
    this.post = "",
    this.idPost = -1,
    this.countLike = 0,
    this.countComment = 0,
    this.isLiKed = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        idUser: json["user_id"],
        username: json["username"],
        userImage: json["user_image"],
        post: json["post"],
        idPost: json["post_id"],
        image: json["image"],
        countLike: json["like"],
        countComment: json["comment"],
        isLiKed: json["is_liked"],
      );
}
