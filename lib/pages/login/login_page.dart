import 'package:flutter/material.dart';

import 'package:soccer/pages/login/widgets/dialogs/successfull_dialog.dart';
import 'package:soccer/pages/login/widgets/dialogs/unsuccessfull_dialog.dart';
import 'package:soccer/pages/login/widgets/sign_up/sign_up.dart';

import '../../tabs_page.dart';
import '../../user_preferences.dart';
import 'widgets/start_session/start_session.dart';
import 'widgets/footer.dart';

import 'providers/provider_members.dart';

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
  bool _isStartSession = true;
  int _position = 0;
  @override
  void initState() {
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

  Widget _generateContent() => _isStartSession
      ? StartSession(
          key: UniqueKey(),
          usernameController: _usernameController,
          passwordController: _passwordController,
          numberController: _numberController,
          changePosition: _changePosition,
          login: _login,
          changeToSignUp: _changeToSignUp,
        )
      : SignUp(
          key: UniqueKey(),
          usernameController: _usernameController,
          passwordController: _passwordController,
          numberController: _numberController,
          changePosition: _changePosition,
          login: _login,
          changeToSignUp: _changeToSignUp,
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
          position: _position == 0 ? 1 : _position,
        );
        if (nextStep) {
          nextStep = await _provider.login(
            name: _usernameController.text,
            password: _passwordController.text,
          );
        }
      }
    }
    nextStep ? successfulAlert() : unSuccessfulAlert();
  }

  void _changePosition({required int pos}) {
    print(pos);
    _position = pos;
  }

  void _changeToSignUp({required bool change}) =>
      setState(() => _isStartSession = change);

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
        });
        return SuccessfullDialog(name: _usernameController.text);
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
        return const UnsuccessfullDialog();
      },
    );
  }
}
