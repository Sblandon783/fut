import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/bottom_card.dart';
import 'package:soccer/pages/login/widgets/name_field.dart';
import 'package:soccer/pages/login/widgets/password_field.dart';
import 'package:soccer/pages/login/widgets/title_login.dart';

import '../background.dart';
import '../custom_card.dart';
import '../logo.dart';

class StartSession extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController numberController;
  final Function({required int pos}) changePosition;
  final Function({required bool isStartSession}) login;
  final Function({required bool change}) changeToSignUp;

  const StartSession({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.numberController,
    required this.changePosition,
    required this.login,
    required this.changeToSignUp,
  });

  @override
  StartSessionState createState() => StartSessionState();
}

class StartSessionState extends State<StartSession> {
  final double _heightProfile = 150.0;
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const Background(),
        CustomCard(
          top: _heightProfile,
          height: 380.0,
          childrens: [
            const TitleLogin(),
            NameField(controller: widget.usernameController),
            PasswordField(controller: widget.passwordController),
            BottomCard(
              changeToSignUp: widget.changeToSignUp,
              login: widget.login,
              isSignUp: false,
            ),
          ],
        ),
        const Logo()
      ],
    );
  }
}
