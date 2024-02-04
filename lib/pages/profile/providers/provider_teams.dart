import 'dart:async';

import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderTeams {
  ProviderTeams();
  final UserPreferences _prefs = UserPreferences();
  final Supabase _supabase = Supabase.instance;

  List<TeamModel> _teams = [];

  final _teamsStreamController = StreamController<List<TeamModel>>.broadcast();
  Function(List<TeamModel>) get teamsSink => _teamsStreamController.sink.add;
  Stream<List<TeamModel>> get teamsStream => _teamsStreamController.stream;

  Future<bool> updateMyAttributes(
      {required Map<String, int> attributes}) async {
    await _supabase.client
        .from('player')
        .update({'attributes': attributes}).eq('id', _prefs.userId);

    return true;
  }

  Future<void> getTeamsByPlayer() async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_team_by_player', params: {'_id_user': _prefs.userId});

    TeamsModel teamResponse = TeamsModel.fromJson(response);
    _teams = teamResponse.teams;
    teamsSink(_teams);
    return;
  }

  Future<void> getAllTeams() async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_team_by_player', params: {'_id_user': -1});

    TeamsModel teamResponse = TeamsModel.fromJson(response);
    _teams = teamResponse.teams;
    teamsSink(_teams);
    return;
  }

  Future<int> addTeamsByPlayer({required int idTeam}) async {
    final List<dynamic> response = await _supabase.client.rpc(
        'add_players_by_team',
        params: {'_id_team': idTeam, '_id_player': _prefs.userId});

    return response.first['status'] ?? false;
  }

  Future<void> exitTeam({required int idTeam}) async {
    _teams.removeWhere((team) => team.id == idTeam);
    teamsSink(_teams);
  }

  Future<void> getAllTeamsChallenge() async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_team_by_player', params: {'_id_user': -1});

    TeamsModel teamResponse = TeamsModel.fromJson(response);

    _teams = teamResponse.teams;
    _teams.removeWhere((t) => t.id == _prefs.teamId);
    teamsSink(_teams);
    return;
  }
}
