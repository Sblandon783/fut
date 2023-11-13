import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';

class AlertEditWeigthSize extends StatefulWidget {
  final ExerciseModel exercise;

  const AlertEditWeigthSize({Key? key, required this.exercise})
      : super(key: key);

  @override
  AlertEditWeigthSizeState createState() => AlertEditWeigthSizeState();
}

class AlertEditWeigthSizeState extends State<AlertEditWeigthSize> {
  late TextEditingController _controllerWeigth;
  late TextEditingController _controllerRep;
  List<String> list = <String>['Lbs', 'Kg'];
  late String _dropdownValue;
  @override
  void initState() {
    _dropdownValue = list[widget.exercise.type];
    _controllerWeigth =
        TextEditingController(text: widget.exercise.weigth.toString());
    _controllerRep =
        TextEditingController(text: widget.exercise.rep.toString());
    _listenners();
    super.initState();
  }

  _listenners() {
    _controllerRep.addListener(
        () => widget.exercise.rep = int.parse(_controllerRep.text));
    _controllerWeigth.addListener(
        () => widget.exercise.weigth = int.parse(_controllerWeigth.text));
  }

  @override
  Widget build(BuildContext context) => _content();

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            color: Colors.blue,
            child: Stack(
              children: [
                const Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Editar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controllerRep,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repeticiones',
                ),
              ),
            ),
            const SizedBox(
              width: 30,
              child: Text(
                "X",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 80,
              child: TextField(
                controller: _controllerWeigth,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Peso',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20),
              child: DropdownButton<String>(
                value: _dropdownValue,
                //icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdownValue = value!;
                    widget.exercise.type = value == list.first ? 0 : 1;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ]),
        )
      ],
    );
  }
}
