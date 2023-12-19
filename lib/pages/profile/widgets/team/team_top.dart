import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/widgets/team/team_top_data.dart';

import '../../models/team_model.dart';

class TeamTop extends StatefulWidget {
  final TeamModel team;
  const TeamTop({Key? key, required this.team}) : super(key: key);

  @override
  TeamTopState createState() => TeamTopState();
}

class TeamTopState extends State<TeamTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _generateContent();

  Widget _generateContent() {
    const BorderRadius radius = BorderRadius.only(
      bottomLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 210.0,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //const Background(),

            Container(
              width: double.maxFinite,
              height: 140.0,
              decoration: const BoxDecoration(
                borderRadius: radius,
                color: Colors.white,
              ),
              child: _generateCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateCard() {
    return SizedBox(
      width: 200.0,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: SizedBox(
                height: 90.0,
                width: 90.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: const Image(
                    height: double.infinity,
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                "NotFap",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateData() {
    BoxDecoration decoration = const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10.0),
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: 55.0,
        decoration: decoration,
        child: Row(
          children: [
            _icon(
              icon: Icons.thumb_up_alt_rounded,
              text: widget.team.winner.toString(),
            ),
            _icon(
              icon: Icons.thumb_down_alt_rounded,
              text: widget.team.loose.toString(),
            ),
            _icon(
              icon: Icons.sports_soccer_rounded,
              text: widget.team.equals.toString(),
            ),
            _icon(
              icon: Icons.person,
              text: widget.team.totalMembers.toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget _icon({required IconData icon, required String text}) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
