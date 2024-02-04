import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/match_model.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/close_icon.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/end_match_players.dart';

import '../../../../../profile/models/team_model.dart';
import '../../../../../profile/providers/provider_teams.dart';
import '../../../../models/member_model.dart';
import '../../match_card/match_container.dart';
import 'list_members_dialog.dart';

class EndMatchDialog extends StatefulWidget {
  final MatchModel match;
  final List<MemberModel> members;
  const EndMatchDialog({super.key, required this.match, required this.members});

  @override
  EndMatchDialogState createState() => EndMatchDialogState();
}

class EndMatchDialogState extends State<EndMatchDialog> {
  final ProviderTeams _providerTeams = ProviderTeams();

  final TextEditingController _secondTeamGoalsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _calls();
  }

  _calls() async {
    await _providerTeams.getAllTeamsChallenge();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180.0,
        height: 350.0,
        child: StreamBuilder(
            stream: _providerTeams.teamsStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<TeamModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CloseIcon(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MatchContainer(match: widget.match),
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: EndMatchPlayers(
                                  match: widget.match,
                                  members: widget.members,
                                  update: () => setState(() {})),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, widget.match);
                              },
                              child: const Text("     Guardar    "))
                        ],
                      )
                    : const Text("No estás en ningun equipo");
              } else {
                return const Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }

  void _select({required TeamModel team}) {
    print("object");
    Navigator.pop(context, team);
  }
}
