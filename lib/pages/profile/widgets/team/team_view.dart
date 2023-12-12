import 'package:flutter/material.dart';
import 'package:soccer/pages/login/login_page.dart';
import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/widgets/team/team_top.dart';

import '../../../../../../user_preferences.dart';
import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/providers/provider_team.dart';
import '../../../login/widgets/card_member/card_member.dart';
import '../performance/performance_by_team.dart';

class TeamView extends StatefulWidget {
  final int id;
  const TeamView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  TeamViewState createState() => TeamViewState();
}

class TeamViewState extends State<TeamView> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderMembers _providerMembers = ProviderMembers();
  final ProviderTeam _providerTeam = ProviderTeam();

  @override
  void initState() {
    super.initState();
    _calls();
  }

  void _calls() async {
    await _providerTeam.getTeam(id: widget.id);
    _providerMembers.getMembers(idMvp: -1, normalGet: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.grey.shade700,
                  )),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.grey.shade700,
                  ),
                )),
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() {
    return StreamBuilder(
        stream: _providerTeam.teamStream,
        builder: (BuildContext context, AsyncSnapshot<TeamModel> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data != null
                ? _generateMembersContent(team: snapshot.data!)
                : const SizedBox.shrink();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _generateMembersContent({required TeamModel team}) {
    return StreamBuilder(
        stream: _providerMembers.membersStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MemberModel>> snapshot) {
          if (snapshot.hasData) {
            team.totalMembers = snapshot.data!.length;
            return snapshot.data!.isNotEmpty
                ? Column(
                    children: [
                      TeamTop(team: team),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                height: 326.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Jugadores",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 17.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Flexible(
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: _generateMembers(
                                          members: snapshot.data ?? [],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PerformanceByTeam(id: widget.id),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Text("Se el primero en enlistarte");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  List<Widget> _generateMembers({required List<MemberModel> members}) {
    return members.map((member) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: CardMember(
          member: member,
          height: 270.0,
          width: 150.0,
          updatePerformance: _updatePerformance,
        ),
      );
    }).toList();
  }

  Future<bool> _updatePerformance({
    required int idMember,
    required Map<dynamic, dynamic> performance,
    required int idMatch,
  }) async {
    return true;
  }
}
