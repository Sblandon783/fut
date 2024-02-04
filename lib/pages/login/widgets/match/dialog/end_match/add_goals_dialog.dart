import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccer/pages/login/widgets/match/dialog/end_match/close_icon.dart';

class AddGoalsDialog extends StatelessWidget {
  final String name;
  final int goals;
  AddGoalsDialog({super.key, required this.name, required this.goals});

  final TextEditingController _goalsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (goals != 0) {
      _goalsController.text = goals.toString();
    }
    return SizedBox(
      width: 180.0,
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CloseIcon(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Jugador",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                ),
              ),
              Text(name),
            ],
          ),
          Container(
            width: 110.0,
            padding: const EdgeInsets.only(left: 10.0, top: 5),
            child: TextField(
              controller: _goalsController,
              decoration: const InputDecoration(labelText: "Goles"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              String goals =
                  _goalsController.text.isEmpty ? '0' : _goalsController.text;
              Navigator.pop(context, goals);
            },
            child: const Text("  Aceptar  "),
          )
        ],
      ),
    );
  }
}
