import 'package:flutter/material.dart';

import 'package:soccer/pages/profile/models/team_model.dart';

import '../dialog/list_teams.dart';
import '../../../models/match_model.dart';
import 'match_card_center_content.dart';

class MatchContainer extends StatefulWidget {
  final MatchModel match;
  final bool createMatch;
  const MatchContainer({
    super.key,
    required this.match,
    this.createMatch = false,
  });

  @override
  MatchContainerState createState() => MatchContainerState();
}

class MatchContainerState extends State<MatchContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget teamSecondImage = _teamImage(image: widget.match.imageSecondTeam);

    return Container(
      width: double.infinity,
      height: 80.0,
      color: Colors.white,
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _teamImage(image: widget.match.imageOneTeam),
              MatchCardCenterContent(
                isFinished: widget.match.isFinished,
                goalsTeamOne: widget.match.teamOneGoals,
                goalsTeamSecond: widget.match.teamSecondGoals,
              ),
              widget.createMatch
                  ? GestureDetector(
                      onTap: _generateListTeam,
                      child: teamSecondImage,
                    )
                  : teamSecondImage,
            ]),
      ),
    );
  }

  Widget _teamImage({required String image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: image.isEmpty
          ? const Image(
              height: double.infinity,
              image: AssetImage('assets/question_mark.jpeg'),
            )
          : Image.network(height: double.infinity, image),
    );
  }

  _generateListTeam() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: ListTeams(),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        TeamModel team = value;
        widget.match.imageSecondTeam = team.image;
        widget.match.idSecondTeam = team.id;
        setState(() {});
      }
    });
  }
}
