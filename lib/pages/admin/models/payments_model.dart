class PaymentsModel {
  List<PaymentModel> members;

  PaymentsModel({required this.members});

  factory PaymentsModel.fromJson(dynamic response) => PaymentsModel(
        members: response.isNotEmpty
            ? List<PaymentModel>.from(
                response.map((x) => PaymentModel.fromJson(x)))
            : [],
      );
}

class PaymentModel {
  int id;
  int idUser;
  String name;
  String image;
  String date;
  String nextDate;
  int type;

  PaymentModel(
      {required this.id,
      required this.idUser,
      required this.name,
      required this.image,
      required this.date,
      required this.nextDate,
      required this.type});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
      id: json["id"],
      idUser: json["id_user"],
      name: json["name"],
      image: _getImage(json["image"]),
      date: _getDate(json["date"]),
      nextDate: _getDate(json["next_date"]),
      type: json["type"]);
}

String _getImage(dynamic image) {
  if (image == null || image.isEmpty) {
    return 'https://hnkccsemqnrobnjqxufs.supabase.co/storage/v1/object/public/Images/profile_icon.jpg';
  } else {
    return image;
  }
}

String _getDate(dynamic date) {
  if (date == null) {
    return '';
  } else {
    String newDate = date;
    return newDate.split('T').first;
  }
}
