import 'package:flutter/material.dart';

import '../models/member_model.dart';
import '../models/utils/utils.dart';
import '../providers/provider_members.dart';

class AlignSection extends StatefulWidget {
  const AlignSection({super.key});

  @override
  AlignSectionState createState() => AlignSectionState();
}

class AlignSectionState extends State<AlignSection> {
  final _provider = ProviderMembers();

  @override
  void initState() {
    super.initState();
    _getMembers();
  }

  void _getMembers() async => _provider.getMembers();

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: _provider.membersStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MemberModel>> snapshot) {
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
                    ..._generateBurbbles(members: snapshot.data!),
                    Positioned(
                      bottom: 0,
                      left: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTitulares(members: snapshot.data!),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                height: 150.0, width: 1, color: Colors.grey),
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

  List<Widget> _generateBurbbles({required List<MemberModel> members}) {
    List<Widget> childrens = [];
    Utils().mapPosSeven.forEach((key, value) {
      MemberModel? currentMember = _findMember(members: members, position: key);

      String number =
          currentMember != null ? currentMember.number.toString() : '?';
      childrens.add(_generateBurbble(idPos: key, pos: value, number: number));
    });
    return childrens;
  }

  MemberModel? _findMember(
      {required List<MemberModel> members, required int position}) {
    for (var i = 0; i < members.length; i++) {
      if (members[i].idPosition == position && !members[i].added) {
        members[i].added = true;
        return members[i];
      }
    }
    return null;
  }

  Widget _generateBurbble({
    required int idPos,
    required Map<String, double> pos,
    required String number,
  }) {
    return Positioned(
      top: pos["top"],
      right: pos["right"],
      child: Container(
        height: 27.0,
        width: 27.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.white,
          ),
          color: Utils().mapPosSevenColors[idPos],
        ),
        padding: EdgeInsets.zero,
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitulares({required List<MemberModel> members}) {
    List<MemberModel> currentMembers = [];
    currentMembers.addAll(members);
    currentMembers.removeWhere((member) => !member.added);
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
    currentMembers.removeWhere((member) => member.added);
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
}
