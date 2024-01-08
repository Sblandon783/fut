import 'dart:async';

import 'package:soccer/pages/login/models/field_model.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../login/models/match_model.dart';

class ProviderMatches {
  ProviderMatches();
  final Supabase _supabase = Supabase.instance;
  final UserPreferences _prefs = UserPreferences();

  List<MatchModel> matches = [];
  final _matchesStreamController = StreamController<MatchesModel>.broadcast();
  Function(MatchesModel) get matchesSink => _matchesStreamController.sink.add;
  Stream<MatchesModel> get matchesStream => _matchesStreamController.stream;

  List<FieldModel> fields = [];

  Future getMatches() async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_matches_by_team', params: {'_id_team': _prefs.teamId});

    MatchesModel matchesResponse = MatchesModel.fromJson(response);
    matches = matchesResponse.matches;
    matchesSink(matchesResponse);
  }

  Future getFields() async {
    final List<dynamic> response =
        await _supabase.client.from('field').select();

    FieldsModel fieldResponse = FieldsModel.fromJson(response);

    fields = fieldResponse.fields;
    //match = fieldResponse;
    //matchSink(fieldResponse);
  }

  Future createMatch({required MatchModel match}) async {
    await _supabase.client.from('match').insert({
      'id_team_one': _prefs.teamId,
      'id_align': match.idAlign,
      'id_field': match.idField,
      'date': match.parsedDate.toString(),
    });
  }
}
