import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/widgets/dialogs/show_exercise_example.dart';

import '../../models/exercise_model.dart';

class Alerts {
  Alerts.example(
      {required BuildContext context, required ExerciseModel exercise}) {
    Alerts.generateAlert(
        content: ShowExerciseExample(exercise: exercise),
        context: context,
        onPressed: () => Navigator.pop(context),
        texButton: 'Ok');
  }

  Alerts.generateAlert(
      {required Widget content,
      required BuildContext context,
      Function()? onPressed,
      String texButton = ""}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          content: content,
          actions: <Widget>[
            if (texButton.isNotEmpty)
              Center(
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(texButton),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Alerts.add({required BuildContext context, required ExerciseModel exercise}) {
    Alerts.generateAlert(
        content: ShowExerciseExample(exercise: exercise),
        context: context,
        onPressed: () => Navigator.pop(context),
        texButton: "Agregar");
  }

  Alerts.content({
    required BuildContext context,
    required Widget content,
    required String text,
    required Function()? onPressed,
  }) {
    Alerts.generateAlert(
        content: content,
        context: context,
        onPressed: onPressed,
        texButton: text);
  }
}
