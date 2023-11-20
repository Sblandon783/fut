import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final double width;
  final double height;

  const Background({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          child: Image(
            width: width,
            height: height - 24,
            fit: BoxFit.fitHeight,
            image: const AssetImage('assets/back_2.png'),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
