import 'package:flutter/material.dart';

import '../../login/models/member_model.dart';

class FooterContent extends StatelessWidget {
  final MemberModel member;
  final double width;
  final String _incognite = '???';
  final double bottom;

  const FooterContent({
    super.key,
    required this.member,
    required this.width,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.0,
      left: 0.0,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _generateColumn(
              title: "Posición",
              subTitle: member.number != -1 ? member.position : _incognite,
            ),
            _generateColumn(
              title: "Número",
              subTitle:
                  member.number != -1 ? member.number.toString() : _incognite,
            ),
          ],
        ),
      ),
    );
  }

  Column _generateColumn({required String title, required String subTitle}) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 12.0,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
