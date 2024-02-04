import 'package:flutter/material.dart';
import 'package:soccer/pages/CustomWidgets/custom_loading.dart';
import 'package:soccer/pages/login/models/match_model.dart';
import 'package:soccer/pages/login/providers/provider_team.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/close_icon.dart';
import 'package:soccer/pages/login/widgets/match/match_card/match_card.dart';
import 'package:soccer/user_preferences.dart';

import '../../../home/provider/provider_matches.dart';
import '../../../login/models/field_notifier.dart';
import '../../../login/providers/provider_members.dart';

class CreateChallenge extends StatefulWidget {
  const CreateChallenge({super.key});

  @override
  CreateChallengeState createState() => CreateChallengeState();
}

class CreateChallengeState extends State<CreateChallenge> {
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));
  final ProviderMatches _providerMatches = ProviderMatches();
  final ProviderMembers _providerMembers = ProviderMembers();
  final ProviderTeam _providerTeam = ProviderTeam();
  final UserPreferences _prefs = UserPreferences();
  MatchModel _match = MatchModel.fromJson({});
  @override
  void initState() {
    super.initState();
    _calls();
  }

  _calls() async {
    await _providerTeam.getTeam(id: _prefs.teamId);
    await _providerMatches.getFields();

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String dateCurrent =
        "${date.toString().split(" ").first} ${_providerMatches.fields.first.hours.first}";

    _match = MatchModel.fromJson({
      'id_field': _providerMatches.fields.first.id,
      'date': dateCurrent,
      'image_team_one': _providerTeam.team.image,
    });

    setState(() {});
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 250.0,
      child: _providerMatches.fields.isEmpty
          ? const CustomLoading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CloseIcon(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Crear nuevo reto",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                MatchCard(
                  match: _match,
                  typeAlignNotifier: _typeAlignNotifier,
                  fields: _providerMatches.fields,
                  providerMembers: _providerMembers,
                  redirect: false,
                  createMatch: true,
                ),
                SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: _createChallenge,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(100.0, 35.0),
                    ),
                    child: const Text("CREAR RETO"),
                  ),
                ),
              ],
            ),
    );
  }

  void _createChallenge() async {
    if (_match.idSecondTeam == -1) {
      await _providerMatches.createMatch(match: _match);
      _close();
    } else {
      await _providerMatches.addChallenge(match: _match);
    }
  }

  _close() => Navigator.pop(context, true);
}
