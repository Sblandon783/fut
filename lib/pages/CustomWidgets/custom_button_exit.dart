import 'package:flutter/material.dart';

import '../../user_preferences.dart';
import '../login/login_page.dart';

class CustomButtonExit extends StatelessWidget {
  final UserPreferences _prefs = UserPreferences();
  CustomButtonExit({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: GestureDetector(
            onTap: () {
              _prefs.isLogin = false;
              final route =
                  MaterialPageRoute(builder: (context) => const LoginPage());
              Navigator.push(context, route);
            },
            child: const Icon(Icons.exit_to_app_rounded)),
      );
}
