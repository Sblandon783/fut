import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/match_model.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/vertical_divider.dart';

import '../../../../models/member_model.dart';
import 'add_goals_dialog.dart';
import 'end_match_add_player.dart';
import 'end_match_player_card.dart';
import 'list_members_dialog.dart';

class EndMatchPlayers extends StatefulWidget {
  final MatchModel match;
  final Function update;
  final List<MemberModel> members;
  const EndMatchPlayers({
    super.key,
    required this.match,
    required this.update,
    required this.members,
  });

  @override
  EndMatchPlayersState createState() => EndMatchPlayersState();
}

class EndMatchPlayersState extends State<EndMatchPlayers> {
  final List<MemberModel> _listPlayers = [];
  int _secondTeamGoal = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                ..._listPlayers
                    .map(
                      (m) => EndMatchPlayersCard(
                        name: m.name,
                        goals: m.goals,
                        onTap: () => _addPlayerOtherTeam2(member: m),
                      ),
                    )
                    .toList(),
                EndMatchAddPlayer(onTap: _openMembers),
              ]),
            ),
          ),
        ),
        const VerticalDiv(),
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: _secondTeamGoal == -1
                  ? EndMatchAddPlayer(
                      onTap: _addPlayerOtherTeam,
                    )
                  : EndMatchPlayersCard(
                      name: "Desconocido",
                      goals: _secondTeamGoal,
                      onTap: _addPlayerOtherTeam,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _addPlayerMyTeam({required MemberModel member}) {
    bool added = false;
    for (var i = 0; i < _listPlayers.length; i++) {
      if (_listPlayers[i].id == member.id) {
        _listPlayers[i].goals += member.goals;
        added = true;

        break;
      }
    }
    if (!added) {
      _listPlayers.add(member);
    }
    widget.match.teamOneGoals = widget.match.teamOneGoals + member.goals;
    widget.match.isFinished = true;
    setState(() {});
    widget.update();
  }

  _addPlayerOtherTeam() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: AddGoalsDialog(
            name: "Desconocido",
            goals: widget.match.teamSecondGoals,
          ),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null || value != "" || value != " ") {
        _secondTeamGoal = int.parse(value);
        widget.match.teamSecondGoals = _secondTeamGoal;
        widget.match.isFinished = true;

        setState(() {});
        widget.update();
      }
    });
  }

  _openMembers() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: ListeMembersDialog(
            members: widget.members,
          ),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic member) {
      if (member is MemberModel) {
        _addPlayerMyTeam(member: member);
      }
    });
  }

  _addPlayerOtherTeam2({required MemberModel member}) {
    int golsOld = member.goals;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: AddGoalsDialog(name: member.name, goals: member.goals),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic goals) {
      if (goals != null) {
        member.goals = int.parse(goals);

        widget.match.teamOneGoals -= golsOld;
        widget.match.teamOneGoals += member.goals;
        widget.match.isFinished = true;
        setState(() {});
        widget.update();
      }
    });
  }
}
