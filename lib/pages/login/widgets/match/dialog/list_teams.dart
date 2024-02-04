import 'package:flutter/material.dart';

import '../../../../profile/models/team_model.dart';
import '../../../../profile/providers/provider_teams.dart';
import '../../../../profile/widgets/my_teams/my_team_card.dart';

class ListTeams extends StatefulWidget {
  const ListTeams({
    super.key,
  });

  @override
  ListTeamsState createState() => ListTeamsState();
}

class ListTeamsState extends State<ListTeams> {
  final ProviderTeams _providerTeams = ProviderTeams();

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
        height: 250.0,
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
                          Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GridView.builder(
                                controller: null,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 100,
                                ),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TeamModel team = snapshot.data![index];
                                  return GestureDetector(
                                    onTap: () => _select(team: team),
                                    child: AbsorbPointer(
                                      child: MyTeamCard(
                                        team: team,
                                        exitTeam: _exitGroup,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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

  _exitGroup({required int idTeam}) {}
}
