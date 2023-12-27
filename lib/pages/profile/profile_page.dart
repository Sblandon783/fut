import 'package:flutter/material.dart';
import 'package:soccer/pages/login/utils/utils.dart';
import 'package:soccer/pages/profile/profile_top/profile_bottom.dart';

import '../../main.dart';
import '../../user_preferences.dart';

import '../login/login_page.dart';
import '../login/models/member_model.dart';

import 'my_teams.dart';
import 'widgets/attributes/profile_attributes.dart';
import 'profile_top/profile_top.dart';
import 'providers/provider_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderProfile _provider = ProviderProfile();
  final ScrollController _controller = ScrollController();
  final ValueNotifier<bool> _titleNotifier = ValueNotifier(false);

  @override
  void initState() {
    _prefs.isModeAdmin = false;
    _getMyProfile();
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels > 230.0 && !_titleNotifier.value) {
        _titleNotifier.value = true;
      } else if (_controller.position.pixels < 230.0 && _titleNotifier.value) {
        _titleNotifier.value = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getMyProfile() async => _provider.getMyProfile();

  @override
  Widget build(BuildContext context) {
    return _generateSecond();
  }

  Widget c({required MemberModel member}) {
    final Color color = Utils().mapPosSevenColors[member.idPosition];
    Future.delayed(const Duration(seconds: 5))
        .then((value) => App.setTheme(context, color));

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          stretch: true,
          onStretchTrigger: () async {
            //print("object");
          },
          stretchTriggerOffset: 300.0,
          expandedHeight: 300.0,
          centerTitle: true,
          floating: true,
          pinned: true,
          titleSpacing: 0.0,
          leading: const SizedBox.shrink(),
          flexibleSpace: FlexibleSpaceBar(
            title: ValueListenableBuilder(
              valueListenable: _titleNotifier,
              builder: (context, show, child) => show
                  ? Text(
                      member.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  : ProfileBottom(member: member),
            ),
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            expandedTitleScale: 1.3,
            background: ProfileTop(member: member),
          ),
          toolbarHeight: 40.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.white,
                  )),
            )
          ],
          backgroundColor: color,
          foregroundColor: Colors.blue,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SizedBox(
                height: 700,
                width: double.infinity,
                child: _generateCard(member: member),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  Widget _generateSecond() => StreamBuilder(
      stream: _provider.memberStream,
      builder: (BuildContext context, AsyncSnapshot<MemberModel> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data != null
              ? c(member: snapshot.data!)
              : const SizedBox.shrink();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });

  Widget _generateCard({required MemberModel member}) {
    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
              child: Column(
            children: [
              ProfileAttributes(member: member),
            ],
          )),
        ),
        const MyTeams(),
      ],
    );
  }
}
