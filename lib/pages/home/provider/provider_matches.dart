import 'dart:async';

import 'package:soccer/pages/login/models/field_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../login/models/match_model.dart';

class ProviderMatches {
  ProviderMatches();
  final Supabase _supabase = Supabase.instance;

  List<MatchModel> matches = [];
  final _matchesStreamController = StreamController<MatchesModel>.broadcast();
  Function(MatchesModel) get matchesSink => _matchesStreamController.sink.add;
  Stream<MatchesModel> get matchesStream => _matchesStreamController.stream;

  List<FieldModel> fields = [];

  Future getMatches() async {
    final List<dynamic> response =
        await _supabase.client.from('match').select();
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
}
