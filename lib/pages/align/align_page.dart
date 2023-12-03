import 'package:flutter/material.dart';
import 'package:soccer/pages/login/providers/provider_match.dart';
import 'package:soccer/pages/align/align_section.dart';

import '../login/models/field_model.dart';
import '../login/models/field_notifier.dart';
import '../login/models/match_model.dart';

class AlignPage extends StatefulWidget {
  const AlignPage({super.key});

  @override
  AlignPageState createState() => AlignPageState();
}

class AlignPageState extends State<AlignPage> {
  final _provider = ProviderMatch();

  final ValueNotifier<FieldNotifier> _typeAlignNotifier =
      ValueNotifier(FieldNotifier(idField: -1, idAlign: -1));

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  void _getMatch() async {
    await _provider.getFields();
    _provider.getMatch();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return _generateSecond();
  }

  Widget _generateSecond() => Center(
        child: StreamBuilder(
            stream: _provider.matchStream,
            builder:
                (BuildContext context, AsyncSnapshot<MatchModel> snapshot) {
              if (snapshot.hasData) {
                FieldModel fieldCurrent = _provider.fields.fields.firstWhere(
                    (field) => field.name == _provider.match!.name,
                    orElse: () => _provider.fields.fields.first);

                _typeAlignNotifier.value = FieldNotifier(
                    idField: fieldCurrent.id,
                    idAlign: _provider.match!.idAlign);

                return snapshot.data != null
                    ? Column(
                        children: [
                          _generateCard(
                            child: AlignSection(
                              key: UniqueKey(),
                              match: snapshot.data!,
                              typeAlignNotifier: _typeAlignNotifier,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );

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
