import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/widgets/team/team_view.dart';

import '../../user_preferences.dart';

import '../login/models/member_model.dart';

import 'widgets/attributes/profile_attributes.dart';
import 'profile_top.dart';
import 'providers/provider_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderProfile _provider = ProviderProfile();

  @override
  void initState() {
    _prefs.isModeAdmin = false;
    _getMyProfile();
    super.initState();
  }

  void _getMyProfile() async => _provider.getMyProfile();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: _generateSecond(),
      ),
    );
  }

  Widget _generateSecond() => StreamBuilder(
      stream: _provider.memberStream,
      builder: (BuildContext context, AsyncSnapshot<MemberModel> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? _generateCard(member: snapshot.data!)
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _generateCard({required MemberModel member}) {
    return Column(
      children: [
        ProfileTop(member: member),
        Flexible(
          child: SingleChildScrollView(
              child: Column(
            children: [
              ProfileAttributes(member: member),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            width: 320,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mis equipos",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    GestureDetector(
                      onTap: _onTap,
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white,
                          child: Center(
                            child: SizedBox(
                              height: 70.0,
                              width: 70.0,
                              child: _teamImage(image: 'assets/logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _teamImage({required String image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: Image(
        height: double.infinity,
        image: AssetImage(image),
      ),
    );
  }

  void _onTap() {
    final route = MaterialPageRoute(
      builder: (context) => TeamView(
        key: UniqueKey(),
        id: 1,
      ),
    );
    Navigator.push(context, route).then((value) {});
  }
}
