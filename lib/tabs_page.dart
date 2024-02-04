import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/activities_page.dart';
import 'package:soccer/pages/home/home_page.dart';
import 'package:soccer/user_preferences.dart';

import 'pages/profile/profile_page.dart';

class TabsPage extends StatelessWidget {
  final UserPreferences _prefs = UserPreferences();
  TabsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = _generateTabs();
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        body: _createBody(),
        bottomNavigationBar: _createTabs(tabs: tabs),
      ),
    );
  }

  Widget _createBody() {
    return TabBarView(
      children: <Widget>[
        const Center(child: ActivitiesPage()),
        if (_prefs.teamId != -1) const Center(child: HomePage()),
        if (_prefs.teamId != -1) const Center(child: ProfilePage()),
      ],
    );
  }

  Widget _createTabs({required List<Widget> tabs}) {
    return Container(
      color: Colors.blue,
      height: 55,
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.blue.shade800,
        ),
        tabs: tabs,
      ),
    );
  }

  List<Widget> _generateTabs() {
    return <Widget>[
      const Tab(icon: Icon(Icons.local_activity_rounded, color: Colors.white)),
      if (_prefs.teamId != -1)
        const Tab(
            icon: Icon(
          Icons.home,
          color: Colors.white,
        )),
      if (_prefs.teamId != -1)
        const Tab(icon: Icon(Icons.person_rounded, color: Colors.white)),
    ];
  }
}
