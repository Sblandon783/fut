import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/models/activities_counters_model.dart';
import 'package:soccer/user_preferences.dart';

import '../profile/nav_bar/exit_button.dart';
import 'provider/provider_activities.dart';
import 'utils/activities_const.dart';
import 'widgets/card_activity/card_activity.dart';
import 'widgets/title_page.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  ActivitiesPageState createState() => ActivitiesPageState();
}

class ActivitiesPageState extends State<ActivitiesPage> {
  final ProviderActivities _provider = ProviderActivities();
  final UserPreferences _prefs = UserPreferences();
  @override
  void initState() {
    _provider.getCounters();
    super.initState();
  }

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
        ),
        backgroundColor: Colors.blue.shade700,
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() {
    return StreamBuilder(
        stream: _provider.counterStream,
        builder: (BuildContext context,
            AsyncSnapshot<ActivitiesCountersModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TitleActivities(),
                  CardActivity(
                    id: ActivitiesConst.idNewPlayers,
                    title: "Nuevos jugadores",
                    subTitle: "desean ser parte de equipo",
                    icon: Icons.person_add_alt_1_sharp,
                    count: snapshot.data!.newPlayers,
                    disabled: _prefs.teamId == -1,
                  ),
                  CardActivity(
                    id: ActivitiesConst.idNewChallenges,
                    title: "Nuevos retos",
                    subTitle: "para jugar con tu equipo",
                    icon: Icons.note_add_rounded,
                    count: snapshot.data!.newChallenges,
                    disabled: _prefs.teamId == -1,
                  ),
                  CardActivity(
                    id: ActivitiesConst.idAvailableTeams,
                    title: "Equipos disponibles",
                    subTitle: "ver información de otros equipos",
                    icon: Icons.sports_soccer_outlined,
                    count: snapshot.data!.teams,
                    disabled: false,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
