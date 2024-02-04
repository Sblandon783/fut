import 'package:flutter/material.dart';

class SuccessfullDialog extends StatelessWidget {
  final String name;
  const SuccessfullDialog({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              '$name ya eres parte de SOCCER APP',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
