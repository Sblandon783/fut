import 'package:flutter/material.dart';

import 'alert_my_status_team.dart';

class TeamMyStatus extends StatelessWidget {
  final Function({required int status}) onTap;
  const TeamMyStatus({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context: context),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.grey.shade700,
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
        content: AlertMyStatus(status: 1),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        onTap(status: value);
      }
    });
  }
}
