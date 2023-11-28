import 'package:flutter/material.dart';

class PolygonNormal extends StatelessWidget {
  PolygonNormal({super.key});
  final List<Map<dynamic, dynamic>> _labelsList = [
    {"top": 0.0, "text": "Ata"},
    {"top": 40.0, "right": 0.0, "text": "Cre"},
    {"top": 40.0, "left": 0.0, "text": "Téc"},
    {"bottom": 0.0, "right": 20.0, "text": "Tact"},
    {"bottom": 0.0, "left": 20.0, "text": "Def"},
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      child: SizedBox(
        width: 150,
        height: 125,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: Polygon(),
              child: Container(
                color: Colors.white,
                width: 100.0,
                height: 90.0,
              ),
            ),
            ..._labelsList.map((data) => _label(data: data)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _label({required Map<dynamic, dynamic> data}) => Positioned(
        top: data["top"],
        bottom: data["bottom"],
        left: data["left"],
        right: data["right"],
        child: Text(
          data["text"],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      );
}

class Polygon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(0, size.height * 1 / 3),
      Offset(size.width / 2, 0),
      Offset(size.width, size.height * 1 / 3),
      Offset(size.width * 4 / 5, size.height),
      Offset(size.width * 1 / 5, size.height),
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
