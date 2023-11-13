import 'package:flutter/material.dart';

class CustomLargeCard extends StatelessWidget {
  final String text;
  final Function() onTap;
  final IconData icon;
  final Color color;
  const CustomLargeCard(
      {super.key,
      required this.text,
      required this.onTap,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 120.0,
              width: 250.0,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_genaretLeftPart(), _generateRigthPart()],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _genaretLeftPart() => Flexible(
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            color: color,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
  Widget _generateRigthPart() => SizedBox(
        width: 70.0,
        child: Icon(icon, size: 40.0),
      );
}
