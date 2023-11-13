import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';
import 'package:soccer/pages/routines/widgets/dialogs/create_exercise%20copy.dart';

import '../../provider/provider_my_routines.dart';
import 'alerts.dart';

class AddExercise extends StatefulWidget {
  final ExerciseModel exercise;
  final Function() onTap;

  const AddExercise({Key? key, required this.exercise, required this.onTap})
      : super(key: key);

  @override
  AddExerciseState createState() => AddExerciseState();
}

class AddExerciseState extends State<AddExercise> {
  final ProviderMyRoutines _provider = ProviderMyRoutines();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.close),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Selecciona una opción",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                    onPressed: _showAddExercise,
                    child: const Text("Crear un ejercicios")),
              ),
              /*
              ElevatedButton(
                onPressed: () {},
                child: const Text("Seleccionar un ejercicios"),
              ),
              */
            ],
          ),
        )
      ],
    );
  }

  Future<void> _showAddExercise() async {
    Alerts.generateAlert(
        content: CreateExercise(exercise: widget.exercise),
        context: context,
        onPressed: widget.onTap,
        texButton: "Agregar");
  }
}
