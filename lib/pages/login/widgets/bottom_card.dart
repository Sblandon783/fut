import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final Function({required bool change}) changeToSignUp;
  final Function({required bool isStartSession}) login;
  final bool isSignUp;
  const BottomCard({
    super.key,
    required this.changeToSignUp,
    required this.login,
    required this.isSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () => changeToSignUp(change: isSignUp),
            child: Text(
              isSignUp ? "Ya soy una leyennda" : "Quiero ser una leyenda",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () => login(isStartSession: !isSignUp),
            child: Text(
              isSignUp ? "Registrarme como leyenda" : "Iniciar como leyenda",
            ),
          ),
        )
      ],
    );
  }
}
