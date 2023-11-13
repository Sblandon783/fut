import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowExerciseExample extends StatelessWidget {
  final ExerciseModel exercise;

  const ShowExerciseExample({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    if (!exercise.example.contains('http')) {
      return const Text(
        "No hay ejemplo",
        textAlign: TextAlign.center,
      );
    }
    WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(exercise.example));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            exercise.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 240.0, child: WebViewWidget(controller: controller))
      ],
    );
  }
}
