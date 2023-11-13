import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final Function(int) onTap;
  const CustomToggleButton({Key? key, required this.onTap}) : super(key: key);

  @override
  CustomToggleButtonState createState() => CustomToggleButtonState();
}

class CustomToggleButtonState extends State<CustomToggleButton> {
  int selectedItem = 1;
  final int _pastMatch = 1;
  final int _nextMatch = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _generateButton(text: "Partidos Jugados", select: _pastMatch),
            _generateButton(text: "Próximos Partidos", select: _nextMatch),
          ],
        ),
      ),
    );
  }

  Widget _generateButton({required String text, required int select}) =>
      Flexible(
        child: GestureDetector(
          onTap: (() {
            widget.onTap(select);
            setState(() => selectedItem = select);
          }),
          child: Card(
            elevation: selectedItem == select ? 4 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedItem == select
                    ? Colors.blue.shade600
                    : Colors.blue.shade400,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: selectedItem == select
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
}
