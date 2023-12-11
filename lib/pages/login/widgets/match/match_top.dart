import 'package:flutter/material.dart';

import '../../models/field_model.dart';
import '../../models/field_notifier.dart';
import '../../models/match_model.dart';

import '../../providers/provider_members.dart';

import 'match_card/match_card.dart';

class MatchTop extends StatefulWidget {
  final MatchModel match;
  final List<FieldModel> fields;
  final ProviderMembers providerMembers;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;

  const MatchTop({
    Key? key,
    required this.match,
    required this.fields,
    required this.providerMembers,
    required this.typeAlignNotifier,
  }) : super(key: key);

  @override
  MatchTopState createState() => MatchTopState();
}

class MatchTopState extends State<MatchTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
      child: Stack(children: [
        Container(
          height: 120.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.01, 0.2, 0.3, 0.4, 0.5, 0.7, 0.8, 0.9],
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade600,
                Colors.blue.shade500,
                Colors.blue.shade300,
                Colors.purple.shade200,
                Colors.purple.shade300,
                Colors.purple.shade400,
                Colors.purple,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
            child: MatchCard(
              match: widget.match,
              typeAlignNotifier: widget.typeAlignNotifier,
              fields: widget.fields,
              providerMembers: widget.providerMembers,
              redirect: false,
            ),
          ),
        ),
      ]),
    );
  }
}
