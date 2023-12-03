import 'package:flutter/material.dart';

class MatchTopContent extends StatelessWidget {
  final bool myTeamWin;

  const MatchTopContent({super.key, required this.myTeamWin});
  @override
  Widget build(BuildContext context) {
    return Text(
      myTeamWin ? "GANADO" : "DERROTA",
      style: TextStyle(
        color: myTeamWin ? Colors.green : Colors.red,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
