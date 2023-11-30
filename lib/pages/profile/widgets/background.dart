import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      elevation: 2,
      child: Image(
        width: double.maxFinite,
        height: 170.0,
        fit: BoxFit.fill,
        image: AssetImage('assets/background_profile.jpeg'),
      ),
    );
  }
}
