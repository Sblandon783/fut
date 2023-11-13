import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class RoutineName extends StatelessWidget {
  final String name;
  final String image;

  const RoutineName({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 170.0,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                    Colors.blue.shade200,
                    Colors.blue.shade100,
                    // Color.fromARGB(255, 238, 238, 238)
                    // Color.fromARGB(255, 238, 238, 238),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            _generateCardTeam(),
          ],
        ),
      );

  Widget _generateCardTeam() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: SizedBox(
          height: double.infinity,
          width: 180.0,
          child: _generateLogo(),
        ),
      ),
    );
  }

  Widget _generateLogo() => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              _generateContentCard(),
              Text(
                name.toUpperCase(),
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _generateContentCard() => Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: image.contains('https')
            ? Image(
                //width: 90.0,
                height: 100.0,
                image: NetworkImage(image),
              )
            : imageFromBase64String(image: image),
      ));

  Image imageFromBase64String({required String image}) => Image.memory(
        base64Decode(image),
        fit: BoxFit.cover,
        height: 100.0,
      );

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  String base64String(Uint8List data) => base64Encode(data);
}
