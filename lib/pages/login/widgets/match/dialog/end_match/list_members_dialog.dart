import 'package:flutter/material.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/close_icon.dart';

import '../../../../models/member_model.dart';
import 'add_goals_dialog.dart';

class ListeMembersDialog extends StatefulWidget {
  final List<MemberModel> members;
  const ListeMembersDialog({super.key, required this.members});

  @override
  ListeMembersDialogState createState() => ListeMembersDialogState();
}

class ListeMembersDialogState extends State<ListeMembersDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CloseIcon(),
          Flexible(
            child: ListView.builder(
              itemCount: widget.members.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final MemberModel member = widget.members[index];
                return Center(
                  child: GestureDetector(
                    onTap: () => _addPlayerOtherTeam(member: member),
                    child: Container(
                      width: 200.0,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      color: index % 2 == 0
                          ? Colors.grey.shade300
                          : Colors.grey.shade100,
                      child: Text(member.name),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _addPlayerOtherTeam({required MemberModel member}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: AddGoalsDialog(name: member.name, goals: 0),
        ),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic goals) {
      if (goals != null) {
        member.goals = int.parse(goals);
        MemberModel newMember = MemberModel.fromJson(member.json());
        Navigator.pop(context, newMember);
      }
    });
  }
}
