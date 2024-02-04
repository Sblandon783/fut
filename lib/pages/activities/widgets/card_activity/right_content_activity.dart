import 'package:flutter/material.dart';

class RightContentActivity extends StatelessWidget {
  final int count;
  const RightContentActivity({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 28.0,
            color: Colors.grey,
          ),
        ),
        _count(),
      ],
    );
  }

  Widget _count() {
    return Container(
      height: 55.0,
      width: 55.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(1.0),
            bottomLeft: Radius.circular(1.0),
            bottomRight: Radius.circular(20.0)),
        color: Colors.red.shade400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Center(
          child: Text(
            count.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
