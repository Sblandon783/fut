import 'package:flutter/material.dart';
import 'package:soccer/routes/routes.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/home/home_page.dart';

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

  return runApp(const App());
}

// ignore: use_key_in_widget_constructors, must_be_immutable

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();

  static void setTheme(BuildContext context, Color newColor) {
    AppState? state = context.findAncestorStateOfType<AppState>();
    if (state != null) {
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        state._primary = newColor;
      });
    }
  }
}

class AppState extends State<App> {
  bool isLogin = false;
  String initialRoute = "/login";
  final UserPreferences _prefs = UserPreferences();
  Color _primary =
      Colors.blue; // This will hold the value of the app main color

  @override
  Widget build(BuildContext context) {
    if (_prefs.isLogin) {
      initialRoute = "/login";
    }
    ThemeData lightTheme = ThemeData.light().copyWith(primaryColor: _primary);
    return MaterialApp(
      title: 'Componets App',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: getAplicationRoutes(),
      theme: lightTheme,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const HomePage());
      },
    );
  }
}
