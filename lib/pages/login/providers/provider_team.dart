import 'dart:async';

import 'package:soccer/pages/profile/models/team_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderTeam {
  ProviderTeam();

  final Supabase _supabase = Supabase.instance;

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
}
