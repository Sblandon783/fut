import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String dropdownValue;
  final Map<int, String> list;
  final String text;
  final Function({required int pos}) change;
  final Color colorText;
  const CustomDropDown({
    Key? key,
    required this.dropdownValue,
    required this.change,
    required this.list,
    required this.text,
    this.colorText = Colors.blue,
  }) : super(key: key);

  @override
  CustomDropDownState createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.dropdownValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          if (widget.text.isNotEmpty)
            Text(
              widget.text,
              style: const TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          SizedBox(
            height: 60.0,
            child: DropdownButton<String>(
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: widget.colorText,
                ),
                elevation: 16,
                style: TextStyle(color: widget.colorText),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                  padding: EdgeInsets.zero,
                ),
                onChanged: (String? value) {
                  setState(() => dropdownValue = value!);
                  widget.change(pos: int.parse(value!));
                },
                items: _getListDropDown()),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getListDropDown() {
    List<DropdownMenuItem<String>> listDrop = [];
    widget.list.forEach((key, value) {
      listDrop.add(DropdownMenuItem<String>(
        value: key.toString(),
        child: Text(value),
      ));
    });
    return listDrop;
  }
}
