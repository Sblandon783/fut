import 'dart:async';

import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/match_model.dart';
import '../models/member_model.dart';

class ProviderMembers {
  ProviderMembers();
  final UserPreferences _prefs = UserPreferences();
  final Supabase _supabase = Supabase.instance;
  List<MemberModel> members = [];
  late MemberModel member;

  final _memberStreamController =
      StreamController<List<MemberModel>>.broadcast();
  Function(List<MemberModel>) get membersSink =>
      _memberStreamController.sink.add;
  Stream<List<MemberModel>> get membersStream => _memberStreamController.stream;

  final _matchStreamController = StreamController<MatchModel>.broadcast();
  Function(MatchModel) get matchSink => _matchStreamController.sink.add;
  Stream<MatchModel> get matchStream => _matchStreamController.stream;

  Future getMembers() async {
    final List<dynamic> response = await _supabase.client
        .from('player')
        .select('id,name,number,position,date_match');
    MembersModel membersResponse = MembersModel.fromJson(response);
    if (membersResponse.members.isNotEmpty) {
      member = membersResponse.members
          .firstWhere((element) => element.name == _prefs.userName);

      membersResponse.members.removeWhere((element) => !element.included);
      members = membersResponse.members;
      members.removeWhere((element) => element.name == member.name);
      if (member.included) {
        members.add(member);
      }
      members = members.reversed.toList();
    }

    membersSink(members);
  }

  Future<bool> addMe() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    await _supabase.client
        .from('player')
        .update({'date_match': date.toString()}).eq('name', _prefs.userName);

    return true;
  }

  Future<bool> createAccount({
    required String name,
    required String password,
    required int number,
    required int position,
  }) async {
    await _supabase.client.from('player').insert({
      'name': name,
      'number': number,
      'position': position,
      'password': password
    });

    return true;
  }

  Future<bool> login({
    required String name,
    required String password,
  }) async {
    final List<dynamic> response = await _supabase.client
        .from('player')
        .select()
        .eq(
          "name",
          name,
        )
        .eq("password", password);

    return response.isNotEmpty;
  }

  Future<bool> deleteMe() async {
    await _supabase.client
        .from('player')
        .update({'date_match': null}).eq('name', _prefs.userName);

    members.removeWhere((element) => element.name == _prefs.userName);
    membersSink(members);
    member.included = false;
    return false;
  }

  Future getMatch() async {
    final List<dynamic> response =
        await _supabase.client.from('match').select();
    MatchModel matchResponse = MatchModel.fromJson(response.first);
    matchSink(matchResponse);
  }

  isIncluded() => member.included;
}
