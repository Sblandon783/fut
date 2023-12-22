import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/match_model.dart';

import '../../login/models/field_model.dart';
import '../../login/models/field_notifier.dart';
import '../../login/providers/provider_members.dart';
import '../../login/widgets/match/match_card/match_card.dart';

class MatchOfDay extends StatelessWidget {
  final ProviderMembers providerMembers;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
  final MatchModel match;
  final List<FieldModel> fields;

  const MatchOfDay({
    super.key,
    required this.match,
    required this.providerMembers,
    required this.typeAlignNotifier,
    required this.fields,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              stops: const [
                0.01,
                0.1,
                0.4,
                0.5,
                0.6,
                0.8,
                0.9,
              ],
              colors: [
                Colors.purple,
                Colors.purple.shade600,
                Colors.blue.shade600,
                Colors.blue.shade500,
                Colors.blue.shade400,
                Colors.blue.shade300,
                Colors.blue.shade200,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  match.isFinished
                      ? "Votaciones: Rendimiento por jugador"
                      : "Partido del día",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15.0,
                  ),
                ),
                MatchCard(
                  match: match,
                  typeAlignNotifier: typeAlignNotifier,
                  fields: fields,
                  providerMembers: providerMembers,
                  redirect: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
