import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/routine_model.dart';
import 'package:soccer/pages/routines/widgets/views/routine_view.dart';

import '../../../user_preferences.dart';

class CustomCardRoutine extends StatefulWidget {
  final RoutineModel routine;
  final UserPreferences prefs;
  final Function deleteTeam;

  const CustomCardRoutine({
    super.key,
    required this.routine,
    required this.prefs,
    required this.deleteTeam,
  });

  @override
  CustomCardRoutineState createState() => CustomCardRoutineState();
}

class CustomCardRoutineState extends State<CustomCardRoutine> {
  final Gradient _gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [
      0.01,
      0.4,
      0.5,
      0.6,
      0.9,
    ],
    colors: [
      Colors.purple,
      Colors.blue.shade600,
      Colors.blue.shade500,
      Colors.blue.shade500,
      Colors.blue.shade600,
      Colors.purple,
    ],
  );

  final bool _revertCard = false;

  @override
  Widget build(BuildContext context) => _generateCardTeam();

  Widget _generateCardTeam() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      child: Container(
        height: 150.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [
              0.01,
              0.4,
              0.5,
              0.6,
              0.9,
            ],
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade500,
              Colors.blue.shade400,
              Colors.blue.shade500,
              Colors.blue.shade900,
            ],
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            GestureDetector(
              onTap: _routineSelected,
              child: _generateContentCard(),
            )
          ],
        ),
      ),
    );
  }

  void _routineSelected() {
    print(widget.routine.id);
    print(widget.routine.dateHistory);

    final route = MaterialPageRoute(
        builder: (context) => RoutineView(routine: widget.routine));
    Navigator.push(context, route);
  }

  Widget _generateContentCard() => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150.0,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [
                      0.01,
                      0.4,
                      0.5,
                      0.6,
                      0.9,
                    ],
                    colors: [
                      Colors.blue.shade600,
                      Colors.blue.shade400,
                      Colors.blue.shade300,
                      Colors.blue.shade400,
                      Colors.blue.shade600,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _generateRoutine(
                        name: widget.routine.name, image: widget.routine.image),
                    if (_revertCard && widget.prefs.isLogin)
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.black.withOpacity(0.8)),
                        child: GestureDetector(
                          onTap: () => widget.deleteTeam(),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 50.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _generateRoutine({required String name, required String image}) =>
      Column(
        children: [
          widget.routine.image.contains('https')
              ? Image(
                  //width: 90.0,
                  height: 90.0,
                  image: NetworkImage(image),
                )
              : imageFromBase64String(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _generateText(text: name, fontSize: 12.0),
          ),
        ],
      );

  Widget _generateText({required String text, double fontSize = 12.0}) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      );

  Image imageFromBase64String() => Image.memory(
        base64Decode(widget.routine.image),
        fit: BoxFit.cover,
        height: 90.0,
      );

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  String base64String(Uint8List data) => base64Encode(data);
}
