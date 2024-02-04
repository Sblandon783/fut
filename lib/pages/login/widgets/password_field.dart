import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _show = false;
  @override
  Widget build(BuildContext context) => TextField(
        controller: widget.controller,
        obscureText: !_show,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Contraseña',
          suffixIcon: GestureDetector(
              onTap: () => setState(() => _show = !_show),
              child: Icon(_show
                  ? Icons.remove_red_eye_sharp
                  : Icons.remove_red_eye_outlined)),
        ),
        maxLength: 20,
      );
}
