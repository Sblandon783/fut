import 'dart:async';

import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final Map<int, String> list;
  final StreamController typeController;
  final String title;
  final int selected;
  const CustomRadioButton({
    Key? key,
    required this.list,
    required this.typeController,
    required this.title,
    required this.selected,
  }) : super(key: key);

  @override
  CustomRadioButtonState createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  late int _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._createOptions(),
                ]),
          ),
        ),
      );

  List<Widget> _createOptions() {
    List<Widget> list = [];
    for (var option in widget.list.entries) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              widget.typeController.sink.add(option.key.toString());
              setState(() => _selected = option.key);
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              width: 150.0,
              child: Row(
                children: [
                  Icon(
                    _selected == option.key
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(option.value),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }
  /*
  List<Widget> _createOptionsAux() {
    List<Widget> list = [];
    for (var option in widget.list.entries) {
      list.add(
        ListTile(
          title: Text(option.value),
          leading: Radio<String>(
            value: option.key.toString(),
            groupValue: _selected,
            onChanged: (value) {
              widget.typeController.sink.add(value);
              setState(() => _selected = value!);
            },
          ),
        ),
      );
    }
    return list;
  }*/
}
