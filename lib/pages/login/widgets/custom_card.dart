import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double top;
  final double height;
  final List<Widget> childrens;
  const CustomCard(
      {super.key,
      required this.top,
      required this.childrens,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(
              top: 10, left: 10, right: 10.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childrens,
          ),
        ),
      ),
    );
  }
}
