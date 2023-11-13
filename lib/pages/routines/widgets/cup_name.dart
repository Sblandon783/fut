import 'package:flutter/material.dart';

class CupName extends StatelessWidget {
  final String name;

  const CupName({super.key, required this.name});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 170.0,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                    Colors.blue.shade200,
                    Colors.blue.shade100,
                    // Color.fromARGB(255, 238, 238, 238),
                  ],
                ),
                /*
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                */
              ),
            ),
            _generateCardTeam(),
          ],
        ),
      );

  Widget _generateCardTeam() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: SizedBox(
          height: 150.0,
          width: 180.0,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _generateLogo(),
              _generateContentCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateLogo() => Container(
        height: 100.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            "Mejengueros".toUpperCase(),
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.w800,
              fontSize: 15.0,
            ),
          ),
        ),
      );

  Widget _generateContentCard() => Center(
        child: SizedBox(
          height: double.infinity,
          child: Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Image(
                  height: 90.0,
                  image: AssetImage('assets/cup.png'),
                ),
              )),
        ),
      );
}
