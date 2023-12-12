import 'package:flutter/material.dart';

class MatchTopContent extends StatelessWidget {
  final int idType;

  const MatchTopContent({super.key, required this.idType});
  @override
  Widget build(BuildContext context) {
    return Text(
      idType == 0
          ? "DERROTA"
          : idType == 1
              ? "GANADO"
              : "EMPATE",
      style: TextStyle(
        color: idType == 0
            ? Colors.red
            : idType == 1
                ? Colors.green
                : Colors.blue,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
