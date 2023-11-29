import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class TopContent extends StatelessWidget {
  final double width;
  final double height;
  final Utils utils;
  final int idPosition;

  const TopContent({
    super.key,
    required this.width,
    required this.height,
    required this.idPosition,
    required this.utils,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image(
            height: height,
            width: width,
            color: Colors.white,
            image: AssetImage(
                'assets/${utils.images[idPosition] ?? utils.images[1]}'),
          ),
        ),
      ),
    );
  }
}
