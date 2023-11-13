import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/provider/provider_matches.dart';
import 'package:soccer/pages/routines/widgets/custom_card_teams.dart';

import '../../../CustomWidgets/custom_button_exit.dart';
import '../../models/matches_model.dart';

class MatchesView extends StatefulWidget {
  const MatchesView({Key? key}) : super(key: key);

  @override
  MatchesViewState createState() => MatchesViewState();
}

class MatchesViewState extends State<MatchesView> {
  final ProviderMatches _provider = ProviderMatches();

  @override
  void initState() {
    super.initState();
    _getMatches(1);
  }

  void _getMatches(int select) async => _provider.getMatches();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Partidos"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => Container(
        color: const Color.fromARGB(255, 214, 214, 214),
        child: Stack(
          children: [
            //CustomToggleButton(onTap: _getMatches),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: StreamBuilder(
                stream: _provider.matchesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<MatchModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? Column(
                            children: snapshot.data!
                                .map((match) => CustomCardTeams(match: match))
                                .toList(),
                          )
                        : const Text("Not data");
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      );
}
