import 'package:flutter/material.dart';

class MVPContent extends StatelessWidget {
  final double width;

  const MVPContent({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.0,
      height: 20.0,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black.withOpacity(0.5),
        ),
        child: const Center(
          child: Text(
            "MVP del partido",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
