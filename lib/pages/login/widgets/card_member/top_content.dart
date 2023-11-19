import 'package:flutter/material.dart';

import '../../models/utils/utils.dart';

class TopContent extends StatelessWidget {
  final double width;
  final Utils utils;
  final int idPosition;

  const TopContent({
    super.key,
    required this.width,
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
            height: 120.0,
            width: width,
            image: AssetImage(
                'assets/${utils.images[idPosition] ?? utils.images[1]}'),
          ),
        ),
      ),
    );
  }
}
