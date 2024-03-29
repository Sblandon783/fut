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
  int _memberStatus = 2;

  MatchModel? match;

  final _memberStreamController =
      StreamController<List<MemberModel>>.broadcast();
  Function(List<MemberModel>) get membersSink =>
      _memberStreamController.sink.add;
  Stream<List<MemberModel>> get membersStream => _memberStreamController.stream;

  final _matchStreamController = StreamController<MatchModel>.broadcast();
  Function(MatchModel) get matchSink => _matchStreamController.sink.add;
  Stream<MatchModel> get matchStream => _matchStreamController.stream;

  Future getMembers({
    required int idMvp,
    bool normalGet = false,
    int teamId = 0,
  }) async {
    final int id = teamId == 0 ? _prefs.teamId : teamId;
    final List<dynamic> response = await _supabase.client
        .rpc('get_players_by_team', params: {'_id_team': id});
    MembersModel membersResponse = MembersModel.fromJson(response);

    if (membersResponse.members.isNotEmpty) {
      getListMembers(
        membersCurrents: membersResponse.members,
        idMvp: idMvp,
        normalGet: normalGet,
      );
    } else {
      membersSink([]);
    }
  }

  Future getMembersInvitation() async {
    final List<dynamic> response = await _supabase.client.rpc(
        'get_players_by_team_invitation',
        params: {'_id_team': _prefs.teamId});
    MembersModel membersResponse = MembersModel.fromJson(response);

    if (membersResponse.members.isNotEmpty) {
      getListMembers(
        membersCurrents: membersResponse.members,
        idMvp: -1,
        normalGet: true,
      );
    } else {
      membersSink([]);
    }
  }

  Map<int, String> getMembersMap() {
    Map<int, String> map = {};
    for (var member in members) {
      map[member.id] = member.name;
    }

    return map;
  }

  getListMembers({
    required List<MemberModel> membersCurrents,
    required int idMvp,
    required bool normalGet,
  }) {
    if (!normalGet) {
      _member = membersCurrents
          .firstWhere((element) => element.name == _prefs.userName);

      members = membersCurrents;
      members.removeWhere((element) => element.name == _member.name);

      if (_member.included) {
        members.add(_member);
      }

      if (match != null) {
        for (var i = 0; i < members.length; i++) {
          members[i].goals = 1;
          if (match!.assistants.containsKey(members[i].id)) {
            members[i].setPositionNew(pos: match!.assistants[members[i].id]!);
            members[i].titular = true;
            members[i].included = true;
          }
        }
        for (var i = 0; i < members.length; i++) {
          members[i].goals = 1;
          if (match!.substitutes.containsKey(members[i].id)) {
            members[i].titular = false;
            members[i].added = true;
            members[i].included = true;
            members[i].goals = 1;
          }
        }
      }

      if (match!.substitutes.containsKey(_member.id) &&
          !members.contains(_member)) {
        _member.titular = false;
        _member.added = true;
        _member.included = true;
        members.add(_member);
      }

      membersCurrents.removeWhere((element) => !element.included);
      if (match != null) {
        for (var element in membersCurrents) {
          print(element.id);
          print(match!.listGoals);
          print(match!.listGoals.containsKey(element.id));
          if (match!.listGoals.containsKey(element.id.toString())) {
            element.goals = match!.listGoals[element.id.toString()];
          }
        }
      }
      _prefs.userId = _member.id;
      members = membersCurrents;
      members = members.reversed.toList();

      for (var element in membersCurrents) {
        if (element.id == idMvp) {
          element.isMPV = true;
          break;
        }
      }
    } else {
      members = membersCurrents;
      for (var i = 0; i < members.length; i++) {
        if (members[i].id == _prefs.userId) {
          _memberStatus = 1;
          break;
        }
      }
    }

    membersSink(members);
  }

  Future<bool> updateAssistants(
      {required int idMatch, required bool isAdd}) async {
    List<String> listSubstitutes = [];
    Map<int, int> mapSubstitutes = {};

    for (var i = 0; i < members.length; i++) {
      if (!members[i].titular && (isAdd && members[i].id == _prefs.userId)) {
        listSubstitutes.add('${members[i].id}/${members[i].idPositionNew}');
        mapSubstitutes[members[i].id] = members[i].idPositionNew;
      }
    }
    if (isAdd) {
      listSubstitutes.add('${_prefs.userId}/-1');
      mapSubstitutes[_prefs.userId] = -1;
      match!.substitutes = mapSubstitutes;
      members.add(_member);
      getListMembers(membersCurrents: members, idMvp: -1, normalGet: false);
    } else {
      members.removeWhere((element) => element.name == _prefs.userName);
      membersSink(members);
      _member.included = false;
      match!.substitutes = mapSubstitutes;
    }

    return await _supabase.client
        .from('match')
        .update({
          'list_substitutes': listSubstitutes,
        })
        .eq('id', idMatch)
        .then((value) => isAdd);
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

    print("sign up");

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
    print(response);
    if (response.isNotEmpty) {
      _prefs.userId = response.first["id"] ?? -1;
      _prefs.teamId = response.first["id_team"] ?? -1;
    }
    return response.isNotEmpty;
  }

  Future<bool> deleteMe({required int idMatch}) async {
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

  Future<bool> saveAlign(
      {required List<MemberModel> members,
      required int idField,
      required int idAlign}) async {
    List<String> listAssistants = [];
    List<String> listSubstitutes = [];
    Map<int, int> mapAssistants = {};
    Map<int, int> mapSubstitutes = {};
    for (var i = 0; i < members.length; i++) {
      if (members[i].titular) {
        listAssistants.add('${members[i].id}/${members[i].idPositionNew}');
        mapAssistants[members[i].id] = members[i].idPositionNew;
      } else {
        listSubstitutes.add('${members[i].id}/${members[i].idPositionNew}');
        mapSubstitutes[members[i].id] = members[i].idPositionNew;
      }
    }

    match!.assistants = mapAssistants;
    match!.substitutes = mapSubstitutes;

    return await _supabase.client
        .from('match')
        .update({
          'list_assistants': listAssistants,
          'list_substitutes': listSubstitutes,
          'id_field': idField,
          'id_align': idAlign,
        })
        .eq('id', 1)
        .then((value) => true);
  }

  Future<void> saveMatch({
    required MatchModel match,
  }) async {
    return await _supabase.client
        .from('match')
        .update({
          'id_field': match.idField,
          'date': match.parsedDate.toString(),
          'is_finished': match.isFinished,
          'team_1_goals': match.teamOneGoals,
          'team_2_goals': match.teamSecondGoals,
        })
        .eq('id', match.id)
        .then((value) => true);
  }

  Future<bool> saveMatchEnd({
    required MatchModel match,
    required Map<dynamic, dynamic> goals,
  }) async {
    return await _supabase.client
        .from('match')
        .update({
          'id_field': match.idField,
          'date': match.parsedDate.toString(),
          'is_finished': match.isFinished,
          'team_1_goals': match.teamOneGoals,
          'team_2_goals': match.teamSecondGoals,
          'list_goals': goals,
        })
        .eq('id', match.id)
        .then((value) => true)
        .catchError((e) => false);
  }

  Future<void> updateMPV(
      {required MatchModel match, required int newVote}) async {
    List<String> listMVP = [];
    match.mapMVP.forEach((key, value) => listMVP.add('$key-$value'));
    listMVP.add('${_prefs.userId}-$newVote');

    return await _supabase.client
        .from('match')
        .update({
          'list_mvp': listMVP,
        })
        .eq('id', match.id)
        .then((value) => true);
  }

  Future<bool> endMatch(
      {required bool isFinished, required int idMatch}) async {
    await _supabase.client
        .from('match')
        .update({'isFinished': !isFinished, "list_mvp": ""}).eq('id', idMatch);

    return true;
  }

  Future<void> accepteMember({required int idMember}) async {
    await _supabase.client.from('user_team').insert({
      'id_user': idMember,
      'id_team': _prefs.teamId,
    });

    await deleteMember(idMember: idMember);

    return;
  }

  Future deleteMember({required int idMember}) async {
    await _supabase.client
        .from('user_team_invitation')
        .delete()
        .eq('id_user', idMember)
        .eq('id_team', _prefs.teamId);
    members.removeWhere((member) => member.id == idMember);
    membersSink(members);
  }

  get myIdMember => _member.id;

  set setMemberStatus(int value) => _memberStatus = value;
  get memberStatus => _memberStatus;
}
