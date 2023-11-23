import 'package:flutter/material.dart';
import 'package:soccer/pages/login/providers/provider_match.dart';
import 'package:soccer/pages/login/widgets/align/align_section.dart';
import 'package:soccer/pages/login/widgets/custom_toggle.dart';
import 'package:soccer/pages/login/widgets/match_info.dart';

import 'models/field_model.dart';
import 'models/field_notifier.dart';
import 'models/match_model.dart';
import 'widgets/players/players_section.dart';

class SecondPart extends StatefulWidget {
  const SecondPart({super.key});

  @override
  SecondPartState createState() => SecondPartState();
}

class SecondPartState extends State<SecondPart> {
  final _provider = ProviderMatch();
  final Map<int, String> _tabs = {0: "Jugadores", 1: "Alineación"};
  int _tabIndex = 1;
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  void _getMatch() async {
    await _provider.getFields();
    _provider.getMatch();
  }

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
                  FieldModel fieldCurrent = _provider.fields.fields.firstWhere(
                      (field) => field.name == _provider.match!.name,
                      orElse: () => _provider.fields.fields.first);

                  _typeAlignNotifier.value = FieldNotifier(
                      idField: fieldCurrent.id,
                      idAlign: _provider.match!.idAlign);

                  return snapshot.data != null
                      ? Column(
                          children: [
                            MatchInfo(
                              match: snapshot.data!,
                              typeAlignNotifier: _typeAlignNotifier,
                              fields: _provider.fields.fields,
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
      height: _tabIndex == 0 ? 430.0 : 420.0,
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
