import 'package:flutter/material.dart';

class ProfileTopContent extends StatelessWidget {
  final String name;
  final String image;
  const ProfileTopContent({super.key, required this.name, required this.image});
  final double _heightProfile = 200.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        height: _heightProfile,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(image),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
