import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../login/models/member_model.dart';
import '../../../login/providers/provider_members.dart';
import '../../../login/widgets/card_member/card_member.dart';

class PlayersSection extends StatefulWidget {
  const PlayersSection({super.key});

  @override
  PlayersSectionState createState() => PlayersSectionState();
}

class PlayersSectionState extends State<PlayersSection> {
  final _provider = ProviderMembers();
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier(false);

  @override
  void initState() {
    _getMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _playersSection();

  void _getMembers() async => _provider.getMembers(idMvp: -1);

  Widget _playersSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
            stream: _provider.membersStream,
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
                                    "Participantes de hoy",
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
                                      'Total ${_provider.members.length}',
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
                    : const Text("Se el primero en enlistarte");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        ValueListenableBuilder(
          valueListenable: _buttonNotifier,
          builder: (context, show, child) => Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: show ? Colors.red : Colors.blue,
                  ),
                  onPressed: () async {
                    bool addMe =
                        await (show ? _provider.deleteMe() : _provider.addMe());
                    if (addMe) {
                      _getMembers();
                    } else {
                      _buttonNotifier.value = _provider.isIncluded();
                    }
                  },
                  child:
                      Text(show ? "Darme de baja" : "Agregarme como leyenda"))),
        ),
      ],
    );
  }

  List<Widget> _generateMembers({required List<MemberModel> members}) {
    Future.delayed(const Duration(microseconds: 50))
        .then((value) => _buttonNotifier.value = _provider.isIncluded());

    return members.map((member) {
      bool isSpecial = member.id == _provider.myIdMember;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: isSpecial ? 0.0 : 10.0),
        child: CardMember(
          member: member,
          isSpecial: isSpecial,
          height: isSpecial ? 290.0 : 270.0,
          width: isSpecial ? 160.0 : 150.0,
        ),
      );
    }).toList();
  }
}
