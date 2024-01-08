import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  final int status;
  final bool isCaptain;
  StatusTag({
    super.key,
    required this.status,
    required this.isCaptain,
  });

  final Map<int, Color> _statusColor = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.red,
  };
  final Map<int, IconData> _statusIcon = {
    1: Icons.local_fire_department_outlined,
    2: Icons.sensor_occupied_rounded,
    3: Icons.arrow_downward_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(110, 0, 0, 0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      width: isCaptain ? 60.0 : 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            _statusIcon[status],
            color: _statusColor[status],
            size: 25.0,
          ),
          if (isCaptain)
            Icon(
              Icons.local_fire_department_outlined,
              color: Colors.orange.shade800,
              size: 25.0,
            ),
        ],
      ),
    );
  }
}
