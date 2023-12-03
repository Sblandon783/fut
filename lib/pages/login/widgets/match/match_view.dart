import 'package:flutter/material.dart';
import 'package:soccer/pages/login/login_page.dart';
import 'package:soccer/pages/login/widgets/match/match_top.dart';

import '../../../../user_preferences.dart';
import '../../../align/align_page.dart';
import '../../models/field_model.dart';
import '../../models/field_notifier.dart';
import '../../models/match_model.dart';

import '../../providers/provider_members.dart';
import '../custom_toggle.dart';
import 'match_card/match_card.dart';

import '../../../home/widgets/players/players_section.dart';

class MatchView extends StatefulWidget {
  final MatchModel match;
  final List<FieldModel> fields;

  const MatchView({
    Key? key,
    required this.match,
    required this.fields,
  }) : super(key: key);

  @override
  MatchViewState createState() => MatchViewState();
}

class MatchViewState extends State<MatchView> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderMembers _providerMembers = ProviderMembers();
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  final Map<int, String> _tabs = {0: "Jugadores", 1: "Alineación"};
  int _tabIndex = 0;

  @override
  void initState() {
    _prefs.isModeAdmin = false;
    _providerMembers.match = widget.match;
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
          title: const Text("Partido"),
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
          leading: GestureDetector(
              onTap: () => Navigator.pop(context, widget.match),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back_ios_new_outlined),
              )),
        ),
        backgroundColor: Colors.grey.shade300,
        body: _generateSecond(),
      ),
    );
  }

  Widget _generateSecond() {
    FieldModel fieldCurrent = widget.fields.firstWhere(
        (field) => field.name == widget.match.name,
        orElse: () => widget.fields.first);
    int idMVP = widget.match.idMPV;

    _typeAlignNotifier.value =
        FieldNotifier(idField: fieldCurrent.id, idAlign: widget.match.idAlign);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MatchTop(
            match: widget.match,
            fields: widget.fields,
            providerMembers: _providerMembers,
            typeAlignNotifier: _typeAlignNotifier,
          ),
          _generateCard(
            child: _tabIndex == 0
                ? PlayersSection(
                    key: UniqueKey(),
                    idMVP: idMVP,
                    provider: _providerMembers,
                    isFinishedMatch: widget.match.isFinished,
                  )
                : AlignPage(key: UniqueKey()),
          ),
        ],
      ),
    );
  }

  Widget _generateCard({required Widget child}) {
    return Flexible(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                CustomToggle(
                  key: UniqueKey(),
                  changeIndex: _changeIndex,
                  tabIndex: _tabIndex,
                  tabs: _tabs,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      height: widget.match.isFinished
                          ? _tabIndex == 0
                              ? 360.0
                              : null
                          : 420.0,
                      child: child,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeIndex({required int tabIndex}) =>
      setState(() => _tabIndex = tabIndex);
}
