import 'package:flutter/material.dart';

class ContainerGradient extends StatelessWidget {
  final List<Widget> childrens;
  final String title;

  const ContainerGradient(
      {super.key, required this.childrens, required this.title});

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.blue.shade700,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.purple
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  )),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ))
            ],
          ),
          ...childrens,
        ],
      ));
}
