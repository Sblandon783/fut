import 'package:flutter/material.dart';

class ListPlayerTop extends StatelessWidget {
  final bool isTitular;

  final int count;

  const ListPlayerTop({
    super.key,
    required this.isTitular,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final String title = isTitular ? "Titulares" : "Banca";
    final IconData icon =
        isTitular ? Icons.sports_soccer_rounded : Icons.social_distance_sharp;
    final Color color =
        isTitular ? Colors.green.shade700 : Colors.orange.shade700;
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                icon,
                size: 20.0,
                color: Colors.white,
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
