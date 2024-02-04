import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/field_model.dart';
import 'package:soccer/pages/login/widgets/match/match_mvp.dart';
import 'package:soccer/user_preferences.dart';

import '../../models/field_notifier.dart';
import '../../models/match_model.dart';
import '../../providers/provider_members.dart';
import '../custom_drop_down.dart';

class MatchInfo extends StatefulWidget {
  final MatchModel match;
  final ValueNotifier<FieldNotifier> typeAlignNotifier;
  final List<FieldModel> fields;

  final ProviderMembers providerMembers;

  const MatchInfo({
    super.key,
    required this.match,
    required this.typeAlignNotifier,
    required this.fields,
    required this.providerMembers,
  });

  @override
  MatchInfonState createState() => MatchInfonState();
}

class MatchInfonState extends State<MatchInfo> {
  late Map<int, String> _listFields = {};
  final List<DateTime?> _dates = [];
  final UserPreferences _prefs = UserPreferences();

  late MatchModel _match;
  bool _show = false;
  @override
  void initState() {
    _listFields = {for (var field in widget.fields) field.id: field.name};
    _match = MatchModel(
        id: widget.match.id,
        idField: widget.match.idField,
        idAlign: widget.match.idAlign,
        date: widget.match.date,
        hour: widget.match.hour,
        name: widget.match.name,
        parsedDate: widget.match.parsedDate,
        assistants: widget.match.assistants,
        substitutes: widget.match.substitutes,
        idMPV: widget.match.idMPV,
        mapMVP: widget.match.mapMVP,
        teamOneGoals: widget.match.teamOneGoals,
        teamSecondGoals: widget.match.teamSecondGoals,
        listPerformance: widget.match.listPerformance,
        idOneTeam: widget.match.idOneTeam,
        imageOneTeam: widget.match.imageOneTeam,
        idSecondTeam: widget.match.idSecondTeam,
        imageSecondTeam: widget.match.imageSecondTeam);

    _setDate();
    super.initState();
  }

  _setDate() => _dates.add(DateTime(widget.match.parsedDate.year,
      widget.match.parsedDate.month, widget.match.parsedDate.day));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.1, 0.7, 0.8, 0.9],
              colors: widget.match.isFinished
                  ? [
                      Colors.red,
                      const Color.fromARGB(255, 73, 149, 211),
                      const Color.fromARGB(255, 32, 129, 209),
                      const Color.fromARGB(255, 32, 129, 209),
                    ]
                  : [
                      Colors.purple,
                      const Color.fromARGB(255, 32, 129, 209),
                      const Color.fromARGB(255, 32, 129, 209),
                      const Color.fromARGB(255, 32, 129, 209),
                    ]),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _generateRow(
                      icon: Icons.calendar_month_rounded,
                      text: widget.match.date,
                      onTap: () => _onTap(content: _calenderContent()),
                    ),
                    _generateRow(
                      icon: Icons.timer,
                      text: widget.match.hour,
                      onTap: () => _onTap(content: _hourContent()),
                    ),
                  ],
                ),
                Column(
                  children: [
                    if (widget.match.isFinished)
                      MatchMVP(
                        providerMembers: widget.providerMembers,
                        match: _match,
                      ),
                    if (_prefs.userId == 23 && !widget.match.isFinished)
                      ElevatedButton(
                          onPressed: () {
                            widget.providerMembers.endMatch(
                                isFinished: widget.match.isFinished,
                                idMatch: widget.match.id);
                            setState(() {
                              widget.match.isFinished =
                                  !widget.match.isFinished;
                            });
                          },
                          child: const Text("Iniciar partido")),
                  ],
                ),
                _generateField(),
              ],
            ),
            if (_show)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        widget.match.name = _match.name;
                        widget.match.hour = _match.hour;
                        widget.match.date = _match.date;
                        widget.match.parsedDate = _match.parsedDate;
                        setState(() => _show = false);
                      },
                      child: const Text("Cancelar")),
                  const SizedBox(width: 30.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        widget.providerMembers.saveMatch(match: widget.match);
                        setState(() => _show = false);
                      },
                      child: const Text("Guardar"))
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _generateRow({
    required IconData icon,
    required String text,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 20.0,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateField() {
    String name = widget.fields
        .firstWhere((field) => field.id == widget.match.idField)
        .name;

    return GestureDetector(
      onTap: () => _onTap(content: _fieldContent()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20.0,
            color: Colors.white,
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldContent() {
    String dropdownValue = widget.fields
        .firstWhere((field) => field.id == widget.match.idField)
        .id
        .toString();

    return SizedBox(
      width: 90.0,
      height: 120.0,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomDropDown(
              key: UniqueKey(),
              dropdownValue: dropdownValue,
              list: _listFields,
              change: _onChangedField,
              text: "",
              colorText: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _calenderContent() {
    return SizedBox(
      width: 300.0,
      height: 400.0,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              )),
          CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
              ),
              value: _dates,
              onValueChanged: (dates) {
                _show = true;
                widget.match.setDate(dates: dates);

                _dates.clear();
                _setDate();
                setState(() {});
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Map<int, String> _getHour() {
    FieldModel field = widget.fields
        .firstWhere((element) => widget.match.idField == element.id);
    Map<int, String> hours = {};
    for (var i = 0; i < field.hours.length; i++) {
      hours[i + 1] = field.hours[i].trim();
    }
    return hours;
  }

  Widget _hourContent() {
    Map<int, String> map = _getHour();
    String dropdownValue = map.keys
        .firstWhere((k) => map[k] == widget.match.hour.trim(),
            orElse: () => map.keys.first)
        .toString();

    return SizedBox(
      width: 90.0,
      height: 120.0,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomDropDown(
              key: UniqueKey(),
              dropdownValue: dropdownValue,
              list: map,
              change: _onChangedHour,
              text: "",
              colorText: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap({required Widget content}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: content,
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {});
  }

  void _onChangedField({required int pos}) {
    _show = true;
    widget.match.name = _listFields[pos]!;
    widget.match.idField = pos;

    widget.match.hour =
        widget.fields.firstWhere((field) => field.id == pos).hours.first.trim();
    widget.match.setDate(dates: [widget.match.parsedDate]);
    widget.typeAlignNotifier.value = FieldNotifier(
        idField: pos, idAlign: widget.typeAlignNotifier.value.idAlign);
    setState(() {});
    Navigator.pop(context, widget.match);
  }

  void _onChangedHour({required int pos}) {
    _show = true;
    Map<int, String> map = _getHour();
    widget.match.hour = map[pos]!;
    widget.match.setDate(dates: [widget.match.parsedDate]);
    setState(() {});
    Navigator.pop(context, widget.match);
  }
}
