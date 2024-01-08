import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/widgets/new_players/card/alert_action_invitation.dart';

class BottomIcon extends StatelessWidget {
  final Function({required bool isAdd}) onTap;
  const BottomIcon({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () => _onTap(context: context),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            color: Colors.white,
          ),
          child: Icon(
            Icons.expand_circle_down_rounded,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: AlertActionInvitation(),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        onTap(isAdd: value);
      }
    });
  }
}
