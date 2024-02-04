import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer/routes/routes.dart';
import 'package:soccer/tabs_page.dart';
import 'package:soccer/user_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/cubit/theme_cubit.dart';

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

  return runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (coontext) => ThemeCubit())],
      child: App(),
    ),
  );
}

// ignore: use_key_in_widget_constructors, must_be_immutable

class App extends StatelessWidget {
  final UserPreferences _prefs = UserPreferences();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = "/home";
    if (!_prefs.isLogin) {
      initialRoute = "/login";
    } else {
      initialRoute = _prefs.pageId;
    }
    //ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return MaterialApp(
      title: 'Componets App',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: getAplicationRoutes(),
      //theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => TabsPage());
      },
    );
  }
}
