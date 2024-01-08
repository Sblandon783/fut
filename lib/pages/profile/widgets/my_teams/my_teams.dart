import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/widgets/my_teams/my_team_card.dart';
import 'package:soccer/pages/profile/widgets/my_teams/my_teams_top.dart';

import '../../providers/provider_teams.dart';

class MyTeams extends StatefulWidget {
  const MyTeams({Key? key}) : super(key: key);

  @override
  MyTeamsState createState() => MyTeamsState();
}

class MyTeamsState extends State<MyTeams> {
  static const int addStatus = 1;
  static const int notExistTeamStatus = 2;
  static const int existInTeamStatus = 3;
  static const int existInvitationStatus = 4;
  final ProviderTeams _provider = ProviderTeams();

  @override
  void initState() {
    _getTeamsByPlayer();
    super.initState();
  }

  void _getTeamsByPlayer() => _provider.getTeamsByPlayer();

  @override
  Widget build(BuildContext context) => _generateContent();

  Widget _generateContent() => StreamBuilder(
      stream: _provider.teamsStream,
      builder: (BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? _generateCard(teams: snapshot.data!)
              : const Text("No estás en ningun equipo");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _generateCard({required List<TeamModel> teams}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: 320,
        height: 200.0,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyTeamsTop(onTap: _addTeamByPlayer),
                Flexible(
                  child: Center(
                    child: Container(
                      height: 100.0,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: teams.length,
                        itemBuilder: (context, index) => MyTeamCard(
                          team: teams[index],
                          exitTeam: _exitTeam,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addTeamByPlayer({required int idTeam}) async {
    Map<int, String> mapMessage = {
      addStatus: "Solicitud enviada",
      notExistTeamStatus: "El equipo buscado no existe",
      existInTeamStatus: "Ya perteneces a este equipo",
      existInvitationStatus: "Ya has enviado una solicitud a este equipo",
    };
    int status = await _provider.addTeamsByPlayer(idTeam: idTeam);

    _showSnackBar(message: mapMessage[status]!);
  }

  _showSnackBar({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _exitTeam({required int idTeam}) async =>
      await _provider.exitTeam(idTeam: idTeam);
}
