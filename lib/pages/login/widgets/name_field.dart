import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        obscureText: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nombre del crack!',
        ),
        maxLength: 20,
      );
}
