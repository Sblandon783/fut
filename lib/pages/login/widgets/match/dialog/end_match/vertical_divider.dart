import 'package:flutter/material.dart';

class VerticalDiv extends StatelessWidget {
  const VerticalDiv({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      );
}
