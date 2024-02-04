import 'package:flutter/material.dart';

class UnsuccessfullDialog extends StatelessWidget {
  const UnsuccessfullDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.close,
            color: Colors.red,
            size: 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Datos incorrectos',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
