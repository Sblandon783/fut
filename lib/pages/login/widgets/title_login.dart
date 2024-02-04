import 'package:flutter/material.dart';

class TitleLogin extends StatelessWidget {
  const TitleLogin({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
        child: Center(
          child: Text(
            "Listo para el fútbol",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blue,
              fontSize: 20.0,
            ),
          ),
        ),
      );
}
