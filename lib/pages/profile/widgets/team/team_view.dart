import 'package:flutter/material.dart';
import 'package:soccer/pages/login/login_page.dart';
import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/widgets/team/team_top.dart';

import '../../../../../../user_preferences.dart';
import '../../../home/provider/provider_match.dart';
import '../../../login/models/match_model.dart';
import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/providers/provider_team.dart';
import '../../../login/widgets/card_member/card_member.dart';
import '../performance/performance_by_team.dart';
import 'team_top_data.dart';

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
  final ProviderMatch _providerMatch = ProviderMatch();
  final ScrollController _controller = ScrollController();
  final ValueNotifier<bool> _titleNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels > 170.0 && !_titleNotifier.value) {
        _titleNotifier.value = true;
      } else if (_controller.position.pixels < 170.0 && _titleNotifier.value) {
        _titleNotifier.value = false;
      }
    });
    _calls();
  }

  void _calls() async {
    await _providerTeam.getTeam(id: widget.id);
    await _providerMatch.getMatches(id: widget.id);
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
          toolbarHeight: 40.0,
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
          title: ValueListenableBuilder(
            valueListenable: _titleNotifier,
            builder: (context, show, child) => show
                ? Text(
                    "NotFaps",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                : SizedBox.shrink(),
          ),
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
            team.winner = 0;
            team.loose = 0;

            for (MatchModel element in _providerMatch.matches) {
              {
                if (element.teamOneGoals > element.teamSecondGoals) {
                  team.winner++;
                } else if (element.teamOneGoals == element.teamSecondGoals) {
                  team.equals++;
                } else if (element.teamOneGoals < element.teamSecondGoals) {
                  team.loose++;
                }
              }
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              slivers: <Widget>[
                SliverAppBar(
                  stretch: true,
                  onStretchTrigger: () async {
                    print("object");
                  },
                  stretchTriggerOffset: 300.0,
                  expandedHeight: 215.0,
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  titleSpacing: 0.0,
                  leading: const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    title: TeamTopData(team: team),
                    titlePadding: EdgeInsets.zero,
                    centerTitle: true,
                    expandedTitleScale: 1.3,
                    background: TeamTop(team: team),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  toolbarHeight: 40.0,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
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
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final MemberModel member =
                                          snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: CardMember(
                                          member: member,
                                          height: 270.0,
                                          width: 150.0,
                                          updatePerformance: _updatePerformance,
                                        ),
                                      );
                                      ;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PerformanceByTeam(provider: _providerMatch),
                          const SizedBox(height: 10.0),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            );
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
                              PerformanceByTeam(provider: _providerMatch),
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
