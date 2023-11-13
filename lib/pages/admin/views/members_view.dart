import 'package:flutter/material.dart';
import 'package:soccer/pages/admin/models/members_model.dart';
import 'package:soccer/pages/admin/models/profile_model.dart';

import '../../../user_preferences.dart';
import '../../CustomWidgets/custom_button_exit.dart';
import '../../routines/widgets/dialogs/alerts.dart';
import '../dialogs/create_member.dart';
import '../providers/provider_members.dart';
import 'member_card.dart';

class MembersView extends StatefulWidget {
  const MembersView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MembersViewState createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  final ScrollController _controller = ScrollController();
  final ProviderMembers _provider = ProviderMembers();
  final UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    _getMembers();
  }

  void _getMembers() => _provider.getMembers();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Miembros"),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          actions: [CustomButtonExit()],
        ),
        floatingActionButton: _prefs.isAdmin
            ? FloatingActionButton(
                onPressed: _showAddMember,
                tooltip: 'Agregar miembro',
                child: const Icon(Icons.add, size: 20.0),
              )
            : null,
        body: Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: StreamBuilder(
              stream: _provider.membersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MemberModel>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? CustomScrollView(
                          controller: _controller,
                          primary: false,
                          slivers: <Widget>[
                            SliverGrid.count(
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: snapshot.data!
                                  .map(
                                    (member) => MemberCard(member: member),
                                  )
                                  .toList(),
                            ),
                          ],
                        )
                      : const Text("Not data");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Future<void> _showAddMember() async {
    final ProfileModel member = ProfileModel.fromJson({});
    Alerts.generateAlert(
        content: CreateMember(member: member),
        context: context,
        onPressed: () => _callAddMember(newMember: member),
        texButton: "Agregar");
  }

  void _callAddMember({required ProfileModel newMember}) async {
    bool result = await _provider.addMember(member: newMember);
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      _getMembers();
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceIn,
      );

      //setState(() => _showOption = !_showOption);
    }
  }

  bool _showOption = false;
  _add() => setState(() => _showOption = !_showOption);
}
