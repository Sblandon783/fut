import 'package:flutter/material.dart';

import '../login/models/member_model.dart';

class ListPlayerContent extends StatelessWidget {
  final MemberModel member;

  const ListPlayerContent({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5.0, top: 2.0, bottom: 2.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.black26,
        ),
        child: Row(
          children: [
            SizedBox(
                width: 30.0,
                child: Text(
                  member.number.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Text(
              member.name.substring(
                  0, member.name.length > 10 ? 10 : member.name.length),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
