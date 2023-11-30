import 'package:flutter/material.dart';

class TitleAttribute extends StatelessWidget {
  const TitleAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Mis atributos",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
