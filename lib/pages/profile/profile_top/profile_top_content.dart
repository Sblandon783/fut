import 'package:flutter/material.dart';

import 'package:soccer/pages/login/utils/utils.dart';

import 'package:soccer/pages/profile/profile_top/top_content.dart';

import '../../login/models/member_model.dart';
import '../../login/widgets/card_member/animated_bounce.dart';

import 'center_content.dart';

class ProfileTopContent extends StatefulWidget {
  final int idMatch;
  final MemberModel member;
  final double width;
  final double height;
  final bool isSpecial;
  final bool isSmall;
  final bool isFlip;
  final bool reverse;
  final Future<bool> Function({
    required int idMember,
    required int idMatch,
    required Map<dynamic, dynamic> performance,
  }) updatePerformance;

  final Map<dynamic, dynamic> performance;
  const ProfileTopContent({
    super.key,
    this.idMatch = -1,
    required this.member,
    this.width = 200.0,
    this.height = 270.0,
    this.isSpecial = false,
    this.isSmall = false,
    this.isFlip = true,
    this.reverse = false,
    this.performance = const {},
    required this.updatePerformance,
  });

  @override
  ProfileTopContentState createState() => ProfileTopContentState();
}

class ProfileTopContentState extends State<ProfileTopContent> {
  final Utils _utils = Utils();
  final String image =
      'https://wphnxtpgvkcouhktmews.supabase.co/storage/v1/object/public/teams_images/notFap.png?t=2023-12-22T18%3A37%3A58.527Z';

  double _performance = 0.0;
  late Color _color;
  @override
  void initState() {
    _getPerformance();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _color = _utils.mapPosSevenColors[widget.member.idPosition];
    return widget.isSpecial ? AnimatedBounce(child: _content()) : _content();
  }

  Widget _content() => _genarateCard(child: _frontCard());

  Widget _genarateCard({required Widget child}) {
    return Container(
      height: double.infinity,
      color: _color,
      child: child,
    );
  }

  Widget _frontCard() {
    return Stack(
      children: [
        //Background(imageTeam: image),

        TopContent(
          idPosition: widget.member.idPosition,
          width: widget.width,
          height: widget.height,
          utils: _utils,
        ),
        CenterContentProfile(
          name: widget.member.name,
          width: widget.width,
          isCaptain: widget.member.isCaptain,
          status: widget.member.status,
        ),
      ],
    );
  }

  _getPerformance() {
    _performance = 0.0;
    if (widget.performance.isEmpty) {
      return 5.0;
    }

    widget.performance
        .forEach((key, value) => _performance = _performance + value);
    _performance = (_performance / widget.performance.length);
    _performance = double.parse(_performance.toStringAsFixed(2));
  }
}
