import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../user_preferences.dart';
import '../models/table_position_model.dart';

class ProviderTablePositions {
  final Supabase _supabase = Supabase.instance;
  final UserPreferences _prefs = UserPreferences();

  List<TeamInfoModel> teams = [];
  final _teamsStreamController =
      StreamController<List<TeamInfoModel>>.broadcast();
  Function(List<TeamInfoModel>) get teamsSink =>
      _teamsStreamController.sink.add;
  Stream<List<TeamInfoModel>> get teamsStream => _teamsStreamController.stream;

  ProviderTablePositions();

  Future getTeams() async {
    final response = await _supabase.client.rpc('get_table_position');
    print(response);
    TablePositionModel goalersResponse = TablePositionModel.fromJson(response);
    teamsSink(goalersResponse.teams);
  }
}
