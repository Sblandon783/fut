import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/align/align_section.dart';
import 'package:soccer/pages/login/widgets/custom_toggle.dart';
import 'package:soccer/pages/login/widgets/match_info.dart';

import 'models/match_model.dart';
import 'providers/provider_members.dart';
import 'widgets/players/players_section.dart';

class SecondPart extends StatefulWidget {
  const SecondPart({super.key});

  @override
  SecondPartState createState() => SecondPartState();
}

class SecondPartState extends State<SecondPart> {
  final _provider = ProviderMembers();
  final Map<int, String> _tabs = {0: "Jugadores", 1: "Alineación"};
  int _tabIndex = 1;
  final ValueNotifier<int> _typeAlignNotifier = ValueNotifier(1);
  final Map<int, String> _listFields = {
    1: 'Limber',
    2: 'Luis Papa',
  };

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  void _getMatch() async => _provider.getMatch();

  @override
  Widget build(BuildContext context) => _generateSecond();

  Widget _generateSecond() => Positioned(
        top: 60,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: 330.0,
          child: StreamBuilder(
              stream: _provider.matchStream,
              builder:
                  (BuildContext context, AsyncSnapshot<MatchModel> snapshot) {
                if (snapshot.hasData) {
                  int field = _listFields.keys.firstWhere(
                      (k) => _listFields[k] == _provider.match!.name,
                      orElse: () => _listFields.keys.first);
                  _typeAlignNotifier.value = field;

                  return snapshot.data != null
                      ? Column(
                          children: [
                            MatchInfo(
                              match: snapshot.data!,
                              typeAlignNotifier: _typeAlignNotifier,
                            ),
                            CustomToggle(
                              key: UniqueKey(),
                              changeIndex: _changeIndex,
                              tabIndex: _tabIndex,
                              tabs: _tabs,
                            ),
                            _generateCard(
                              child: _tabIndex == 0
                                  ? PlayersSection(key: UniqueKey())
                                  : AlignSection(
                                      key: UniqueKey(),
                                      match: snapshot.data!,
                                      typeAlignNotifier: _typeAlignNotifier,
                                    ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      );

  Widget _generateCard({required Widget child}) {
    return Container(
      width: 330.0,
      height: _tabIndex == 0 ? 430.0 : 400.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding:
          const EdgeInsets.only(top: 10, left: 10, right: 10.0, bottom: 20.0),
      child: child,
    );
  }

  void _changeIndex({required int tabIndex}) {
    setState(() => _tabIndex = tabIndex);
  }
}
