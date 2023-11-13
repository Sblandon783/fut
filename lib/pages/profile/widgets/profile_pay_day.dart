import 'package:flutter/material.dart';

class ProfilePayDay extends StatelessWidget {
  final String nextDate;
  const ProfilePayDay({super.key, required this.nextDate});
  static const String _lastDateText = "Último día de pagó";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 180,
              height: 80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    _lastDateText,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    nextDate.split('T').first,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
