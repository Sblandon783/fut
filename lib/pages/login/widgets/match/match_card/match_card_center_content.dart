import 'package:flutter/material.dart';

class MatchCardCenterContent extends StatelessWidget {
  final bool isFinished;
  final int goalsTeamOne;
  final int goalsTeamSecond;

  const MatchCardCenterContent({
    super.key,
    required this.isFinished,
    required this.goalsTeamOne,
    required this.goalsTeamSecond,
  });
  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: Colors.grey.shade400,
      fontWeight: FontWeight.w900,
      fontSize: 20.0,
    );

    return isFinished
        ? Row(
            children: [
              Text(
                goalsTeamOne.toString(),
                style: style.copyWith(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(":", style: style),
              ),
              Text(
                goalsTeamSecond.toString(),
                style: style.copyWith(fontSize: 25),
              ),
            ],
          )
        : Text("VS", style: style.copyWith(color: Colors.black));
  }
}
