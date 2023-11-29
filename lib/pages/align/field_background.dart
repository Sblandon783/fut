import 'package:flutter/material.dart';

class FieldBackground extends StatelessWidget {
  const FieldBackground({super.key});
  final double _heightImage = 200.0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Image(
        height: _heightImage,
        width: 300.0,
        image: const AssetImage('assets/soccer_field.jpeg'),
      ),
    );
  }
}
