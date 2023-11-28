import 'package:flutter/material.dart';

class PolygonAtribbute extends StatelessWidget {
  final Map<dynamic, dynamic> attribute;
  const PolygonAtribbute({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      child: SizedBox(
        width: 150,
        height: 125,
        child: Center(
          child: ClipPath(
            clipper: Polygon(attribute),
            child: Container(
              color: Colors.blue,
              width: 100.0,
              height: 90.0,
            ),
          ),
        ),
      ),
    );
  }
}

class Polygon extends CustomClipper<Path> {
  final Map<dynamic, dynamic> attribute;

  Polygon(this.attribute);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(40.0 - 4 * convert(attribute["technique"]), size.height * 1 / 3),
      Offset(size.width / 2, (30.0 - 3 * convert(attribute["attack"]))),
      Offset(size.width - 40 + 4 * convert(attribute["creative"]),
          size.height * 1 / 3),
      Offset(size.width * 4 / 5,
          size.height - (40 - 4 * convert(attribute["tactic"]))),
      Offset(size.width * 1 / 5,
          size.height - (40 - 4 * convert(attribute["defense"]))),
    ], true);
    return path;
  }

  convert(dynamic num) {
    return num / 10;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
