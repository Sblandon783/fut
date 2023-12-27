import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imageTeam;
  const Background({super.key, required this.imageTeam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 95.0),
      child: imageTeam.isEmpty
          ? const Image(
              width: double.maxFinite,
              height: double.infinity,
              image: AssetImage('assets/question_mark.jpeg'),
            )
          : Image.network(
              width: double.maxFinite,
              height: 300.0,
              imageTeam,
              fit: BoxFit.fitWidth,
              color: Colors.white.withOpacity(0.06),
              colorBlendMode: BlendMode.modulate,
            ),
    );
  }
}
