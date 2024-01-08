import 'dart:async';

import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/activities_counters_model.dart';

class ProviderActivities {
  ProviderActivities();

  final UserPreferences _prefs = UserPreferences();
  final Supabase _supabase = Supabase.instance;

  ActivitiesCountersModel? counter;
  final _counterStreamController =
      StreamController<ActivitiesCountersModel>.broadcast();
  Function(ActivitiesCountersModel) get counterSink =>
      _counterStreamController.sink.add;
  Stream<ActivitiesCountersModel> get counterStream =>
      _counterStreamController.stream;

  Future getCounters() async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_activities_counters', params: {'_id_team': _prefs.teamId});

    ActivitiesCountersModel counterResponse =
        ActivitiesCountersModel.fromJson(response.first);
    counter = counterResponse;
    counterSink(counter!);
  }
}
