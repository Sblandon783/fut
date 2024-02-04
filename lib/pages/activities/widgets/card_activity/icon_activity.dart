import 'package:flutter/material.dart';

class IconActivity extends StatelessWidget {
  final IconData icon;
  final int count;
  const IconActivity({
    super.key,
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 55.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(1.0),
            bottomLeft: Radius.circular(1.0),
            bottomRight: Radius.circular(50.0)),
        color: Colors.red.shade400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22.0,
        ),
      ),
    );
  }
}
