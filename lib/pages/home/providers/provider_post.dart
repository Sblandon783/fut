import 'dart:async';

import 'package:intl/intl.dart';
import 'package:soccer/pages/home/models/comment_model.dart';
import 'package:soccer/pages/home/models/match_model.dart';
import 'package:soccer/pages/profile/models/pet_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../user_preferences.dart';
import '../models/post_model.dart';

class ProvidersHome {
  List<MatchModel> matches = [];
  final _matchesStreamController =
      StreamController<List<MatchModel>>.broadcast();
  Function(List<MatchModel>) get matchesSink =>
      _matchesStreamController.sink.add;
  Stream<List<MatchModel>> get matchesStream => _matchesStreamController.stream;

  List<PostModel> products = [];
  List<CommentModel> comments = [];
  final Supabase _supabase = Supabase.instance;
  final UserPreferences _prefs = UserPreferences();

  final _postStreamController = StreamController<List<PostModel>>.broadcast();
  Function(List<PostModel>) get postSink => _postStreamController.sink.add;
  Stream<List<PostModel>> get postStream => _postStreamController.stream;

  final _commentsStreamController =
      StreamController<List<CommentModel>>.broadcast();
  Function(List<CommentModel>) get commentsSink =>
      _commentsStreamController.sink.add;
  Stream<List<CommentModel>> get commentsStream =>
      _commentsStreamController.stream;

  ProvidersHome();

  Future getRoutines() async {
    final List<dynamic> response =
        await _supabase.client.from('routine').select();
    print(response);
    return;
    /*
    return matches.clear();
    matches = response
        .map((json) => MatchModel(
              id: json["id"],
              idTeamOne: json["id_team_one"],
              teamNameOne: json["team_name_one"],
              idTeamTwo: json["id_team_two"],
              teamNameTwo: json["team_name_two"],
              date: json["date"],
              isPlayed: json["is_played"],
            ))
        .toList();
    print("=======");
    print(matches.length);
    matchesSink(matches);
    */
  }

  Future<bool> createPost({required PostModel post}) async {
    await _supabase.client.from('post').insert(
        {'id_user': _prefs.userId, 'post': post.post, 'image': post.image});
    return true;
  }

  Future<bool> deletePost({required int idPost}) async {
    await _supabase.client.rpc('delete_post', params: {'_id_post': idPost});
    return true;
  }

//Comments
  Future getComments({required int idPost}) async {
    final List<dynamic> response = await _supabase.client
        .rpc('get_comments', params: {'_id_post': idPost});

    comments = response
        .map((json) => CommentModel(
              id: json["id"] ?? -1,
              idPost: json["id_post"] ?? -1,
              idUser: json["id_user"] ?? -1,
              username: json["username"] ?? '',
              userImage: json["user_image"] ?? '',
              comment: json["comment"] ?? '',
              date: json["date"] ?? '',
            ))
        .toList();
    commentsSink(comments);
  }

  Future<bool> addCommetPost(
      {required String comment, required int idPost}) async {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    final String date = formatter.format(now);
    final int idUser = _prefs.userId;

    await _supabase.client.rpc('add_comment', params: {
      '_id_user': idUser,
      '_id_post': idPost,
      '_comment': comment,
      '_date': date,
    });
    return true;
  }

  Future<bool> deleteCommetPost({required int idComment}) async {
    await _supabase.client
        .rpc('delete_comment', params: {'_id_comment': idComment});
    return true;
  }

  Future<bool> createPet({required PetModel pet}) async {
    await _supabase.client.from('pet').insert(
        {'id_user': _prefs.userId, 'name': pet.name, 'image': pet.image});
    return true;
  }
}
