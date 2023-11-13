import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/routine_model.dart';

import '../../../../user_preferences.dart';
import '../../../CustomWidgets/custom_button_exit.dart';
import '../../../CustomWidgets/custom_large_card_.dart';
import '../routine_name.dart';
import 'exercise_routine_view.dart';
import 'history_routine_view.dart';
import 'watch_exercise_routine_view.dart';

class RoutineView extends StatefulWidget {
  static const id = '/routine_view';
  final RoutineModel routine;
  const RoutineView({Key? key, required this.routine}) : super(key: key);

  @override
  RoutineViewState createState() => RoutineViewState();
}

class RoutineViewState extends State<RoutineView> {
  final UserPreferences _prefs = UserPreferences();
  @override
  void initState() {
    _prefs.pageId = RoutineView.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Rutina"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        /*
        floatingActionButton: FloatingActionButton(
          onPressed: _showMyDialogAddTeam,
          tooltip: 'Agregar partido',
          child: const Icon(
            Icons.add,
            size: 20.0,
          ),
        ),
        */
        body: Container(
          color: const Color.fromARGB(255, 238, 238, 238),
          child: Column(
            children: [
              RoutineName(
                  name: widget.routine.name, image: widget.routine.image),
              const SizedBox(height: 30.0),
              ..._prefs.isModeAdmin
                  ? _genareteAdminUser()
                  : _genareteCommonUser(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _genareteCommonUser() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _generateCard(
            text: 'Ver',
            icon: Icons.remove_red_eye_rounded,
            onTap: _watchRoutine,
          ),
          _generateCard(
            text: 'Historial',
            icon: Icons.history_rounded,
            onTap: _entrerHistory,
          ),
        ],
      ),
      CustomLargeCard(
        text: widget.routine.pendingToday ? "Continuar sesión" : "Nueva sesión",
        onTap: _entrerRoutine,
        icon: widget.routine.pendingToday
            ? Icons.play_arrow_rounded
            : Icons.new_label_rounded,
        color: widget.routine.pendingToday ? Colors.green : Colors.blue,
      ),
    ];
  } // create button to save and finish routine.

  List<Widget> _genareteAdminUser() {
    return [
      CustomLargeCard(
        text: "Ver",
        onTap: _watchRoutine,
        icon: Icons.remove_red_eye_rounded,
        color: Colors.blue,
      ),
    ];
  }

  Widget _generateCard(
          {required String text,
          required IconData icon,
          required void Function() onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150.0,
              width: 160.0,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //gradient: _gradient,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 40.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: _generateText(text: text, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _generateText({required String text, double fontSize = 12.0}) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      );

  void _watchRoutine() {
    final route = MaterialPageRoute(
        builder: (context) =>
            WatchExerciseRoutineView(idRoutine: widget.routine.id));
    Navigator.push(context, route);
  }

  void _entrerRoutine() {
    final route = MaterialPageRoute(
      builder: (context) => ExerciseRoutineView(
        id: widget.routine.id,
        pendingToday: widget.routine.pendingToday,
      ),
    );
    Navigator.push(context, route);
  }

  void _entrerHistory() {
    final route = MaterialPageRoute(
      builder: (context) => HistoryRoutineView(
        idRoutine: widget.routine.id,
      ),
    );
    Navigator.push(context, route);
  }
}
