import 'package:flutter/material.dart';
import 'package:soccer/pages/login/login_page.dart';

import '../../user_preferences.dart';
import '../login/models/field_model.dart';
import '../login/models/field_notifier.dart';
import '../login/models/match_model.dart';

import '../login/widgets/match_info.dart';

import 'provider/provider_match.dart';
import 'widgets/players/players_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final UserPreferences _prefs = UserPreferences();
  final _provider = ProviderMatch();
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  @override
  void initState() {
    _prefs.isModeAdmin = false;
    _getMatch();
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
          title: const Text("Fut APP"),
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
        body: _generateSecond(),
      ),
    );
  }

  Widget _generateSecond() => StreamBuilder(
      stream: _provider.matchStream,
      builder: (BuildContext context, AsyncSnapshot<MatchModel> snapshot) {
        if (snapshot.hasData) {
          FieldModel fieldCurrent = _provider.fields.fields.firstWhere(
              (field) => field.name == _provider.match!.name,
              orElse: () => _provider.fields.fields.first);

          _typeAlignNotifier.value = FieldNotifier(
              idField: fieldCurrent.id, idAlign: _provider.match!.idAlign);

          return snapshot.data != null
              ? SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 600),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _generateCard(
                              child: PlayersSection(
                                key: UniqueKey(),
                              ),
                            ),
                            MatchInfo(
                              match: snapshot.data!,
                              typeAlignNotifier: _typeAlignNotifier,
                              fields: _provider.fields.fields,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _generateCard({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 420.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: child,
    );
  }

  void _getMatch() async {
    await _provider.getFields();
    _provider.getMatch();
  }
}
