import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../providers/provider_members.dart';

class MatchInfo extends StatefulWidget {
  const MatchInfo({super.key});

  @override
  MatchInfoState createState() => MatchInfoState();
}

class MatchInfoState extends State<MatchInfo> {
  final _provider = ProviderMembers();

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  void _getMatch() async => _provider.getMatch();

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: _provider.matchStream,
      builder: (BuildContext context, AsyncSnapshot<MatchModel> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.7, 0.8, 0.9],
                        colors: [
                          Colors.purple,
                          Color.fromARGB(255, 32, 129, 209),
                          Color.fromARGB(255, 32, 129, 209),
                          Color.fromARGB(255, 32, 129, 209),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _generateRow(
                              icon: Icons.calendar_month_rounded,
                              text: snapshot.data!.date,
                            ),
                            _generateRow(
                              icon: Icons.timer,
                              text: snapshot.data!.hour,
                            ),
                          ],
                        ),
                        _generateRow(
                          icon: Icons.location_on_outlined,
                          text: snapshot.data!.name,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Row _generateRow({required IconData icon, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }
}
