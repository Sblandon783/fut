import 'package:flutter/material.dart';
import 'package:soccer/user_preferences.dart';

import '../models/matches_model.dart';

class CustomCardTeams extends StatelessWidget {
  final MatchModel match;
  final _endMatch = 'Partido Finalizados'; //'Final Del Partido';
  final _soonMatch = 'Partido Próximos'; //'Partido Próximo';
  final bool enabledTap;

  CustomCardTeams({super.key, required this.match, this.enabledTap = true});
  final Gradient _gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [
      0.01,
      0.4,
      0.5,
      0.6,
      0.9,
    ],
    colors: [
      Colors.purple,
      Colors.blue.shade600,
      Colors.blue.shade500,
      Colors.blue.shade600,
      Colors.purple,
    ],
  );
  final UserPreferences _prefs = UserPreferences();

  @override
  Widget build(BuildContext context) => _generateCardTeam(context);

  Widget _generateCardTeam(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 270.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: enabledTap ? _gradient : null,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 130.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            _generateContentCard(context),
          ],
        ),
      ),
    );
  }

  Widget _generateContentCard(BuildContext context) => Center(
        child: GestureDetector(
          onTap: () =>
              enabledTap && _prefs.isLogin ? _showAddResult(context) : null,
          child: SizedBox(
            width: 300.0,
            height: 220.0,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: _gradient,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: _generateText(
                          text: match.isPlayed ? _endMatch : _soonMatch,
                          fontSize: 15),
                    ),
                    const Spacer(),
                    _generateMatch(),
                    _generateDate(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _generateDate() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.only(top: 5.0),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 1.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _generateText(text: match.date),
              _generateText(text: '12:00'),
            ],
          ),
        ),
      );

  Widget _generateMatch() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _generateTeam(name: match.teamNameOne, image: match.teamImageOne),
            _generateResult(),
            _generateTeam(name: match.teamNameTwo, image: match.teamImageTwo),
          ],
        ),
      );

  Widget _generateTeam({required String name, required String image}) => Column(
        children: [
          Image(
            width: 90.0,
            height: 90.0,
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: _generateText(text: name, fontSize: 12.0),
          ),
        ],
      );

  Widget _generateResult() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _generateText(
            text: match.isPlayed ? match.goalsOneTeam.toString() : '-',
            fontSize: 30.0),
        match.isPlayed
            ? _generateText(text: ":", fontSize: 30.0)
            : const SizedBox(width: 10),
        _generateText(
            text: match.isPlayed ? match.goalsSecondTeam.toString() : '-',
            fontSize: 30.0),
      ],
    );
  }

  Widget _generateText({required String text, double fontSize = 12.0}) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      );

  _showAddResult(BuildContext context) {
    final MatchModel newMatch = MatchModel.copyObject(match);
    /*
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: AlertAddResult(match: newMatch),
          insetPadding: EdgeInsets.zero,
        );
      },
    );
    */
  }
}
