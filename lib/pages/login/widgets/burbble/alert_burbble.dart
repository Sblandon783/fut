import 'package:flutter/material.dart';

import '../../models/member_model.dart';
import '../../models/utils/utils.dart';
import '../card_member/card_member.dart';
import '../custom_drop_down.dart';

class AlertBurbble extends StatefulWidget {
  final int pos;
  final List<MemberModel> members;
  final MemberModel member;
  const AlertBurbble({
    super.key,
    required this.pos,
    required this.members,
    required this.member,
  });

  @override
  BAlertBurbbleState createState() => BAlertBurbbleState();
}

class BAlertBurbbleState extends State<AlertBurbble> {
  late MemberModel _member;
  @override
  void initState() {
    _member = widget.member;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => _content();

  Widget _content() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      width: 150.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () => {
                        Navigator.pop(context),
                      },
                  child: const Icon(
                    Icons.close,
                    size: 25.0,
                  ))),
          Text.rich(TextSpan(
            children: [
              const WidgetSpan(
                child: Text('Detalles de la posición '),
              ),
              WidgetSpan(
                  child: Text(
                '${Utils().mapPosition[widget.pos]}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
          )),
          CardMember(member: _member),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("Seleccionar jugador"),
              ),
              SizedBox(
                width: 100.0,
                child: CustomDropDown(
                  key: UniqueKey(),
                  dropdownValue: _member.id.toString(),
                  list: _getMembers(),
                  change: _changePosition,
                  text: "",
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _member),
                child: const Text("Realizar cambio")),
          )
        ],
      ),
    );
  }

  Map<int, String> _getMembers() {
    Map<int, String> map = {
      -1: "Seleccione",
      for (var member in widget.members)
        member.id:
            '${member.name.substring(0, member.name.length > 10 ? 10 : member.name.length)}${member.name.length > 10 ? '...' : ''}'
    };

    return map;
  }

  _changePosition({required int pos}) {
    if (pos == -1) {
      _member = Utils().getMember(position: widget.pos);
    } else {
      final MemberModel newMember =
          widget.members.firstWhere((member) => member.id == pos);
      newMember.setPositionNew(pos: widget.pos);
      _member = newMember;
    }
    setState(() {});
  }
}
