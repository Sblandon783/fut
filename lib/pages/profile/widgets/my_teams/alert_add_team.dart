import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlertAddTeam extends StatefulWidget {
  const AlertAddTeam({
    super.key,
  });

  @override
  AlertAddTeamState createState() => AlertAddTeamState();
}

class AlertAddTeamState extends State<AlertAddTeam> {
  final TextEditingController _idTeamController = TextEditingController();
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
      height: 180.0,
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
                controller: _idTeamController,
                decoration: const InputDecoration(labelText: "ID del equipo"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,3}'))
                ],
              ),
            ),
          ),
          _showLoaded
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (_idTeamController.text.isNotEmpty) {
                      setState(() => _showLoaded = !_showLoaded);
                      Navigator.pop(context, _idTeamController.value.text);
                    }
                  },
                  child: const Text("Enviar solicitud"),
                )
        ],
      ),
    );
  }
}
