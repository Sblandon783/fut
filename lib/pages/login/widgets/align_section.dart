import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../models/member_model.dart';
import '../models/utils/utils.dart';
import '../providers/provider_members.dart';
import 'burbble/burbble.dart';

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
                          const Positioned(
                            top: 0,
                            child: Image(
                              height: 200.0,
                              width: 300.0,
                              image: AssetImage('assets/soccer_field.jpeg'),
                            ),
                          ),
                          ..._generateBurbbles(
                              members: snapshot.data!, type: type),
                          Positioned(
                            top: 180.0,
                            right: 0,
                            child: ValueListenableBuilder(
                              valueListenable: _buttonNotifier,
                              builder: (context, show, child) => show
                                  ? Center(
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            _saveAlign(members: snapshot.data!),
                                        style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(10.0),
                                            backgroundColor: Colors.green),
                                        child: const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _getTitulares(members: snapshot.data!),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                      height: 150.0,
                                      width: 1,
                                      color: Colors.grey),
                                ),
                                _getAusents(members: snapshot.data!),
                              ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Titulares"),
        ...currentMembers
            .map((member) => Row(
                  children: [
                    SizedBox(
                        width: 30.0, child: Text(member.number.toString())),
                    Text(member.name)
                  ],
                ))
            .toList(),
      ],
    );
  }

  Widget _getAusents({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => member.added && member.titular);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Banca"),
        ...currentMembers.isNotEmpty
            ? currentMembers
                .map((member) => Row(
                      children: [
                        SizedBox(
                            width: 30.0, child: Text(member.number.toString())),
                        Text(member.name)
                      ],
                    ))
                .toList()
            : [const Text("No hay")]
      ],
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
