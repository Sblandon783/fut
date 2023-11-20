import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/align/check_button.dart';
import 'package:soccer/pages/login/widgets/align/list_player_content.dart';
import 'package:soccer/pages/login/widgets/align/list_player_top.dart';

import '../../models/match_model.dart';
import '../../models/member_model.dart';
import '../../models/utils/utils.dart';
import '../../providers/provider_members.dart';
import '../burbble/burbble.dart';
import 'field_background.dart';

class AlignSection extends StatefulWidget {
  final MatchModel match;
  final ValueNotifier<int> typeAlignNotifier;
  const AlignSection({
    super.key,
    required this.match,
    required this.typeAlignNotifier,
  });

  @override
  AlignSectionState createState() => AlignSectionState();
}

class AlignSectionState extends State<AlignSection> {
  final _provider = ProviderMembers();
  final Utils _utils = Utils();
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier(false);
  final double _heightImage = 200.0;
  @override
  void initState() {
    super.initState();
    _provider.match = widget.match;
    _getMembers();
  }

  void _getMembers() async => _provider.getMembers();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: widget.typeAlignNotifier,
      builder: (context, type, child) {
        return StreamBuilder(
            stream: _provider.membersStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<MemberModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          const FieldBackground(),
                          ..._generateBurbbles(
                            members: snapshot.data!,
                            type: type,
                          ),
                          CheckButton(
                            notifier: _buttonNotifier,
                            onTap: () => _saveAlign(
                              members: snapshot.data!,
                            ),
                          ),
                          SizedBox(
                            width: 300.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: _heightImage + 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                      child: _getTitulares(
                                    members: snapshot.data!,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: Container(
                                      height: 150.0,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Flexible(
                                    child: _getAusents(members: snapshot.data!),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Text("Se el primero en enlistarte");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      });

  List<Widget> _generateBurbbles(
      {required List<MemberModel> members, required int type}) {
    List<Widget> childrens = [];
    for (var i = 0; i < members.length; i++) {
      members[i].added = false;
    }

    Map<int, Map<String, double>> map = _utils.getAlign(id: type);
    map.forEach((key, value) {
      MemberModel currentMember = _findMember(members: members, position: key);
      childrens.add(Burbble(
        idPos: key,
        pos: value,
        members: members,
        member: currentMember,
        updateMembers: _updateMembers,
      ));
    });

    return childrens;
  }

  _updateMembers(
      {required MemberModel member, required MemberModel oldMember}) {
    _buttonNotifier.value = true;
    _provider.updateMember(newMember: member, oldMember: oldMember);
    widget.match.assistants = _provider.match!.assistants;
    widget.match.substitutes = _provider.match!.substitutes;
  }

  MemberModel _findMember(
      {required List<MemberModel> members, required int position}) {
    for (var i = 0; i < members.length; i++) {
      if (members[i].idPositionNew == position &&
          !members[i].added &&
          members[i].titular) {
        members[i].added = true;
        return members[i];
      }
    }
    final MemberModel member = _utils.getMember(position: position);
    return member;
  }

  Widget _getTitulares({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => !member.added || !member.titular);

    return _generateList(
      members: currentMembers,
      isTitular: true,
    );
  }

  Widget _getAusents({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => member.added && member.titular);

    return _generateList(
      members: currentMembers,
      isTitular: false,
    );
  }

  Widget _generateList({
    required List<MemberModel> members,
    required bool isTitular,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: isTitular ? Colors.green.shade300 : Colors.orange.shade300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListPlayerTop(isTitular: isTitular, count: members.length),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
              children: members.isNotEmpty
                  ? members
                      .map((member) => ListPlayerContent(member: member))
                      .toList()
                  : [
                      const Center(
                          child: Text(
                        "No hay",
                        style: TextStyle(color: Colors.white),
                      ))
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAlign({required List<MemberModel> members}) async {
    bool response = await _provider.saveAlign(members: members);
    if (response) {
      SnackBar snackBar = SnackBar(
        content: const Text('Alineación actualizada'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    widget.match.assistants = _provider.match!.assistants;
    widget.match.substitutes = _provider.match!.substitutes;
    _buttonNotifier.value = false;
  }
}
