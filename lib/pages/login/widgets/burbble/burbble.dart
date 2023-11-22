import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/card_member/animated_bounce.dart';
import 'package:soccer/user_preferences.dart';

import '../../models/member_model.dart';
import '../../utils/utils.dart';
import 'alert_burbble.dart';

class Burbble extends StatefulWidget {
  final int idPos;
  final Map<String, double> pos;
  final List<MemberModel> members;
  final MemberModel member;
  final Function({required MemberModel member, required MemberModel oldMember})
      updateMembers;
  const Burbble({
    super.key,
    required this.idPos,
    required this.pos,
    required this.members,
    required this.member,
    required this.updateMembers,
  });

  @override
  BurbbleState createState() => BurbbleState();
}

class BurbbleState extends State<Burbble> {
  UserPreferences _prefs = UserPreferences();
  @override
  void initState() {
    widget.member;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool myBurbble = widget.member.id == _prefs.userId;
    Widget child = Container(
      height: 27.0,
      width: 27.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.white,
          width: myBurbble ? 3 : 1,
        ),
        color: Utils().mapPosSevenColors[widget.idPos],
      ),
      padding: EdgeInsets.zero,
      child: Center(
        child: Text(
          widget.member.titular ? widget.member.number.toString() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );

    return Positioned(
      top: widget.pos["top"],
      right: widget.pos["right"],
      child: GestureDetector(
        onTap: () => _onTap(context: context),
        child: myBurbble ? AnimatedBounce(child: child) : child,
      ),
    );
  }

  Future<void> _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: AlertBurbble(
          pos: widget.idPos,
          members: widget.members,
          member: widget.member.titular
              ? widget.member
              : Utils().getMember(position: widget.member.idPosition),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        MemberModel newMember = value;
        widget.updateMembers(member: newMember, oldMember: widget.member);
        setState(() {});
      }
    });
  }
}
