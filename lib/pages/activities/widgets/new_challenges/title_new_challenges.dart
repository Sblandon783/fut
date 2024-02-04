import 'package:flutter/material.dart';

class TitleWewChallenges extends StatelessWidget {
  final int tab;
  const TitleWewChallenges({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 20.0, top: 5.0),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              const TextSpan(
                text: 'Tus próximos \n',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              TextSpan(
                text: tab == 1 ? 'retos confirmados!' : "retos por aceptar",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
