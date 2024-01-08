import 'package:flutter/material.dart';

class TitleAllTeams extends StatelessWidget {
  const TitleAllTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, bottom: 40.0),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: 'Todos \n',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              TextSpan(
                text: 'los equipos disponibles!',
                style: TextStyle(
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
