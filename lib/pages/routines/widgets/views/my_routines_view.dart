import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/models/routine_model.dart';

import '../../../../user_preferences.dart';
import '../../../CustomWidgets/custom_button_exit.dart';
import '../../provider/provider_my_routines.dart';
import '../custom_card_routine.dart';
import '../dialogs/alerts.dart';
import '../dialogs/create_routine.dart';

class MyRoutinesView extends StatefulWidget {
  final int userId;
  const MyRoutinesView({Key? key, required this.userId}) : super(key: key);

  @override
  MyRoutinesViewState createState() => MyRoutinesViewState();
}

class MyRoutinesViewState extends State<MyRoutinesView> {
  final ScrollController _controller = ScrollController();
  final ProviderMyRoutines _provider = ProviderMyRoutines();
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    _getRoutines();
  }

  void _getRoutines() => _provider.getRoutines(idUser: widget.userId);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(_prefs.isAdmin ? "Todas Las Rutinas" : "Mis Rutinas"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        floatingActionButton: _prefs.isAdmin
            ? FloatingActionButton(
                onPressed: _showAddRoutine,
                tooltip: 'Agregar partido',
                child: const Icon(
                  Icons.add,
                  size: 20.0,
                ),
              )
            : null,
        body: Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: StreamBuilder(
              stream: _provider.routinesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<RoutineModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? CustomScrollView(
                          controller: _controller,
                          primary: false,
                          slivers: <Widget>[
                            SliverGrid.count(
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: snapshot.data!
                                  .map((routine) => CustomCardRoutine(
                                      routine: routine,
                                      prefs: _prefs,
                                      deleteTeam: () => {}))
                                  .toList(),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(
                          "No tienes rutinas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Future<void> _showAddRoutine() async {
    final RoutineModel routine = RoutineModel(
        id: -1, name: '', image: '', pendingToday: false, dateHistory: '');
    Alerts.generateAlert(
        content: CreateRoutine(routine: routine),
        context: context,
        onPressed: () => _callAddRoutine(newRoutine: routine),
        texButton: "Agregar");
  }

  void _callAddRoutine({required RoutineModel newRoutine}) async {
    bool result =
        await _provider.addRoutine(routine: newRoutine, userId: widget.userId);
    if (_prefs.isAdmin) {}
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      _getRoutines();
      if (_provider.routines.isNotEmpty) {
        _controller.animateTo(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      }

      //setState(() => _showOption = !_showOption);
    }
  }

  bool _showOption = false;
  _add() => setState(() => _showOption = !_showOption);
}
