class ProfileModel {
  int id;
  String name;
  String image;
  String dateEntry;
  String emergencyContact;
  String contact;
  String email;
  String date;
  String nextDate;
  int type;
  int countPayments;
  int countRoutine;

  ProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.dateEntry,
    required this.emergencyContact,
    required this.contact,
    required this.email,
    required this.date,
    required this.nextDate,
    required this.type,
    required this.countPayments,
    required this.countRoutine,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] ?? -1,
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        dateEntry: json["date_entry"] ?? '',
        emergencyContact: json["emergency_contact"] ?? '',
        contact: json["contact"] ?? '',
        email: json["email"] ?? '',
        date: json["date"] ?? '',
        nextDate: json["next_date"] ?? '',
        type: json["type"] ?? 0,
        countPayments: json["count_payments"] ?? 0,
        countRoutine: json["count_routine"] ?? 0,
      );
}
