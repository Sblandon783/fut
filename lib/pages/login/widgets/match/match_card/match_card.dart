import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/field_model.dart';
import 'package:soccer/pages/login/widgets/match/match_card/match_card_bottom_content.dart';
import 'package:soccer/pages/login/widgets/match/match_top_content.dart';

import '../match_view.dart';
import '../../../models/field_notifier.dart';
import '../../../models/match_model.dart';
import '../../../providers/provider_members.dart';
import 'match_card_center_content.dart';

class MatchCard extends StatefulWidget {
  final MatchModel match;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
  final List<FieldModel> fields;
  final ProviderMembers providerMembers;
  final bool redirect;
  const MatchCard({
    super.key,
    required this.match,
    required this.typeAlignNotifier,
    required this.fields,
    required this.providerMembers,
    this.redirect = true,
  });

  @override
  MatchCardState createState() => MatchCardState();
}

class MatchCardState extends State<MatchCard> {
  final List<DateTime?> _dates = [];

  @override
  void initState() {
    _setDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool myTeamWin =
        widget.match.teamOneGoals > widget.match.teamSecondGoals;
    final Widget child = Column(
      children: [
        if (widget.match.isFinished) MatchTopContent(myTeamWin: myTeamWin),
        Container(
          width: double.infinity,
          height: 80.0,
          color: Colors.white,
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _teamImage(image: 'assets/logo.png'),
                  MatchCardCenterContent(
                    isFinished: widget.match.isFinished,
                    goalsTeamOne: widget.match.teamOneGoals,
                    goalsTeamSecond: widget.match.teamSecondGoals,
                  ),
                  _teamImage(image: 'assets/question_mark.jpeg')
                ]),
          ),
        ),
        MatchCardBottomContent(
          match: widget.match,
          fields: widget.fields,
          providerMembers: widget.providerMembers,
        )
      ],
    );
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.redirect
                ? GestureDetector(onTap: _onTap, child: child)
                : child,
          ),
        ));
  }

  Widget _teamImage({required String image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: Image(
        height: double.infinity,
        image: AssetImage(image),
      ),
    );
  }

  void _setDate() => _dates.add(DateTime(widget.match.parsedDate.year,
      widget.match.parsedDate.month, widget.match.parsedDate.day));

  void _onTap() {
    final int id = widget.match.idField;
    final DateTime parsedDate = widget.match.parsedDate;
    final route = MaterialPageRoute(
      builder: (context) => MatchView(
        key: UniqueKey(),
        match: widget.match,
        fields: widget.fields,
      ),
    );
    Navigator.push(context, route).then((value) {
      if (widget.match.idField != id || widget.match.parsedDate != parsedDate) {
        MatchModel match = value;
        widget.match.idField = match.idField;
        widget.match.hour = match.hour;
        widget.match.date = match.date;
        widget.match.parsedDate = match.parsedDate;

        setState(() {});
      }
    });
  }
}
