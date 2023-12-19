import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../CustomWidgets/empty_data.dart';
import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/widgets/card_member/card_member.dart';
import '../../provider/provider_match.dart';

class PlayersSection extends StatefulWidget {
  final ProviderMembers provider;
  final int idMVP;
  final bool isFinishedMatch;

  const PlayersSection({
    super.key,
    required this.idMVP,
    required this.provider,
    required this.isFinishedMatch,
  });

  @override
  PlayersSectionState createState() => PlayersSectionState();
}

class PlayersSectionState extends State<PlayersSection> {
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier(false);
  final ProviderMatch _providerMatch = ProviderMatch();
  @override
  void initState() {
    _getMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _playersSection();

  void _getMembers() async => widget.provider.getMembers(
        idMvp: widget.idMVP,
      );

  Widget _playersSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
            stream: widget.provider.membersStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<MemberModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Center(
                                  child: Text(
                                    "Participantes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    String text = "";
                                    for (var i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      text =
                                          '$text${i + 1}- ${snapshot.data![i].name}\n';
                                    }

                                    Clipboard.setData(ClipboardData(
                                        text: 'Lista de jugadares\n$text'));
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Icon(Icons.copy, size: 16.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ValueListenableBuilder(
                                valueListenable: _buttonNotifier,
                                builder: (context, show, child) => Center(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Total ${widget.provider.members.length}',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(color: Colors.grey, height: 5.0),
                            ),
                            SizedBox(
                              height: 290.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: _generateMembers(
                                    members: snapshot.data ?? []),
                              ),
                            ),
                          ],
                        ),
                      )
                    : EmptyData(
                        text: widget.isFinishedMatch
                            ? "Partido finalizado"
                            : "Se el primero en enlistarte",
                        image: "section_players1.jpeg",
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        if (!widget.isFinishedMatch)
          ValueListenableBuilder(
            valueListenable: _buttonNotifier,
            builder: (context, show, child) => Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: show ? Colors.red : Colors.blue,
                    ),
                    onPressed: () async {
                      bool addMe = await widget.provider.updateAssistants(
                          idMatch: widget.provider.match!.id, isAdd: !show);
                      if (!addMe) {
                        _buttonNotifier.value = widget.provider.isIncluded();
                      }
                    },
                    child: Text(
                        show ? "Darme de baja" : "Agregarme como leyenda"))),
          ),
      ],
    );
  }

  List<Widget> _generateMembers({required List<MemberModel> members}) {
    Future.delayed(const Duration(microseconds: 50))
        .then((value) => _buttonNotifier.value = widget.provider.isIncluded());
    List<MemberModel> membersCurrent = List.from(members);
    membersCurrent.removeWhere((member) => !member.included);
    return membersCurrent.map((member) {
      bool isSpecial = member.id == widget.provider.myIdMember;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: isSpecial ? 0.0 : 10.0),
        child: CardMember(
          idMatch: widget.provider.match!.id,
          member: member,
          isSpecial: isSpecial,
          height: isSpecial ? 290.0 : 270.0,
          width: isSpecial ? 160.0 : 150.0,
          performance: widget.isFinishedMatch
              ? widget.provider.match!.listPerformance[member.id.toString()] ??
                  {-1: 5}
              : {},
          updatePerformance: _updatePerformance,
        ),
      );
    }).toList();
  }

  Future<bool> _updatePerformance({
    required Map<dynamic, dynamic> performance,
    required int idMatch,
    required int idMember,
  }) async {
    widget.provider.match!.listPerformance[idMember.toString()] = performance;
    return await _providerMatch.updatePerformance(
      performance: widget.provider.match!.listPerformance,
      idMatch: idMatch,
    );
  }
}
