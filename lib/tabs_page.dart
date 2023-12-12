import 'package:flutter/material.dart';
import 'package:soccer/pages/home/home_page.dart';

import 'package:soccer/user_preferences.dart';

import 'pages/profile/profile_page.dart';

class TabsPage extends StatelessWidget {
  final UserPreferences _prefs = UserPreferences();

  TabsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _generateTabs().length,
      initialIndex: 1,
      child: Scaffold(
        body: _createBody(),
        bottomNavigationBar: _createTabs(),
      ),
    );
  }

  Widget _createTabs() {
    return Container(
      color: Colors.blue,
      height: 55,
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.blue.shade800,
        ),
        tabs: _generateTabs(),
      ),
    );
  }

  Widget _createBody() {
    return const TabBarView(
      children: <Widget>[
        //Center(child: HomePage()),
        Center(child: HomePage()),
        //Center(child: AlignPage()),
        Center(child: ProfilePage()),
        // if (_prefs.isAdmin) const Center(child: AdminPage()),
      ],
    );
  }

  List<Widget> _generateTabs() {
    return <Widget>[
      const Tab(icon: Icon(Icons.home)),
      //const Tab(icon: Icon(Icons.note_alt_sharp)),
      const Tab(icon: Icon(Icons.person_rounded)),
      if (_prefs.isAdmin)
        const Tab(icon: Icon(Icons.admin_panel_settings_rounded)),
    ];
  }
}
