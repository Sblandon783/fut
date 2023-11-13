class ProfileModel {
  final int id;
  final String name;
  final String image;
  final String dateEntry;
  final String emergencyContact;
  final String email;
  final String date;
  final String nextDate;
  final int type;
  final int countPayments;
  final int countRoutine;

  ProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.dateEntry,
    required this.emergencyContact,
    required this.email,
    required this.date,
    required this.nextDate,
    required this.type,
    required this.countPayments,
    required this.countRoutine,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        image: _getImage(json["image"]),
        dateEntry: json["date_entry"] ?? '',
        emergencyContact: json["emergency_contact"] ?? '',
        email: json["email"],
        date: json["date"],
        nextDate: json["next_date"],
        type: json["type"],
        countPayments: json["count_payments"],
        countRoutine: json["count_routine"],
      );
}

String _getImage(dynamic image) {
  if (image == null || image.isEmpty) {
    return 'https://hnkccsemqnrobnjqxufs.supabase.co/storage/v1/object/public/Images/profile_icon.jpg';
  } else {
    return image;
  }
}
