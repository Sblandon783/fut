import 'package:flutter/material.dart';
import 'package:soccer/pages/login/login_page.dart';

import '../../../../user_preferences.dart';
import 'create_challenge.dart';

class NewChallenges extends StatefulWidget {
  const NewChallenges({
    Key? key,
  }) : super(key: key);

  @override
  NewChallengesState createState() => NewChallengesState();
}

class NewChallengesState extends State<NewChallenges> {
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
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
          title: const Text("Nuevos retos"),
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
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back_ios_new_outlined),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTap,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.grey.shade300,
        body: _generateContent(),
      ),
    );
  }

  _generateContent() {
    return const Center(child: Text("Proximamente..."));
  }

  _onTap() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: CreateChallenge(),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null && value) {
        SnackBar snackBar = SnackBar(
          content: Text("Reto creado"),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
