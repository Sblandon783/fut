import 'package:flutter/material.dart';
import 'package:soccer/pages/routines/widgets/views/my_routines_view.dart';
import 'package:soccer/pages/login/login_page.dart';

import '../../services/notifi_service.dart';
import '../../user_preferences.dart';
import 'widgets/views/watch_exercise_routine_view.dart';

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({Key? key}) : super(key: key);

  @override
  RoutinesPageState createState() => RoutinesPageState();
}

class RoutinesPageState extends State<RoutinesPage> {
  final UserPreferences _prefs = UserPreferences();
  @override
  void initState() {
    _prefs.isModeAdmin = false;
    //NotificationService().start(_prefs.nextDatePayment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          centerTitle: false,
          title: const Text("Super Gym APP"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Icon(Icons.exit_to_app_rounded)),
            )
          ],
        ),
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 238, 238, 238),
        child: _generateInformation(),
      );

  Widget _generateInformation() {
    return Column(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: _watchAllExercises,
            child: _generateCard(isFirts: true),
          ),
        ),
        const SizedBox(height: 1.0),
        Flexible(
          child: GestureDetector(
            onTap: _myRoutines,
            child: _generateCard(isFirts: false),
          ),
        ),
        const SizedBox(height: 1.0),
      ],
    );
  }

  Widget _generateCard({required bool isFirts}) => Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: isFirts ? Alignment.topCenter : Alignment.bottomCenter,
            end: isFirts ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade400,
              Colors.purple.shade300,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 260.0,
            width: 300.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isFirts
                              ? [
                                  Colors.blue.shade400,
                                  Colors.purple.shade300,
                                  Colors.purple.shade400,
                                ]
                              : [
                                  Colors.blue.shade400,
                                  Colors.blue.shade500,
                                  Colors.blue.shade700,
                                ],
                        ),
                      ),
                      height: 120.0,
                      width: 200,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isFirts
                                ? "Ver ejercicios".toUpperCase()
                                : "Ver mis rutinas".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              isFirts
                                  ? "Todos los ejercicios que tenemos disponibles."
                                  : "Todos las rutinas que tienes agregadas.",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: isFirts ? 105.0 : 80.0,
                  child: SizedBox(
                      height: isFirts ? 130.0 : 200.0,
                      child: Image(
                        image: AssetImage(isFirts
                            ? 'assets/routine.png'
                            : 'assets/routine4.png'),
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  void _myRoutines() {
    final route = MaterialPageRoute(
        builder: (context) => MyRoutinesView(
              userId: _prefs.isAdmin ? -1 : _prefs.userId,
            ));
    Navigator.push(context, route);
  }

  void _watchAllExercises() {
    final route = MaterialPageRoute(
        builder: (context) => const WatchExerciseRoutineView(
              idRoutine: -1,
            ));
    Navigator.push(context, route);
  }
}
