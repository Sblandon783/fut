import 'package:flutter/material.dart';
import 'package:soccer/pages/login/utils/utils.dart';

import 'package:soccer/pages/login/widgets/card_member/center_content.dart';
import 'package:soccer/pages/login/widgets/card_member/footer_content.dart';

import '../../models/member_model.dart';
import 'animated_bounce.dart';
import 'background.dart';
import 'top_content.dart';

class CardMember extends StatefulWidget {
  final MemberModel member;
  final double width;
  final double height;
  final bool isSpecial;
  final bool isSmall;
  const CardMember(
      {super.key,
      required this.member,
      this.width = 150.0,
      this.height = 270.0,
      this.isSpecial = false,
      this.isSmall = false,
      s});

  @override
  CardMemberState createState() => CardMemberState();
}

class CardMemberState extends State<CardMember> {
  final Utils _utils = Utils();

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSpecial ? AnimatedBounce(child: _content()) : _content();
  }

  Widget _content() {
    Color color = _utils.mapPosSevenColors[widget.member.idPosition];
    return SizedBox(
      height: widget.height,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: widget.isSpecial ? 8 : 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: widget.isSpecial
                  ? BorderSide(color: color, width: 3.0)
                  : BorderSide.none,
            ),
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Stack(
                children: [
                  Background(width: widget.width, height: widget.height),
                  TopContent(
                    idPosition: widget.member.idPosition,
                    width: widget.width,
                    height: widget.isSmall ? 60.0 : widget.height - 150.0,
                    utils: _utils,
                  ),
                  CenterContent(name: widget.member.name, width: widget.width),
                  FooterContent(member: widget.member, width: widget.width)
                ],
              ),
            ),
          )),
    );
  }
}
