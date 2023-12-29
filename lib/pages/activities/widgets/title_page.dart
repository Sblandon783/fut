import 'package:flutter/material.dart';

class TitleActivities extends StatelessWidget {
  const TitleActivities({super.key});

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
                text: 'Quiero \n',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              TextSpan(
                text: 'extender mis limites!',
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
