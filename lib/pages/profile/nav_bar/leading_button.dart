import 'package:flutter/material.dart';

class LeadingButton extends StatelessWidget {
  final Color color;

  const LeadingButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      );
}
