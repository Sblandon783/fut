import 'package:flutter/material.dart';

class EndMatchPlayersCard extends StatelessWidget {
  final String name;
  final int goals;
  final Function() onTap;

  const EndMatchPlayersCard({
    super.key,
    required this.name,
    required this.goals,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${name.substring(0, 9)}..'),
            Row(
              children: [
                const Icon(Icons.sports_soccer_rounded),
                Text(goals.toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
