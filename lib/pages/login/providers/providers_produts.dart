import '../models/profile_model.dart';

class ProvidersProfile {
  late ProfileModel profile;
  ProvidersProfile();

  Map<String, dynamic> data = {
    "name": "Kenny Smith",
    "image":
        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "pets": [
      {
        'name': "Bella",
        'image':
            'https://p4.wallpaperbetter.com/wallpaper/659/867/634/puppies-dog-animals-wallpaper-preview.jpg',
      },
      {
        'name': "Coquito",
        'image':
            'https://www.topaula.com/wp-content/uploads/2016/06/conejos1.jpg',
      }
    ]
  };
  getProfile() {
    profile = ProfileModel.fromJson(data);
  }
}
