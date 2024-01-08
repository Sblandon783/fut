import 'package:flutter/material.dart';

import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/widgets/team/team_top.dart';

import '../../../home/provider/provider_match.dart';
import '../../../login/models/match_model.dart';
import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/providers/provider_team.dart';
import '../../../login/widgets/card_member/card_member.dart';
import '../../nav_bar/exit_button.dart';
import '../performance/performance_by_team.dart';
import 'team_my_status.dart';
import 'team_top_data.dart';

class TeamView extends StatefulWidget {
  final TeamModel team;
  const TeamView({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  TeamViewState createState() => TeamViewState();
}

class TeamViewState extends State<TeamView> {
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
    await _providerTeam.getTeam(id: widget.team.id);
    await _providerMatch.getMatches(id: widget.team.id);
    await _providerMembers.getMembers(
      idMvp: -1,
      normalGet: true,
      teamId: widget.team.id,
    );
  }

  void _changeStatus({required int status}) {
    if (status == 1) {
      _providerTeam.exitTeam(idTeam: widget.team.id);
      Navigator.pop(context, widget.team.id);
    } else if (status == 2) {
      _providerTeam.addTeam(idTeam: widget.team.id);
      _providerMembers.setMemberStatus = 1;
      Navigator.pop(context, widget.team.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _generateContent();
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
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  toolbarHeight: 40.0,
                  actions: [
                    TeamMyStatus(
                      onTap: _changeStatus,
                      status: _providerMembers.memberStatus,
                    ),
                    ExitButton(color: Colors.grey.shade700),
                  ],
                  title: ValueListenableBuilder(
                    valueListenable: _titleNotifier,
                    builder: (context, show, child) => show
                        ? Text(
                            widget.team.name,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : const SizedBox.shrink(),
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
                body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  slivers: <Widget>[
                    SliverAppBar(
                      stretch: true,
                      onStretchTrigger: () async {
                        //print("object");
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
                                    if (snapshot.data!.isEmpty)
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 100.0),
                                          child: Text(
                                            "No hay jugadores en este equipo",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                            ),
                                          ),
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
                                              updatePerformance:
                                                  _updatePerformance,
                                            ),
                                          );
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
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> _updatePerformance({
    required int idMember,
    required Map<dynamic, dynamic> performance,
    required int idMatch,
  }) async {
    return true;
  }
}
