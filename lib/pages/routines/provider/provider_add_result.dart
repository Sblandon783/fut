import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/goalers_model.dart';

class ProviderAddResult {
  final Supabase _supabase = Supabase.instance;
  List<GoalerModel> goalers = [];
  //TEAM ONE
  final _playersOneStreamController =
      StreamController<List<GoalerModel>>.broadcast();
  Function(List<GoalerModel>) get playersOneSink =>
      _playersOneStreamController.sink.add;
  Stream<List<GoalerModel>> get playersOneStream =>
      _playersOneStreamController.stream;
  //TEAM TWO
  final _playersTwoStreamController =
      StreamController<List<GoalerModel>>.broadcast();
  Function(List<GoalerModel>) get playersTwoSink =>
      _playersTwoStreamController.sink.add;
  Stream<List<GoalerModel>> get playersTwoStream =>
      _playersTwoStreamController.stream;

  ProviderAddResult();

  void setPlayerOneTeam({required int idTeam}) async {
    playersOneSink(await getPlayers(idTeam: idTeam));
  }

  void setPlayerTwoTeam({required int idTeam}) async {
    playersTwoSink(await getPlayers(idTeam: idTeam));
  }

  Future<List<GoalerModel>> getPlayers({required int idTeam}) async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_player_by_team', params: {'_id_team': idTeam});
    GoalersModel goalersResponse = GoalersModel.fromJson(response);
    return goalersResponse.goalers;
  }
}
