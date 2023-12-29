import 'package:flutter/material.dart';

import 'status_tag.dart';

class CenterContentProfile extends StatelessWidget {
  final String name;
  final double width;
  final bool isCaptain;
  final int status;

  const CenterContentProfile({
    super.key,
    required this.name,
    required this.width,
    required this.isCaptain,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    List<String> nameList = name.split(' ');
    return Positioned(
      bottom: 110.0,
      left: 10.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: SizedBox(
              height: 45.0,
              width: 45.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300.0),
                child: const Image(
                  height: double.infinity,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
          ),
          Text(
            nameList.first,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
            ),
          ),
          if (nameList.length > 1)
            Text(
              nameList[1].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 30.0,
              ),
            ),
          StatusTag(status: status, isCaptain: isCaptain),
        ],
      ),
    );
  }
}
