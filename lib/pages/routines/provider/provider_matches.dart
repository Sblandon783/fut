import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/matches_model.dart';

class ProviderMatches {
  final Supabase _supabase = Supabase.instance;

  List<MatchModel> matches = [];
  final _matchesStreamController =
      StreamController<List<MatchModel>>.broadcast();

  Function(List<MatchModel>) get matchesSink =>
      _matchesStreamController.sink.add;
  Stream<List<MatchModel>> get matchesStream => _matchesStreamController.stream;

  ProviderMatches();

  Future getMatches() async {
    final List<dynamic> response = await _supabase.client.rpc('get_all_match');
    print(response);
    MatchesModel matchesResponse = MatchesModel.fromJson(response);
    matchesSink(matchesResponse.teams);
  }
}
