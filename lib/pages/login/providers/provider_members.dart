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
  late MemberModel _member;
  MatchModel? match;

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
      _member = membersResponse.members
          .firstWhere((element) => element.name == _prefs.userName);

      //membersResponse.members.removeWhere((element) => !element.included);
      members = membersResponse.members;
      members.removeWhere((element) => element.name == _member.name);
      if (_member.included) {
        members.add(_member);
      }
      if (match != null) {
        for (var i = 0; i < members.length; i++) {
          if (match!.assistants.containsKey(members[i].id)) {
            members[i].setPositionNew(pos: match!.assistants[members[i].id]!);
            members[i].titular = true;
          }
        }
        for (var i = 0; i < members.length; i++) {
          if (match!.substitutes.containsKey(members[i].id)) {
            members[i].titular = false;
            members[i].added = true;
          }
        }
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
    _member.included = false;
    return false;
  }

  Future getMatch() async {
    final List<dynamic> response =
        await _supabase.client.from('match').select();
    MatchModel matchResponse = MatchModel.fromJson(response.first);
    match = matchResponse;
    matchSink(matchResponse);
  }

  isIncluded() => _member.included;

  updateMember(
      {required MemberModel newMember, required MemberModel oldMember}) {
    List<MemberModel> list = members.map((member) {
      if (member.id == newMember.id) {
        newMember.added = false;
        newMember.titular = true;
        return newMember;
      } else if (oldMember.id == member.id) {
        member.titular = false;
      }
      member.added = false;
      return member;
    }).toList();

    membersSink(list);
  }

  Future<bool> saveAlign({required List<MemberModel> members}) async {
    List<String> listAssistants = [];
    List<String> listSubstitutes = [];
    Map<int, int> mapAssistants = {};
    Map<int, int> mapSubstitutes = {};
    for (var i = 0; i < members.length; i++) {
      if (members[i].titular) {
        listAssistants.add('${members[i].id}-${members[i].idPositionNew}');
        mapAssistants[members[i].id] = members[i].idPositionNew;
      } else {
        listSubstitutes.add('${members[i].id}-${members[i].idPositionNew}');
        mapSubstitutes[members[i].id] = members[i].idPositionNew;
      }
    }

    match!.assistants = mapAssistants;
    match!.substitutes = mapSubstitutes;

    return await _supabase.client
        .from('match')
        .update({
          'list_assistants': listAssistants,
          'list_substitutes': listSubstitutes
        })
        .eq('id', 1)
        .then((value) => true);
  }

  Future<void> saveMatch({required MatchModel match}) async {
    return await _supabase.client
        .from('match')
        .update({
          'name_field': match.name,
          'date': match.parsedDate.toString(),
        })
        .eq('id', 1)
        .then((value) => true);
  }

  get myIdMember => _member.id;
}
