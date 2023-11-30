import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import "dart:math" show pi;

import '../../../../login/models/atribbute_model.dart';
import '../../../../login/utils/utils.dart';

class DonutAttribute extends StatefulWidget {
  final AttributeModel attribute;
  final Function() update;
  const DonutAttribute(
      {Key? key, required this.attribute, required this.update})
      : super(key: key);

  @override
  DonutAttributeState createState() => DonutAttributeState();
}

class DonutAttributeState extends State<DonutAttribute> {
  final double _size = 60.0;
  final TextEditingController _totalController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils().getColorAttributes(total: widget.attribute.total);
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              widget.attribute.name,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
          ),
          CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: widget.attribute.total,
            stepSize: 10,
            selectedColor: color,
            unselectedColor: Colors.grey.shade300,
            padding: 0,
            width: _size,
            height: _size,
            arcSize: pi,
            circularDirection: CircularDirection.clockwise,
            selectedStepSize: 11,
            roundedCap: (_, __) => true,
            startingAngle: pi / 2,
            child: Center(
                child: Text(
              widget.attribute.total.toString(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 17.0,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: _content(),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {});
  }

  SizedBox _content() {
    _totalController.text = widget.attribute.total.toString();
    return SizedBox(
      width: 90.0,
      height: 160.0,
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
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: 80.0,
                    child: TextField(
                      controller: _totalController,
                      decoration: const InputDecoration(labelText: "Número"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      const SizedBox(width: 30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: _save,
                          child: const Text("Guardar"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (int.parse(_totalController.text) > 100) {
      _totalController.text = '100';
    }
    setState(() => widget.attribute.total = int.parse(_totalController.text));
    widget.update();
    Navigator.pop(context);
  }
}
