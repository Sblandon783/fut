import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';

class CreateExercise extends StatefulWidget {
  final ExerciseModel exercise;
  const CreateExercise({Key? key, required this.exercise}) : super(key: key);

  @override
  CreateExerciseState createState() => CreateExerciseState();
}

class CreateExerciseState extends State<CreateExercise> {
  final TextEditingController _exampleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<int> _difificultyNotifier = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _listenners();
  }

  void _listenners() {
    _nameController
        .addListener(() => widget.exercise.name = _nameController.text);
    _exampleController
        .addListener(() => widget.exercise.example = _exampleController.text);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _exampleController.dispose();
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
                  "Agregar Ejercicio",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              _generateTextField(text: 'Nombre', controller: _nameController),
              _generateTextField(
                  text: 'Ejemplo', controller: _exampleController),
              ValueListenableBuilder(
                valueListenable: _difificultyNotifier,
                builder: (context, count, child) =>
                    _genarateDifficulty(dif: _difificultyNotifier.value),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _generateTextField(
      {required String text, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(text),
        ),
        maxLines: 1,
        minLines: 1,
      ),
    );
  }

  Widget _genarateDifficulty({required int dif}) {
    List<Widget> list = [];
    Color color = dif == 4
        ? Colors.red
        : dif > 2
            ? Colors.orange
            : Colors.green;
    for (var i = 0; i < 4; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () => _onTapDifficulty(level: i + 1),
          child: Container(
            color: i < dif ? color : Colors.grey,
            width: 20,
          ),
        ),
      ));
    }
    return Column(
      children: [
        SizedBox(width: 100, height: 50.0, child: Row(children: list)),
        const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            "DIFICULTAD",
            style: TextStyle(fontSize: 11.0, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  void _onTapDifficulty({required int level}) {
    widget.exercise.difficulty = level;
    _difificultyNotifier.value = level;
  }
}
