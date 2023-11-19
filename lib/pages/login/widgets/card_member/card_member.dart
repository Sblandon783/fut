import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/utils/utils.dart';

import 'package:soccer/pages/login/widgets/card_member/center_content.dart';
import 'package:soccer/pages/login/widgets/card_member/footer_content.dart';

import '../../models/member_model.dart';
import 'background.dart';
import 'top_content.dart';

class CardMember extends StatefulWidget {
  final MemberModel member;
  final double width;
  final double height;
  final bool isSpecial;
  const CardMember({
    super.key,
    required this.member,
    this.width = 150.0,
    this.height = 270.0,
    this.isSpecial = false,
  });

  @override
  CardMemberState createState() => CardMemberState();
}

class CardMemberState extends State<CardMember>
    with SingleTickerProviderStateMixin {
  final Utils _utils = Utils();
  late AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
    lowerBound: 0.95,
    upperBound: 1,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
    reverseCurve: Curves.easeInOut,
  );
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSpecial
        ? ScaleTransition(
            scale: _animation,
            child: _content(),
          )
        : _content();
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
