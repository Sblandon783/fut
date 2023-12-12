import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final String name;
  final int goalsOneTeam;
  final int goalsSecondTeam;

  const PerformanceCard({
    super.key,
    required this.name,
    required this.goalsOneTeam,
    required this.goalsSecondTeam,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Container(
            width: double.infinity,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2.0,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Container(
                    width: 50.0,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      color: _getColor(),
                    ),
                    child: Icon(
                      _getIcon(),
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 60.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blue,
                    ),
                    child: Text(
                      '$goalsOneTeam-$goalsSecondTeam',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  IconData _getIcon() {
    if (goalsOneTeam == goalsSecondTeam) {
      return Icons.sports_soccer_rounded;
    } else if (goalsOneTeam > goalsSecondTeam) {
      return Icons.check;
    } else {
      return Icons.close;
    }
  }

  Color _getColor() {
    if (goalsOneTeam == goalsSecondTeam) {
      return Colors.blue;
    } else if (goalsOneTeam > goalsSecondTeam) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
