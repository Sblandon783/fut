import 'package:flutter/material.dart';
import 'package:soccer/pages/home/provider/provider_match.dart';
import 'package:soccer/pages/login/models/match_model.dart';
import 'package:soccer/pages/profile/widgets/performance/performance_card.dart';

class PerformanceByTeam extends StatefulWidget {
  final int id;
  const PerformanceByTeam({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  PerformanceByTeamState createState() => PerformanceByTeamState();
}

class PerformanceByTeamState extends State<PerformanceByTeam> {
  final ProviderMatch _providerMatch = ProviderMatch();
  @override
  void initState() {
    super.initState();
    _providerMatch.getMatches(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        color: Colors.white,
        height: 326.0,
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
    return StreamBuilder(
        stream: _providerMatch.matchesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MatchModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data != null
                ? Flexible(
                    child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 70, // here set custom Height You Want
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      MatchModel match = snapshot.data![index];
                      return PerformanceCard(
                        name: match.name,
                        goalsOneTeam: match.teamOneGoals,
                        goalsSecondTeam: match.teamSecondGoals,
                      );
                    },
                  )

                    /*ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: _generateMatches(
                        matches: snapshot.data ?? [],
                      ),
                    ),
                    */
                    )
                : const SizedBox.shrink();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  List<Widget> _generateMatches({required List<MatchModel> matches}) {
    return matches.map((match) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: PerformanceCard(
          name: match.name,
          goalsOneTeam: match.teamOneGoals,
          goalsSecondTeam: match.teamSecondGoals,
        ),
      );
    }).toList();
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
