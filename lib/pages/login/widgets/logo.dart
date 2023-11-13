import 'package:flutter/material.dart';

import 'custom_cicular_image.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) => const CustomCicularImage(
        image: 'assets/logo.png',
        padding: EdgeInsets.only(top: 80.0),
      );
}
