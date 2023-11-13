import 'package:flutter/material.dart';

const Map<int, String> list = {
  1: 'POR',
  2: 'LTD',
  3: 'LTI',
  4: 'DFC',
  5: 'MD',
  6: 'MC',
  7: 'DC'
};

class CustomDropDown extends StatefulWidget {
  final Function({required int pos}) change;
  const CustomDropDown({Key? key, required this.change}) : super(key: key);

  @override
  CustomDropDownState createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  String dropdownValue = list.keys.first.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const Text(
            "Posición",
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          SizedBox(
            height: 60.0,
            child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
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
    list.forEach((key, value) {
      listDrop.add(DropdownMenuItem<String>(
        value: key.toString(),
        child: Text(value),
      ));
    });
    return listDrop;
  }
}
