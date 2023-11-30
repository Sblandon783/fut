import 'package:flutter/material.dart';

import 'package:soccer/pages/login/second_part.dart';

import '../../tabs_page.dart';
import '../../user_preferences.dart';
import 'first_part.dart';
import 'providers/provider_members.dart';
import 'widgets/background.dart';

import 'widgets/footer.dart';
import 'widgets/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final UserPreferences _prefs = UserPreferences();
  final _provider = ProviderMembers();
  bool _firstPart = true;
  int _position = 0;
  @override
  void initState() {
    _firstPart = !_prefs.isLogin;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_prefs.isLogin) {
      Future.delayed(const Duration(milliseconds: 10), () {
        final route = MaterialPageRoute(builder: (context) => TabsPage());
        Navigator.push(context, route);
      });
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _generateContent(),
        bottomNavigationBar: const Footer(),
      ),
    );
  }

  Widget _generateContent() => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const Background(),
          ..._firstPart
              ? [
                  FirstPart(
                    key: UniqueKey(),
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    numberController: _numberController,
                    changePosition: _changePosition,
                    login: _login,
                  ),
                  const Logo()
                ]
              : [
                  Positioned(
                      top: 30,
                      right: 10,
                      child: GestureDetector(
                          onTap: () => setState(() {
                                _prefs.isLogin = false;
                                _prefs.userName = '';
                                _firstPart = true;
                              }),
                          child: const Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          ))),
                  SecondPart(key: UniqueKey())
                ],
        ],
      );

  void _login({required bool isStartSession}) async {
    bool nextStep = false;
    if (isStartSession) {
      if (_usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        nextStep = await _provider.login(
          name: _usernameController.text,
          password: _passwordController.text,
        );
      }
    } else {
      if (_numberController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty) {
        nextStep = await _provider.createAccount(
          name: _usernameController.text,
          password: _passwordController.text,
          number: int.parse(_numberController.text),
          position: _position,
        );
      }
    }
    nextStep ? successfulAlert() : unSuccessfulAlert();
  }

  void _changePosition({required int pos}) => _position = pos;

  void successfulAlert() {
    _prefs.isLogin = true;
    _prefs.userName = _usernameController.text;
    _usernameController.text = "";
    _numberController.text = "";
    _passwordController.text = "";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          final route = MaterialPageRoute(builder: (context) => TabsPage());
          Navigator.push(context, route);
          /*
          setState(() => _firstPart = false);
          Navigator.pop(context);
          */
        });
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  '${_usernameController.text} ya eres parte de NoFap FC.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void unSuccessfulAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.close,
                color: Colors.red,
                size: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Datos incorrectos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
