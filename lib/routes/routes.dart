import 'package:flutter/material.dart';

import 'package:soccer/pages/login/login_page.dart';

import 'package:soccer/tabs_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginPage(),
    '/home': (BuildContext context) => TabsPage(),
    '/profile': (BuildContext context) => TabsPage(),
  };
}
