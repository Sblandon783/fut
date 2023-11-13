import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';
import 'package:soccer/pages/routines/widgets/custom_slidable.dart';

import '../../../CustomWidgets/custom_button_exit.dart';
import '../../provider/provider_my_routines.dart';

class ExerciseRoutineView extends StatefulWidget {
  final int id;
  final bool pendingToday;
  final bool isRecord;

  const ExerciseRoutineView(
      {Key? key,
      required this.id,
      required this.pendingToday,
      this.isRecord = false})
      : super(key: key);

  @override
  ExerciseRoutineViewState createState() => ExerciseRoutineViewState();
}

class ExerciseRoutineViewState extends State<ExerciseRoutineView> {
  final ProviderMyRoutines _provider = ProviderMyRoutines();

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  void getExercises() => widget.isRecord
      ? _provider.getExercisesByRecord(idRecord: widget.id)
      : widget.pendingToday
          ? _provider.getExercisesToDo(idRoutine: widget.id)
          : _provider.getExercises(idRoutine: widget.id);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("${widget.isRecord ? 'Progreso' : 'Sesión'} actual"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        floatingActionButton: widget.isRecord
            ? null
            : FloatingActionButton(
                onPressed: _saveProgress,
                tooltip: 'Agregar partido',
                child: Icon(
                  widget.pendingToday ? Icons.edit : Icons.check,
                  size: 20.0,
                ),
              ),
        body: Container(
          height: double.infinity,
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
                      : const Text("Not data 2");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Widget _generateGridView({required List<ExerciseModel> exercises}) => Column(
        children: [
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _containerFlex(child: const Text("Name")),
                _containerFlex(child: const Text("Rep")),
                _containerFlex(child: const Text("Peso"))
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: exercises
                  .map((ExerciseModel exercise) => CustomSlidable(
                        exercise: exercise,
                        provider: _provider,
                        disabledSlider: widget.isRecord,
                      ))
                  .toList(),
            ),
          ),
        ],
      );

  Widget _containerFlex({required Widget child}) => Flexible(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: child,
        ),
      );

  _saveProgress() {
    if (widget.pendingToday) {
      _provider.editSesion();
    } else {
      _provider.createSesion(idRoutine: widget.id);
    }

    SnackBar snackBar = SnackBar(
      content:
          Text('${widget.pendingToday ? 'Editado' : 'Creado'} exitosamente'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
