import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/widgets/new_players/card/card_new_players.dart';
import 'package:soccer/pages/activities/widgets/new_players/title_new_players.dart';
import 'package:soccer/pages/login/login_page.dart';

import '../../../../user_preferences.dart';
import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../profile/nav_bar/leading_button.dart';

class NewPlayers extends StatefulWidget {
  const NewPlayers({
    Key? key,
  }) : super(key: key);

  @override
  NewPlayersState createState() => NewPlayersState();
}

class NewPlayersState extends State<NewPlayers> {
  final UserPreferences _prefs = UserPreferences();
  final ProviderMembers _providerMembers = ProviderMembers();

  @override
  void initState() {
    super.initState();
    _getMembers();
  }

  _getMembers() async {
    await _providerMembers.getMembersInvitation();
  }

  _action({required int idMember, required bool isAdd}) async {
    if (isAdd) {
      await _providerMembers.accepteMember(idMember: idMember);
    } else {
      await _providerMembers.deleteMember(idMember: idMember);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                  onTap: () {
                    _prefs.isLogin = false;
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Icon(Icons.exit_to_app_rounded)),
            )
          ],
          leading: const LeadingButton(),
        ),
        backgroundColor: Colors.blue.shade700,
        body: _generateContent(),
      ),
    );
  }

  _generateContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleNewPlayers(),
          StreamBuilder(
              stream: _providerMembers.membersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MemberModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data != null
                      ? snapshot.data!.isEmpty
                          ? const Text(
                              "No hay jugadores para mostrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Center(
                              child: GridView.builder(
                                controller: null,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 350,
                                ),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  MemberModel member = snapshot.data![index];
                                  return CardNewPlayers(
                                    member: member,
                                    action: _action,
                                  );
                                },
                              ),
                            )
                      : const Text("No estás en ningun equipo");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
