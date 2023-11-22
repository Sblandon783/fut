import 'package:flutter/material.dart';

import '../../custom_drop_down.dart';

class AlignType extends StatefulWidget {
  final int type;
  const AlignType({super.key, required this.type});

  @override
  AlignTypeState createState() => AlignTypeState();
}

class AlignTypeState extends State<AlignType> {
  final double _heightImage = 200.0;
  @override
  void initState() {
    super.initState();
  }

  Map<int, String> map = {1: "as", 2: "hola"};
  String dropdownValue = "1";

  @override
  Widget build(BuildContext context) => _generateAligns();

  Widget _generateAligns() {
    return Positioned(
      top: _heightImage + 5.0,
      right: 10.0,
      child: GestureDetector(
        onTap: () {}, //() => _onTap(content: _fieldContent()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note,
              size: 20.0,
              color: Colors.grey.shade400,
            ),
            Text(
              _getAlignType(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getAlignType() {
    print(widget.type);
    return widget.type == 1 ? "2-1-2-1" : "2-2-2-1";
  }

  Map<int, String> _listFields = {1: "2-1-2-1", 2: "1-2-2-1", 3: "1-1-3-1"};

  Widget _fieldContent() {
    String dropdownValue = '1';

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
              text: "Alineaciones",
              colorText: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedField({required int pos}) {}

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
}
