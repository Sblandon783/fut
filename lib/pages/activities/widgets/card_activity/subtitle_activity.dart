import 'package:flutter/material.dart';

class SubTitleActivity extends StatelessWidget {
  final String subtitle;

  const SubTitleActivity({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 20.0),
      child: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 13.0,
        ),
      ),
    );
  }
}
