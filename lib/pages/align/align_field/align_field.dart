import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/field_notifier.dart';
import 'package:soccer/pages/align/align_field/align_type.dart';
import 'package:soccer/pages/align/check_button.dart';

import '../../login/models/match_model.dart';
import '../../login/models/member_model.dart';
import '../../login/utils/utils.dart';
import '../../login/providers/provider_members.dart';
import '../../login/widgets/burbble/burbble.dart';

import '../field_background.dart';

class AlignField extends StatefulWidget {
  final List<MemberModel> members;
  final MatchModel match;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
  final ProviderMembers provider;
  const AlignField({
    super.key,
    required this.members,
    required this.match,
    required this.typeAlignNotifier,
    required this.provider,
  });

  @override
  AlignFieldState createState() => AlignFieldState();
}

class AlignFieldState extends State<AlignField> {
  final Utils _utils = Utils();
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 230.0,
        child: ValueListenableBuilder(
            valueListenable: widget.typeAlignNotifier,
            builder: (context, type, child) {
              return Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  const FieldBackground(),
                  CheckButton(
                    notifier: _buttonNotifier,
                    onTap: () => _saveAlign(type: type),
                  ),
                  ..._generateBurbbles(
                      idField: type.idField, idAlign: type.idAlign),
                  AlignType(
                    idField: type.idField,
                    type: type.idAlign,
                    updateAlign: _updateAlign,
                    onTap: () => _saveAlign(type: type),
                  ),
                ],
              );
            }),
      );

  List<Widget> _generateBurbbles({required int idField, required int idAlign}) {
    List<Widget> childrens = [];
    for (var i = 0; i < widget.members.length; i++) {
      widget.members[i].added = false;
    }

    Map<int, Map<String, double>> map =
        _utils.getAlign(idField: idField, idAlign: idAlign);

    map.forEach((key, value) {
      MemberModel currentMember =
          _findMember(members: widget.members, position: key);
      childrens.add(Burbble(
        idPos: key,
        pos: value,
        members: widget.members,
        member: currentMember,
        updateMembers: _updateMembers,
      ));
    });

    return childrens;
  }

  _updateAlign({required int id}) {
    FieldNotifier type = FieldNotifier(
        idField: widget.typeAlignNotifier.value.idField, idAlign: id);
    widget.typeAlignNotifier.value = type;
  }

  _updateMembers(
      {required MemberModel member, required MemberModel oldMember}) {
    _buttonNotifier.value = true;
    widget.provider.updateMember(newMember: member, oldMember: oldMember);
    widget.match.assistants = widget.provider.match!.assistants;
    widget.match.substitutes = widget.provider.match!.substitutes;
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

  Future<void> _saveAlign({required FieldNotifier type}) async {
    bool response = await widget.provider.saveAlign(
        members: widget.members, idField: type.idField, idAlign: type.idAlign);
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
    widget.match.assistants = widget.provider.match!.assistants;
    widget.match.substitutes = widget.provider.match!.substitutes;
    _buttonNotifier.value = false;
  }
}
