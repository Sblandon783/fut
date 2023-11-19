import 'package:flutter/material.dart';

class CenterContent extends StatelessWidget {
  final String name;
  final double width;

  const CenterContent({super.key, required this.name, required this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80.0,
      child: Container(
        padding: const EdgeInsets.only(left: 5.0),
        width: width,
        alignment: Alignment.center,
        child: Text(
          name.isNotEmpty ? name : '???',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
