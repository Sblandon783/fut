import 'package:flutter/material.dart';

class EndMatchAddPlayer extends StatelessWidget {
  final Function() onTap;
  const EndMatchAddPlayer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Chip(
        label: SizedBox(
          width: double.infinity,
          child: Icon(
            Icons.add_circle_rounded,
          ),
        ),
      ),
    );
  }
}
