import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) => _generateTop();

  Widget _generateTop() {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            stops: const [
              0.01,
              0.1,
              0.4,
              0.5,
              0.6,
              0.8,
              0.9,
            ],
            colors: [
              Colors.purple,
              Colors.purple.shade600,
              Colors.blue.shade600,
              Colors.blue.shade500,
              Colors.blue.shade400,
              Colors.blue.shade300,
              Colors.blue.shade200,
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
