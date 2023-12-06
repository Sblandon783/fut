import 'package:flutter/material.dart';
import 'package:soccer/pages/align/align_section.dart';

import '../login/models/field_model.dart';
import '../login/models/field_notifier.dart';
import '../login/models/match_model.dart';

class AlignPage extends StatefulWidget {
  final MatchModel match;
  final List<FieldModel> fields;
  const AlignPage({
    super.key,
    required this.match,
    required this.fields,
  });

  @override
  AlignPageState createState() => AlignPageState();
}

class AlignPageState extends State<AlignPage> {
  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  @override
  void initState() {
    _typeAlignNotifier.value = FieldNotifier(
        idField: widget.match.idField, idAlign: widget.match.idAlign);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _generateCard(
            child: AlignSection(
              key: UniqueKey(),
              match: widget.match,
              typeAlignNotifier: _typeAlignNotifier,
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateCard({required Widget child}) {
    return Container(
      width: 330.0,
      height: 420.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding:
          const EdgeInsets.only(top: 10, left: 10, right: 10.0, bottom: 20.0),
      child: child,
    );
  }
}
