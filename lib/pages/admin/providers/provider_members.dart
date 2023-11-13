import 'dart:async';

import 'package:soccer/pages/admin/models/members_model.dart';
import 'package:soccer/pages/admin/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderMembers {
  ProviderMembers();

  final Supabase _supabase = Supabase.instance;
  List<MemberModel> members = [];
  final _memberStreamController =
      StreamController<List<MemberModel>>.broadcast();

  Function(List<MemberModel>) get membersSink =>
      _memberStreamController.sink.add;
  Stream<List<MemberModel>> get membersStream => _memberStreamController.stream;

  Future getMembers() async {
    final List<dynamic> response =
        await Supabase.instance.client.from('player').select();
    MembersModel membersResponse = MembersModel.fromJson(response);

    members = membersResponse.teams;
    print(members.length);
    membersSink(members);
  }

  Future<bool> addMember({required ProfileModel member}) async {
    await _supabase.client.from('user').insert({
      'name': member.name,
      'image': member.image,
      'emergency_contact': member.emergencyContact,
      'contact': member.contact,
      'email': member.email,
    });

    return true;
  }
}
