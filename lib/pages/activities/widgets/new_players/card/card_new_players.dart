import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/widgets/new_players/card/bottom_icon.dart';
import 'package:soccer/pages/login/models/member_model.dart';

import '../../../../login/widgets/card_member/card_member.dart';

class CardNewPlayers extends StatelessWidget {
  final MemberModel member;
  final Function({required int idMember, required bool isAdd}) action;
  const CardNewPlayers({
    super.key,
    required this.member,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CardMember(
            member: member,
            height: 270.0,
            width: 150.0,
            updatePerformance: _updatePerformance,
          ),
          BottomIcon(onTap: _actionMember),
        ],
      ),
    );
  }

  _actionMember({required bool isAdd}) {
    action(idMember: member.id, isAdd: isAdd);
  }

  Future<bool> _updatePerformance({
    required int idMember,
    required Map<dynamic, dynamic> performance,
    required int idMatch,
  }) async {
    return true;
  }
}
