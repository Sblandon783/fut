import 'package:flutter/material.dart';

import '../profile/nav_bar/exit_button.dart';
import 'widgets/card_activities.dart';
import 'widgets/title_page.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  ActivitiesPageState createState() => ActivitiesPageState();
}

class ActivitiesPageState extends State<ActivitiesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Activities");
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          TitleActivities(),
          CardActivities(
            title: "Nuevos jugadores",
            subTitle: "desean ser parte de equipo",
            icon: Icons.person_add_alt_1_sharp,
          ),
          CardActivities(
            title: "Nuevos retos",
            subTitle: "para jugar con tu equipo",
            icon: Icons.note_add_rounded,
          ),
          CardActivities(
            title: "Equipos disponibles",
            subTitle: "ver información de otros equipos",
            icon: Icons.sports_soccer_outlined,
          ),
        ],
      ),
    );
  }
}
