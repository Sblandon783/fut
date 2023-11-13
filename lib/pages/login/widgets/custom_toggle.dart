import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final Function({required int tabIndex}) changeIndex;
  final int tabIndex;
  const CustomToggle({
    super.key,
    required this.changeIndex,
    required this.tabIndex,
  });

  @override
  CustomToggleState createState() => CustomToggleState();
}

class CustomToggleState extends State<CustomToggle> {
  @override
  void initState() {
    super.initState();
  }

  Map<int, String> get _listTextTabToggle => {0: "Jugadores", 1: "Alineación"};
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(children: _tabs()));
  List<Widget> _tabs() {
    List<Widget> listWidgets = [];
    _listTextTabToggle
        .forEach((key, value) => listWidgets.add(_tab(key: key, text: value)));

    return listWidgets;
  }

  Widget _tab({required int key, required String text}) {
    bool selected = widget.tabIndex == key;
    return Flexible(
      child: GestureDetector(
        onTap: () =>
            key != widget.tabIndex ? widget.changeIndex(tabIndex: key) : null,
        child: Container(
          height: selected ? 50.0 : 47.0,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            color: selected ? Colors.blue : Colors.grey.shade300,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey.shade700,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
