import 'package:flutter/material.dart';
import 'package:soccer/user_preferences.dart';

import '../../login/login_page.dart';

class ExitButton extends StatelessWidget {
  final Color color;
  final UserPreferences _prefs = UserPreferences();

  ExitButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
            onTap: () {
              _prefs.isLogin = false;
              final route =
                  MaterialPageRoute(builder: (context) => const LoginPage());
              Navigator.push(context, route);
            },
            child: Icon(
              Icons.exit_to_app_rounded,
              color: color,
            )),
      );
}
