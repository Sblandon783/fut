import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/align_section.dart';
import 'package:soccer/pages/login/widgets/custom_toggle.dart';
import 'package:soccer/pages/login/widgets/match_info.dart';

import 'providers/provider_members.dart';
import 'widgets/players_section.dart';

class SecondPart extends StatefulWidget {
  const SecondPart({super.key});

  @override
  SecondPartState createState() => SecondPartState();
}

class SecondPartState extends State<SecondPart> {
  final _provider = ProviderMembers();

  int _tabIndex = 0;

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  void _getMatch() async => _provider.getMatch();
  @override
  Widget build(BuildContext context) => _generateSecond();

  Widget _generateSecond() => Positioned(
        top: 100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: 330.0,
          child: Column(
            children: [
              const MatchInfo(),
              CustomToggle(
                key: UniqueKey(),
                changeIndex: _changeIndex,
                tabIndex: _tabIndex,
              ),
              _generateCard(
                child: _tabIndex == 0
                    ? PlayersSection(key: UniqueKey())
                    : AlignSection(key: UniqueKey()),
              ),
            ],
          ),
        ),
      );

  Widget _generateCard({required Widget child}) => Container(
        width: 330.0,
        height: _tabIndex == 0 ? 320 : 400.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10.0, bottom: 20.0),
        child: child,
      );

  void _changeIndex({required int tabIndex}) {
    setState(() => _tabIndex = tabIndex);
  }
}
