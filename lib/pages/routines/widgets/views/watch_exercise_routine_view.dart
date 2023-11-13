import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';
import 'package:soccer/pages/routines/widgets/dialogs/add_exercise.dart';
import 'package:soccer/pages/routines/widgets/views/routine_view.dart';
import 'package:soccer/user_preferences.dart';

import '../../../CustomWidgets/custom_button_exit.dart';
import '../../provider/provider_my_routines.dart';
import '../dialogs/alerts.dart';
import '../dialogs/create_exercise copy.dart';

class WatchExerciseRoutineView extends StatefulWidget {
  static const id = 'exercises';
  final int idRoutine;

  const WatchExerciseRoutineView({Key? key, required this.idRoutine})
      : super(key: key);

  @override
  WatchExerciseRoutineViewState createState() =>
      WatchExerciseRoutineViewState();
}

class WatchExerciseRoutineViewState extends State<WatchExerciseRoutineView> {
  final ProviderMyRoutines _provider = ProviderMyRoutines();
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    _getExercises();
  }

  void _getExercises() => _provider.getExercises(idRoutine: widget.idRoutine);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Lista de ejercicios"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        body: Container(
          color: const Color.fromARGB(255, 238, 238, 238),
          child: StreamBuilder(
              stream: _provider.exercisesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ExerciseModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? _generateGridView(
                          exercises: snapshot.data ?? [],
                        )
                      : const Text("Not data");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
        floatingActionButton: _prefs.isAdmin
            ? FloatingActionButton(
                onPressed: _showAddExercise,
                tooltip: 'Agregar partido',
                child: const Icon(
                  Icons.add,
                  size: 20.0,
                ),
              )
            : null,
      ),
    );
  }

  Widget _generateGridView({required List<ExerciseModel> exercises}) =>
      CustomScrollView(primary: false, slivers: <Widget>[
        SliverGrid.count(
          childAspectRatio: 1.3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: exercises
              .map(
                  (ExerciseModel exercise) => _generateCard(exercise: exercise))
              .toList(),
        ),
      ]);

  Widget _generateCard({required ExerciseModel exercise}) => GestureDetector(
        onTap: () => Alerts.example(context: context, exercise: exercise),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150.0,
              width: 160.0,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child:
                            Image.asset('assets/card2.png', fit: BoxFit.cover),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0, left: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: _generateText(
                                  text: exercise.name.toUpperCase(),
                                  fontSize: 12.0),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Dificultad".toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  _genarateDifficulty(dif: exercise.difficulty)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
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
        child: Container(
          color: i < dif ? color : Colors.grey,
          width: 10,
        ),
      ));
    }
    return SizedBox(width: 70, height: 20.0, child: Row(children: list));
  }

  Widget _generateText({required String text, double fontSize = 12.0}) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      );

  Future<void> _showAddExercise() async {
    final ExerciseModel exercise =
        ExerciseModel.fromJson({'id_routine': widget.idRoutine});
    if (_prefs.pageId == RoutineView.id) {
      Alerts.generateAlert(
        content: AddExercise(
            exercise: exercise,
            onTap: () => _callAddExercise(newExercise: exercise)),
        context: context,
      );
    } else {
      Alerts.generateAlert(
          content: CreateExercise(exercise: exercise),
          context: context,
          onPressed: () => _callAddExercise(newExercise: exercise),
          texButton: "Agregar");
    }
  }

  void _callAddExercise({required ExerciseModel newExercise}) async {
    bool result = await _provider.addExercise(exercise: newExercise);
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (newExercise.idRoutine != -1) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
      _getExercises();
      /*
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceIn,
      );*/

      //setState(() => _showOption = !_showOption);
    }
  }
}
