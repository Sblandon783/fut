import 'package:flutter/material.dart';
import 'package:soccer/pages/home/provider/provider_match.dart';
import 'package:soccer/pages/login/models/match_model.dart';
import 'package:soccer/pages/profile/widgets/performance/performance_card.dart';

class PerformanceByTeam extends StatefulWidget {
  final ProviderMatch provider;
  const PerformanceByTeam({Key? key, required this.provider}) : super(key: key);

  @override
  PerformanceByTeamState createState() => PerformanceByTeamState();
}

class PerformanceByTeamState extends State<PerformanceByTeam> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        color: Colors.white,
        height: 426.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _generateContent(),
          ],
        ),
      ),
    );
  }

  Widget _generateContent() {
    return widget.provider.matches.isNotEmpty
        ? Flexible(
            child: GridView.builder(
              controller: null,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 70, // here set custom Height You Want
              ),
              shrinkWrap: false,
              itemCount: widget.provider.matches.length > 6
                  ? 6
                  : widget.provider.matches.length,
              itemBuilder: (BuildContext context, int index) {
                MatchModel match = widget.provider.matches[index];
                return PerformanceCard(
                  name: match.name,
                  goalsOneTeam: match.teamOneGoals,
                  goalsSecondTeam: match.teamSecondGoals,
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Redimiento",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 17.0,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
