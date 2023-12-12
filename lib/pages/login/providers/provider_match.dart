import 'dart:async';

import 'package:soccer/pages/login/models/field_model.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/match_model.dart';

class ProviderMatch {
  ProviderMatch();

  final UserPreferences _prefs = UserPreferences();
  final Supabase _supabase = Supabase.instance;

  MatchModel? match;
  final _matchStreamController = StreamController<MatchModel>.broadcast();
  Function(MatchModel) get matchSink => _matchStreamController.sink.add;
  Stream<MatchModel> get matchStream => _matchStreamController.stream;

  late FieldsModel fields;

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

  Future getMatch() async {
    final List<dynamic> response =
        await _supabase.client.from('match').select();

    MatchModel matchResponse = MatchModel.fromJson(response.first);
    match = matchResponse;
    matchSink(matchResponse);
  }

  Future getFields() async {
    final List<dynamic> response =
        await _supabase.client.from('field').select();

    FieldsModel fieldResponse = FieldsModel.fromJson(response);

    fields = fieldResponse;
    //match = fieldResponse;
    //matchSink(fieldResponse);
  }
}
