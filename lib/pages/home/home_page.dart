import 'package:flutter/material.dart';
import 'package:soccer/pages/home/widgets/match_of_day.dart';
import 'package:soccer/pages/login/login_page.dart';
import 'package:soccer/pages/login/widgets/custom_toggle.dart';

import '../../user_preferences.dart';

import '../login/models/field_notifier.dart';
import '../login/models/match_model.dart';
import '../login/providers/provider_members.dart';
import '../login/widgets/match/match_card/match_card.dart';

import 'provider/provider_matches.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderMatches _provider = ProviderMatches();
  final ProviderMembers _providerMembers = ProviderMembers();
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  Map<int, String> tabs = {1: "Partidos finalizado", 2: "Próximos partidos"};
  int _tabIndex = 1;
  @override
  void initState() {
    _prefs.isModeAdmin = false;

    _getMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          centerTitle: false,
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Icon(Icons.exit_to_app_rounded)),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade300,
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => StreamBuilder(
      stream: _provider.matchesStream,
      builder: (BuildContext context, AsyncSnapshot<MatchesModel> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 600),
                    child: _content(matches: snapshot.data!.matches),
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _content({required List<MatchModel> matches}) {
    final List<MatchModel> matchesCurrent = _tabIndex == 1
        ? matches.where((match) => match.isFinished).toList()
        : matches.where((match) => !match.isFinished).toList();

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    final List<MatchModel> matchesCurrentToday = matches
        .where((match) =>
            DateTime(match.parsedDate.year, match.parsedDate.month,
                match.parsedDate.day) ==
            date)
        .toList();
    if (matchesCurrentToday.isNotEmpty) {
      matchesCurrent.remove(matchesCurrentToday.first);
    }

    return Column(
      children: [
        if (matchesCurrentToday.isNotEmpty)
          MatchOfDay(
            typeAlignNotifier: _typeAlignNotifier,
            providerMembers: _providerMembers,
            match: matchesCurrentToday.first,
            fields: _provider.fields,
          ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 2.0,
          ),
          child: CustomToggle(
            changeIndex: _changeIndex,
            tabIndex: _tabIndex,
            tabs: tabs,
          ),
        ),
        _column(matches: matchesCurrent)
      ],
    );
  }

  Widget _column({required List<MatchModel> matches}) => matches.isEmpty
      ? const Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Text(
            "No hay partidos disponnibles",
            textAlign: TextAlign.center,
          ),
        )
      : Flexible(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: matches
                    .map(
                      (match) => _generateMatch(match: match),
                    )
                    .toList()),
          ),
        );

  Widget _generateMatch({required MatchModel match}) => MatchCard(
        match: match,
        typeAlignNotifier: _typeAlignNotifier,
        fields: _provider.fields,
        providerMembers: _providerMembers,
      );

  void _getMatches() async {
    await _provider.getFields();
    _provider.getMatches();
  }

  void _changeIndex({required int tabIndex}) =>
      setState(() => _tabIndex = tabIndex);
}
