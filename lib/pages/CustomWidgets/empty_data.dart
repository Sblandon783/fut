import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  final String text;
  final String image;

  const EmptyData({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  width: 300.0,
                  height: 150.0,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/$image'),
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      );
}
