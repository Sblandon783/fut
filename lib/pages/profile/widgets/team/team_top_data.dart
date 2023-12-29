import 'package:flutter/material.dart';

import '../../models/team_model.dart';

class TeamTopData extends StatelessWidget {
  final TeamModel team;

  const TeamTopData({super.key, required this.team});

  @override
  Widget build(BuildContext context) => _generateContent();

  Widget _generateContent() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.blue,
      height: 40.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _icon(
                  icon: Icons.thumb_up_alt_rounded,
                  text: team.winner.toString(),
                ),
                _icon(
                  icon: Icons.thumb_down_alt_rounded,
                  text: team.loose.toString(),
                ),
                _icon(
                  icon: Icons.sports_soccer_rounded,
                  text: team.equals.toString(),
                ),
                _icon(
                  icon: Icons.person,
                  text: team.totalMembers.toString(),
                ),
              ],
            ),
          ),
        ],
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
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
