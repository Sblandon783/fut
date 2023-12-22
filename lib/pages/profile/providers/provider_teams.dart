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
    print(response);
    TeamsModel teamResponse = TeamsModel.fromJson(response);
    _teams = teamResponse.teams;
    teamsSink(_teams);
    return;
  }
}
