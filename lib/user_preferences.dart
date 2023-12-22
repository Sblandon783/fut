import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences with ChangeNotifier {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() => _instancia;

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLogin => _prefs.getBool('isLogin') ?? false;
  set isLogin(bool value) => _prefs.setBool('isLogin', value);

  bool get isAdmin => _prefs.getBool('isAdmin') ?? false;
  set isAdmin(bool value) => _prefs.setBool('isAdmin', value);

  bool get isModeAdmin => _prefs.getBool('isModeAdmin') ?? false;
  set isModeAdmin(bool value) => _prefs.setBool('isModeAdmin', value);

  int get userId => _prefs.getInt('userId') ?? -1;
  set userId(int value) => _prefs.setInt('userId', value);

  String get userName => _prefs.getString('userName') ?? '';
  set userName(String value) => _prefs.setString('userName', value);

  bool get included => _prefs.getBool('included') ?? false;
  set included(bool value) => _prefs.setBool('included', value);

  bool get isRememberme => _prefs.getBool('isRememberme') ?? false;
  set isRememberme(bool value) => _prefs.setBool('isRememberme', value);

  String get pageId => _prefs.getString('pageId') ?? '';
  set pageId(String value) => _prefs.setString('pageId', value);

  String get nextDatePayment => _prefs.getString('nextDatePayment') ?? '';
  set nextDatePayment(String value) =>
      _prefs.setString('nextDatePayment', value);

  int get teamId => _prefs.getInt('teamId') ?? 1;
  set teamId(int value) => _prefs.setInt('teamId', value);
}
