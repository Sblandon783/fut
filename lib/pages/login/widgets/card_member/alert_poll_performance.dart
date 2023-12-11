import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlertPollPerformance extends StatefulWidget {
  final Function({required String value}) changePerformace;

  const AlertPollPerformance({
    super.key,
    required this.changePerformace,
  });

  @override
  AlertPollPerformanceState createState() => AlertPollPerformanceState();
}

class AlertPollPerformanceState extends State<AlertPollPerformance> {
  final TextEditingController _performanceController = TextEditingController();
  bool _showLoaded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 155.0,
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
              width: 120.0,
              padding: const EdgeInsets.only(top: 5, bottom: 5.0),
              child: TextField(
                controller: _performanceController,
                decoration: const InputDecoration(labelText: "Rendimiento"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
              ),
            ),
          ),
          _showLoaded
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    setState(() => _showLoaded = !_showLoaded);
                    widget.changePerformace(
                      value: _performanceController.text,
                    );
                  },
                  child: const Text("Puntuar"),
                )
        ],
      ),
    );
  }
}
