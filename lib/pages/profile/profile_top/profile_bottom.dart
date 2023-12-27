import 'package:flutter/material.dart';
import 'package:soccer/pages/login/utils/utils.dart';

import '../../login/models/member_model.dart';

class ProfileBottom extends StatelessWidget {
  final MemberModel member;

  const ProfileBottom({super.key, required this.member});

  @override
  Widget build(BuildContext context) => _generateCard();

  Widget _generateCard() {
    Color color = Utils().mapPosSevenColors[member.idPosition];
    double performance = member.attributes.getMedium();
    return Container(
      height: 90.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0.01,
            0.1,
            0.2,
            0.5,
          ],
          colors: [
            color.withOpacity(0.01),
            color.withOpacity(0.3),
            color.withOpacity(0.6),
            color,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _card(title: 'Posición', subTitle: member.position, left: 10.0),
          _card(title: 'Rendimiento', subTitle: performance.toString()),
          _card(
              title: 'Dorsal', subTitle: member.number.toString(), right: 10.0)
        ],
      ),
    );
  }

  Widget _card(
      {required String title,
      required String subTitle,
      double left = 0,
      double right = 0}) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: 20.0,
        bottom: 5.0,
      ),
      child: Container(
        height: double.infinity,
        width: 70.0,
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 9.0, color: Colors.black),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
