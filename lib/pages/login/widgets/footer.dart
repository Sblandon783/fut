import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blue.shade200,
        height: 50.0,
        child: const Text(
          "Created by Sblandon",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15, height: 2.5),
        ),
      );
}
