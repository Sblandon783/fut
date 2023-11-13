import 'package:flutter/material.dart';
import 'package:soccer/pages/admin/views/members_view.dart';
import 'package:soccer/pages/profile/models/profile_model.dart';
import 'package:soccer/pages/profile/providers/provider_profile.dart';
import 'package:soccer/user_preferences.dart';

import '../CustomWidgets/custom_button_exit.dart';

import '../CustomWidgets/custom_card_3.dart';
import '../routines/widgets/views/my_routines_view.dart';
import '../routines/widgets/views/watch_exercise_routine_view.dart';
import 'views/payment_view.dart';
import 'widgets/admin_top_content.dart';

class AdminPage extends StatefulWidget {
  static const id = '/admin_page';
  const AdminPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ProviderProfile _providersProfile = ProviderProfile();
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    _prefs.isModeAdmin = true;
    _prefs.pageId = AdminPage.id;
    super.initState();
    _getProfile();
  }

  _getProfile() async {
    _prefs.userId = 1;
    await _providersProfile.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Admin"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [CustomButtonExit()],
          backgroundColor: const Color.fromARGB(255, 62, 111, 233),
        ),
        body: _generateContent(),
      ),
    );
  }

  Widget _generateContent() => Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 28, 67, 165),
                const Color.fromARGB(255, 28, 67, 165),
                const Color.fromARGB(255, 36, 81, 194),
                const Color.fromARGB(255, 36, 81, 194),
                Colors.blue.shade600,
                Colors.blue.shade400,
                Colors.purple.shade400,
              ],
            ),
          ),
          child: StreamBuilder(
            stream: _providersProfile.profileStream,
            builder:
                (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) =>
                    snapshot.hasData
                        ? Column(
                            children: [
                              AdminTopContent(
                                  name: snapshot.data!.name,
                                  image: snapshot.data!.image),
                              _generateInfo(profile: snapshot.data),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
          ),
        ),
      );

  Widget _generateInfo({required ProfileModel? profile}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ..._generateRow(widgets: [
            CustomCard3(
              icon: 'member',
              onTap: _members,
              text: "Miembros",
            ),
            CustomCard3(
              icon: 'paymentDate',
              onTap: _payments,
              text: "Pagos",
            ),
          ]),
          ..._generateRow(
            widgets: [
              CustomCard3(
                icon: 'exercises',
                onTap: _watchAllExercises,
                text: "Ejercicios",
              ),
              CustomCard3(
                icon: 'repeat',
                onTap: _routines,
                text: "Rutinas",
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _generateRow({required List<Widget> widgets}) => [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ];

  void _routines() {
    final route = MaterialPageRoute(
        builder: (context) => MyRoutinesView(
              userId: _prefs.isAdmin ? -1 : _prefs.userId,
            ));
    Navigator.push(context, route);
  }

  void _watchAllExercises() {
    _prefs.pageId = WatchExerciseRoutineView.id;
    final route = MaterialPageRoute(
        builder: (context) => const WatchExerciseRoutineView(idRoutine: -1));
    Navigator.push(context, route);
  }

  void _members() {
    final route = MaterialPageRoute(builder: (context) => const MembersView());
    Navigator.push(context, route);
  }

  void _payments() {
    final route =
        MaterialPageRoute(builder: (context) => const PaymentViewView());
    Navigator.push(context, route);
  }
}
