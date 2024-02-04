import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/field_model.dart';
import 'package:soccer/pages/login/models/member_model.dart';
import 'package:soccer/pages/login/widgets/match/match_card/match_card_bottom_content.dart';
import 'package:soccer/pages/login/widgets/match/match_card/match_container.dart';
import 'package:soccer/pages/login/widgets/match/match_top_content.dart';
import 'package:soccer/user_preferences.dart';

import '../dialog/end_match/end_match_dialog.dart';
import '../match_view.dart';
import '../../../models/field_notifier.dart';
import '../../../models/match_model.dart';
import '../../../providers/provider_members.dart';

class MatchCard extends StatefulWidget {
  final MatchModel match;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
  final List<FieldModel> fields;
  final ProviderMembers providerMembers;
  final bool redirect;
  final bool createMatch;
  const MatchCard({
    super.key,
    required this.match,
    required this.typeAlignNotifier,
    required this.fields,
    required this.providerMembers,
    this.redirect = true,
    this.createMatch = false,
  });

  @override
  MatchCardState createState() => MatchCardState();
}

class MatchCardState extends State<MatchCard> {
  final List<DateTime?> _dates = [];
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    _setDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int idType = widget.match.teamOneGoals < widget.match.teamSecondGoals
        ? 0
        : widget.match.teamOneGoals > widget.match.teamSecondGoals
            ? 1
            : 2;

    final Widget child = Column(
      children: [
        if (widget.match.isFinished) MatchTopContent(idType: idType),
        MatchContainer(
          match: widget.match,
          createMatch: widget.createMatch,
        ),
        if (widget.fields.isNotEmpty)
          MatchCardBottomContent(
            match: widget.match,
            fields: widget.fields,
            providerMembers: widget.providerMembers,
            disabledOnTap: widget.redirect,
            createMatch: widget.createMatch,
          ),
        if (!widget.match.isFinished &&
            !widget.redirect &&
            (_prefs.userId == 23 || _prefs.userId == 25) &&
            !widget.createMatch)
          ElevatedButton(
            onPressed: _endMatch,
            child: const Text('Finalizar Partido'),
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

  void _setDate() => _dates.add(DateTime(widget.match.parsedDate.year,
      widget.match.parsedDate.month, widget.match.parsedDate.day));

  void _onTap() {
    final int id = widget.match.idField;
    final DateTime parsedDate = widget.match.parsedDate;
    //App.setTheme(context, Colors.blue.shade700);
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

  _endMatch() {
    MatchModel newMatch = MatchModel.fromJson(widget.match.json());
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
          child: EndMatchDialog(
            match: newMatch,
            members: widget.providerMembers.members,
          ),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value is MatchModel) {
        _tabEndMatch(newMatch: value);
      }
    });
  }

  void _tabEndMatch({required MatchModel newMatch}) async {
    final Map<String, int> playersGoals = {};
    for (var m in widget.providerMembers.members) {
      playersGoals[m.id.toString()] = m.goals;
    }

    widget.match.teamOneGoals = newMatch.teamOneGoals;
    widget.match.teamSecondGoals = newMatch.teamSecondGoals;
    widget.match.isFinished = true;
    bool response = await widget.providerMembers
        .saveMatchEnd(match: widget.match, goals: playersGoals);
    if (response) {
      setState(() {});
    }
  }
}
