import 'package:flutter/material.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
      );
}
