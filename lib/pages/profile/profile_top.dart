import 'package:flutter/material.dart';

import '../login/models/member_model.dart';
import '../login/widgets/card_member/card_member.dart';
import 'widgets/background.dart';

class ProfileTop extends StatefulWidget {
  final MemberModel member;
  const ProfileTop({Key? key, required this.member}) : super(key: key);

  @override
  ProfileTopState createState() => ProfileTopState();
}

class ProfileTopState extends State<ProfileTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _generateCard();
  }

  Widget _generateCard() {
    return SizedBox(
      height: 230.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Background(),
          Positioned(
            top: 49.0,
            child: CardMember(
              member: widget.member,
              isSpecial: false,
              height: 190.0,
              width: 120.0,
              isFlip: false,
              reverse: false,
              isSmall: true,
              updatePerformance: _updatePerformance,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _updatePerformance({
    required int idMember,
    required Map<dynamic, dynamic> performance,
    required int idMatch,
  }) async {
    return true;
  }
}
