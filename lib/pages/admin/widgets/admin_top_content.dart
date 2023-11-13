import 'package:flutter/material.dart';

class AdminTopContent extends StatelessWidget {
  final String name;
  final String image;
  const AdminTopContent({super.key, required this.name, required this.image});
  final double _heightProfile = 150.0;

  @override
  Widget build(BuildContext context) => _generateTop();

  Widget _generateTop() {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: SizedBox(
          width: double.infinity,
          height: _heightProfile,
          child: const Image(
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://www.bootstrapdash.com/wp-content/uploads/2019/07/twitter-bootstrap-admin-templates.png"))),
    );
  }
}
