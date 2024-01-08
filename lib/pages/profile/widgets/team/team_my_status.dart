import 'package:flutter/material.dart';

import 'alert_my_status_team.dart';

class TeamMyStatus extends StatelessWidget {
  final Function({required int status}) onTap;
  final int status;
  TeamMyStatus({
    super.key,
    required this.onTap,
    required this.status,
  });

  final Map<int, IconData> _mapIcons = {
    1: Icons.check_circle_outline,
    2: Icons.add_circle_outline_rounded,
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context: context),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Icon(
          _mapIcons[status],
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: AlertMyStatus(status: status),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        onTap(status: value);
      }
    });
  }
}
