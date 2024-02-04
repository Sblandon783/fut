import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer/pages/login/utils/utils.dart';
import 'package:soccer/pages/login/widgets/name_field.dart';
import 'package:soccer/pages/login/widgets/password_field.dart';
import 'package:soccer/pages/login/widgets/title_login.dart';

import '../background.dart';
import '../bottom_card.dart';
import '../custom_card.dart';
import '../custom_drop_down.dart';
import '../logo.dart';

class SignUp extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController numberController;
  final Function({required int pos}) changePosition;
  final Function({required bool isStartSession}) login;
  final Function({required bool change}) changeToSignUp;

  const SignUp({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.numberController,
    required this.changePosition,
    required this.login,
    required this.changeToSignUp,
  });

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final Utils _utils = Utils();
  final double _heightProfile = 150.0;

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) => _generateContent();

  Widget _generateContent() => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const Background(),
          CustomCard(
            height: 450.0,
            top: _heightProfile,
            childrens: [
              const TitleLogin(),
              NameField(controller: widget.usernameController),
              PasswordField(controller: widget.passwordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 110.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5),
                    child: TextField(
                      controller: widget.numberController,
                      decoration:
                          const InputDecoration(labelText: "Nº De Dorsal"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                    child: CustomDropDown(
                      key: UniqueKey(),
                      dropdownValue: _utils.getPositions.keys.first.toString(),
                      list: _utils.getPositions,
                      change: widget.changePosition,
                      text: "Posición",
                    ),
                  ),
                ],
              ),
              BottomCard(
                changeToSignUp: widget.changeToSignUp,
                login: widget.login,
                isSignUp: true,
              ),
            ],
          ),
          const Logo()
        ],
      );
}
