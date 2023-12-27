import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/my_team_card.dart';

import 'providers/provider_teams.dart';

class MyTeams extends StatefulWidget {
  const MyTeams({Key? key}) : super(key: key);

  @override
  MyTeamsState createState() => MyTeamsState();
}

class MyTeamsState extends State<MyTeams> {
  final ProviderTeams _provider = ProviderTeams();

  @override
  void initState() {
    getTeamsByPlayer();
    super.initState();
  }

  void getTeamsByPlayer() => _provider.getTeamsByPlayer();

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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mis equipos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Container(
                      height: 100.0,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: teams.length,
                        itemBuilder: (context, index) =>
                            MyTeamCard(team: teams[index]),
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
}
