import 'package:flutter/material.dart';
import 'package:soccer/routes/routes.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/routines/routines_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //NotificationService().initNotification();

  await Supabase.initialize(
    url: 'https://wphnxtpgvkcouhktmews.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndwaG54dHBndmtjb3Voa3RtZXdzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1NTU0MjIsImV4cCI6MjAxNTEzMTQyMn0.yqCqM1KaVxYgeLvpGCufuGDtwhCiQlQSKtY-J00o-D0',
  );
  final prefs = UserPreferences();
  await prefs.initPrefs();

  return runApp(MyApp());
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class MyApp extends StatelessWidget {
  bool isLogin = false;
  String initialRoute = "/login";
  final UserPreferences _prefs = UserPreferences();
  @override
  Widget build(BuildContext context) {
    if (_prefs.isLogin) {
      initialRoute = "/login";
    }

    return MaterialApp(
      title: 'Componets App',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: getAplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const RoutinesPage());
      },
    );
  }
}
