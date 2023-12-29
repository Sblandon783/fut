import 'package:flutter/material.dart';

class AlertMyStatus extends StatefulWidget {
  final int status;
  const AlertMyStatus({super.key, required this.status});

  @override
  AlertMyStatusState createState() => AlertMyStatusState();
}

class AlertMyStatusState extends State<AlertMyStatus> {
  final TextEditingController _idTeamController = TextEditingController();
  final Map<int, String> _mapText = {
    1: "Ya eres parte del equipo",
    2: "Envíar solicitud"
  };
  final Map<int, String> _mapButton = {
    1: "Salir del equipo",
    2: "Envíar solicitud"
  };
  final Map<int, Color> _mapColor = {
    1: Colors.red,
    2: Colors.green,
  };
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
      height: widget.status == 1 ? 160.0 : 180.0,
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
          if (widget.status == 1) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5.0),
                child: Text(_mapText[widget.status]!),
              ),
            ),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 45.0,
            ),
          ],
          _showLoaded
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, widget.status);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _mapColor[widget.status],
                  ),
                  child: Text(_mapButton[widget.status]!),
                )
        ],
      ),
    );
  }
}
