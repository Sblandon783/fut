import 'package:flutter/material.dart';

class PerformanceByMatch extends StatelessWidget {
  final double performance;
  final double width;
  final Function() onTap;

  const PerformanceByMatch({
    super.key,
    required this.performance,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double widthBar = width * performance / 10;

    return Positioned(
      bottom: 2.0,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: 12.0,
                  width: widthBar,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: _getColor(),
                  ),
                  child: Text(
                    performance.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Mi rendimiento",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (performance < 5.1) {
      return Colors.red;
    } else if (performance > 5.0 && performance < 7.0) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
