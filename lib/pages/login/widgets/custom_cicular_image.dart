import 'package:flutter/material.dart';

class CustomCicularImage extends StatelessWidget {
  final String image;
  final EdgeInsets padding;
  const CustomCicularImage({
    super.key,
    required this.image,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.topCenter,
        child: Padding(
          padding: padding,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(image),
          ),
        ),
      );
}
