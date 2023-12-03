import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/field_notifier.dart';
import 'package:soccer/pages/align/align_field/align_field.dart';
import 'package:soccer/pages/align/list_player_content.dart';
import 'package:soccer/pages/align/list_player_top.dart';

import '../login/models/match_model.dart';
import '../login/models/member_model.dart';

import '../login/providers/provider_members.dart';

class AlignSection extends StatefulWidget {
  final MatchModel match;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
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

  @override
  void initState() {
    super.initState();
    _provider.match = widget.match;
    _getMembers();
  }

  void _getMembers() async => _provider.getMembers(idMvp: -1);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: widget.typeAlignNotifier,
      builder: (context, type, child) {
        _getMembers();
        return StreamBuilder(
            stream: _provider.membersStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<MemberModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Column(
                        children: [
                          AlignField(
                            members: snapshot.data!,
                            match: widget.match,
                            typeAlignNotifier: widget.typeAlignNotifier,
                            provider: _provider,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: _getTitulares(
                                      members: snapshot.data!,
                                    ),
                                  ),
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

  Widget _getTitulares({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => member.added || !member.titular);

    return _generateList(
      members: currentMembers,
      isTitular: true,
    );
  }

  Widget _getAusents({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => !member.added && member.titular);

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
}
