import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../models/field_model.dart';

import '../../../models/match_model.dart';
import '../../../providers/provider_members.dart';
import '../../custom_drop_down.dart';

class MatchCardBottomContent extends StatefulWidget {
  final MatchModel match;
  final List<FieldModel> fields;
  final ProviderMembers providerMembers;
  final bool disabledOnTap;
  final bool createMatch;
  const MatchCardBottomContent({
    super.key,
    required this.match,
    required this.fields,
    required this.providerMembers,
    required this.disabledOnTap,
    required this.createMatch,
  });

  @override
  MatchCardBottomContentState createState() => MatchCardBottomContentState();
}

class MatchCardBottomContentState extends State<MatchCardBottomContent> {
  final List<DateTime?> _dates = [];
  bool _show = false;

  late MatchModel _match;
  @override
  void initState() {
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
        imageOneTeam: widget.match.imageOneTeam,
        imageSecondTeam: widget.match.imageSecondTeam);

    _setDate();
    super.initState();
  }

  _setDate() => _dates.add(DateTime(widget.match.parsedDate.year,
      widget.match.parsedDate.month, widget.match.parsedDate.day));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 120.0,
                child: _generateRow(
                  color: Colors.blue.shade300,
                  icon: Icons.calendar_month_rounded,
                  text: widget.match.date,
                  onTap: () => _onTap(content: _calenderContent()),
                ),
              ),
              Flexible(
                child: _generateRow(
                  color: Colors.blue,
                  icon: Icons.timer,
                  text: widget.match.hour,
                  onTap: () => _onTap(content: _hourContent()),
                ),
              ),
              _generateField(),
            ],
          ),
          if (_show && !widget.createMatch)
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      widget.providerMembers.saveMatch(match: widget.match);
                      setState(() => _show = false);
                    },
                    child: const Text("Guardar"))
              ],
            )
        ],
      ),
    );
  }

  Widget _generateRow({
    required IconData icon,
    required String text,
    required Color color,
    required Function() onTap,
  }) {
    final Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: 20.0,
          color: color,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13.0,
          ),
        ),
      ],
    );

    return widget.match.isFinished || widget.disabledOnTap
        ? child
        : GestureDetector(onTap: onTap, child: child);
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

  Map<int, String> _getHour() {
    FieldModel field = widget.fields
        .firstWhere((element) => widget.match.idField == element.id);
    Map<int, String> hours = {};
    for (var i = 0; i < field.hours.length; i++) {
      hours[i + 1] = field.hours[i].trim();
    }
    return hours;
  }

  Widget _generateField() {
    String name = widget.fields
        .firstWhere((field) => field.id == widget.match.idField)
        .name;

    Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 20.0,
          color: Colors.green.shade300,
        ),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade300,
            fontSize: 13.0,
          ),
        ),
      ],
    );
    return widget.match.isFinished || widget.disabledOnTap
        ? child
        : GestureDetector(
            onTap: () => _onTap(content: _fieldContent()),
            child: child,
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

  Widget _fieldContent() {
    Map<int, String> listFields = {
      for (var field in widget.fields) field.id: field.name
    };
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
              list: listFields,
              change: _onChangedField,
              text: "",
              colorText: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedField({required int pos}) {
    Map<int, String> listFields = {
      for (var field in widget.fields) field.id: field.name
    };

    _show = true;
    widget.match.name = listFields[pos]!;
    widget.match.idField = pos;

    widget.match.hour =
        widget.fields.firstWhere((field) => field.id == pos).hours.first.trim();
    widget.match.setDate(dates: [widget.match.parsedDate]);

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
