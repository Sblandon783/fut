import 'dart:async';

import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../login/models/member_model.dart';

class ProviderProfile {
  ProviderProfile();
  final UserPreferences _prefs = UserPreferences();
  final Supabase _supabase = Supabase.instance;

  late MemberModel _member;

  final _memberStreamController = StreamController<MemberModel>.broadcast();
  Function(MemberModel) get memberSink => _memberStreamController.sink.add;
  Stream<MemberModel> get memberStream => _memberStreamController.stream;

  Future getMyProfile() async {
    final List<dynamic> response = await _supabase.client
        .from('player')
        .select(
            'id,name,number,position,date_match, attributes,is_captain, status')
        .eq('id', _prefs.userId);

    MemberModel memberResponse = MemberModel.fromJson(response.first);
    _member = memberResponse;
    memberSink(_member);
  }

  Future<bool> updateMyAttributes(
      {required Map<String, int> attributes}) async {
    await _supabase.client
        .from('player')
        .update({'attributes': attributes}).eq('id', _prefs.userId);

    return true;
  }

  updateMember({required MemberModel newMember}) async {
    await _supabase.client
        .from('player')
        .update({'status': newMember.status}).eq('id', _prefs.userId);

    _member = newMember;
    memberSink(_member);
  }
}
