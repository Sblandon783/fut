import 'package:flutter/material.dart';
import 'package:soccer/pages/login/utils/utils.dart';

import '../../login/widgets/custom_drop_down.dart';

class AlignType extends StatefulWidget {
  final int type;
  final Function({required int id}) updateAlign;
  final Function() onTap;
  const AlignType({
    super.key,
    required this.type,
    required this.updateAlign,
    required this.onTap,
  });

  @override
  AlignTypeState createState() => AlignTypeState();
}

class AlignTypeState extends State<AlignType> {
  final Utils _utils = Utils();
  final double _heightImage = 200.0;
  String dropdownValue = "1";
  bool _show = false;
  @override
  void initState() {
    dropdownValue = widget.type.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _generateAligns();

  Widget _generateAligns() {
    return Positioned(
      top: _heightImage + 5.0,
      right: 10.0,
      child: GestureDetector(
        onTap: () => _onTap(content: _fieldContent()),
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
            if (_show)
              GestureDetector(
                onTap: () {
                  widget.onTap();
                  setState(() => _show = false);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 25.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getAlignType() =>
      _utils.getNameAlign()[int.parse(dropdownValue)] ?? '';

  Widget _fieldContent() {
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomDropDown(
              key: UniqueKey(),
              dropdownValue: dropdownValue,
              list: _utils.getNameAlign(),
              change: _onChangedField,
              text: "Alineaciones",
              colorText: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedField({required int pos}) {
    widget.updateAlign(id: pos);
    dropdownValue = pos.toString();
    _show = true;
    Navigator.pop(context);
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
}
