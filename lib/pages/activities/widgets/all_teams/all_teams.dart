import 'package:flutter/material.dart';

import '../../../profile/models/team_model.dart';
import '../../../profile/nav_bar/exit_button.dart';
import '../../../profile/nav_bar/leading_button.dart';
import '../../../profile/providers/provider_teams.dart';
import '../../../profile/widgets/my_teams/my_team_card.dart';
import 'title_all_teams.dart';

class AllTeams extends StatefulWidget {
  const AllTeams({Key? key}) : super(key: key);

  @override
  AllTeamsState createState() => AllTeamsState();
}

class AllTeamsState extends State<AllTeams> {
  final ProviderTeams _provider = ProviderTeams();
  @override
  void initState() {
    _getAllTeams();
    super.initState();
  }

  void _getAllTeams() => _provider.getAllTeams();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [ExitButton()],
          leading: const LeadingButton(),
        ),
        backgroundColor: Colors.blue.shade700,
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleAllTeams(),
          StreamBuilder(
              stream: _provider.teamsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<TeamModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data != null
                      ? Center(
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
                              return MyTeamCard(
                                team: team,
                                exitTeam: _exitGroup,
                              );
                            },
                          ),
                        )
                      : const Text("No estás en ningun equipo");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })

          /*
          CardActivities(
            id: 1,
            title: "Nuevos jugadores",
            subTitle: "desean ser parte de equipo",
            icon: Icons.person_add_alt_1_sharp,
          ),
          CardActivities(
            id: 2,
            title: "Nuevos retos",
            subTitle: "para jugar con tu equipo",
            icon: Icons.note_add_rounded,
          ),
          CardActivities(
            id: 3,
            title: "Equipos disponibles",
            subTitle: "ver información de otros equipos",
            icon: Icons.sports_soccer_outlined,
          ),
          */
        ],
      ),
    );
  }

  _exitGroup({required int idTeam}) {}
}
