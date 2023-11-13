import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/history_model.dart';

import '../../../CustomWidgets/custom_button_exit.dart';
import '../../provider/provider_my_routines.dart';
import 'exercise_routine_view.dart';

class HistoryRoutineView extends StatefulWidget {
  final int idRoutine;

  const HistoryRoutineView({Key? key, required this.idRoutine})
      : super(key: key);

  @override
  HistoryRoutineViewState createState() => HistoryRoutineViewState();
}

class HistoryRoutineViewState extends State<HistoryRoutineView> {
  final ProviderMyRoutines _provider = ProviderMyRoutines();

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  void getExercises() =>
      _provider.getHistoryRoutine(idRoutine: widget.idRoutine);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Progreso"),
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
          height: double.infinity,
          color: const Color.fromARGB(255, 238, 238, 238),
          child: StreamBuilder(
              stream: _provider.progressStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<RecordModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? _generateGridView(
                          records: snapshot.data ?? [],
                        )
                      : const Center(child: Text("No hay registros"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Widget _generateGridView({required List<RecordModel> records}) =>
      SingleChildScrollView(
        child: Column(
          children: records
              .map((RecordModel record) => _generateRecordCard(record: record))
              .toList(),
        ),
      );

  Widget _generateRecordCard({required RecordModel record}) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _entrerRecord(idRecord: record.id),
            child: SizedBox(
              height: 80.0,
              width: 350.0,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            color: Colors.blue,
                          ),
                          child: Text(
                            record.date.split(" ").first,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 70.0,
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 40.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _entrerRecord({required int idRecord}) {
    final route = MaterialPageRoute(
      builder: (context) => ExerciseRoutineView(
        id: idRecord,
        pendingToday: false,
        isRecord: true,
      ),
    );
    Navigator.push(context, route);
  }
}
