import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../user_preferences.dart';
import '../models/profile_model.dart';

class ProviderProfile {
  ProviderProfile();

  final Supabase _supabase = Supabase.instance;
  final UserPreferences _prefs = UserPreferences();

  final _profileStreamController = StreamController<ProfileModel>.broadcast();
  Function(ProfileModel) get profileSink => _profileStreamController.sink.add;
  Stream<ProfileModel> get profileStream => _profileStreamController.stream;

  getProfile() async {
    final int idUser = _prefs.userId;
    final List<dynamic> response = await _supabase.client
        .rpc('get_user_profile', params: {'_id_user': idUser});
    ProfileModel profile = ProfileModel.fromJson(response[0]);
    profileSink(profile);
  }
}
