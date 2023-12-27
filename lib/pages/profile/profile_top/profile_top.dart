import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/profile_top/profile_top_content.dart';

import '../../login/models/member_model.dart';

class ProfileTop extends StatelessWidget {
  final MemberModel member;
  final String image =
      'https://wphnxtpgvkcouhktmews.supabase.co/storage/v1/object/public/teams_images/notFap.png?t=2023-12-22T18%3A37%3A58.527Z';

  const ProfileTop({super.key, required this.member});

  @override
  Widget build(BuildContext context) => _generateCard();

  Widget _generateCard() {
    return Container(
      height: 300.0,
      width: double.infinity,
      color: Colors.white,
      child: ProfileTopContent(
        member: member,
        isSpecial: false,
        isFlip: false,
        reverse: false,
        isSmall: true,
        updatePerformance: _updatePerformance,
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
