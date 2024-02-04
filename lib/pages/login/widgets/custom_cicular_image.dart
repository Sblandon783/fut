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
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(100.0),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(image),
            ),
          ),
        ),
      );
}
