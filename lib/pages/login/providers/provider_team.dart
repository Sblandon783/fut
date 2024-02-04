import 'dart:async';

import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/user_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderTeam {
  ProviderTeam();

  final Supabase _supabase = Supabase.instance;
  final UserPreferences _prefs = UserPreferences();

  late TeamModel team;
  final _teamStreamController = StreamController<TeamModel>.broadcast();
  Function(TeamModel) get teamSink => _teamStreamController.sink.add;
  Stream<TeamModel> get teamStream => _teamStreamController.stream;

  Future getTeam({required int id}) async {
    final List<dynamic> response =
        await _supabase.client.from('team').select().eq("id", id);

    TeamModel teamResponse = TeamModel.fromJson(response.first);
    team = teamResponse;
    teamSink(teamResponse);
  }

  Future exitTeam({required int idTeam}) async {
    await _supabase.client
        .from('user_team')
        .delete()
        .eq('id_user', _prefs.userId)
        .eq('id_team', idTeam);
  }

  Future addTeam({required int idTeam}) async {
    await _supabase.client
        .from('user_team')
        .insert({'id_user': _prefs.userId, 'id_team': idTeam});
    await updateTeam(id: idTeam);
  }

  Future<bool> updateTeam({required int id}) async {
    await _supabase.client
        .from('player')
        .update({'id_team': id}).eq('id', _prefs.userId);
    return true;
  }
}
