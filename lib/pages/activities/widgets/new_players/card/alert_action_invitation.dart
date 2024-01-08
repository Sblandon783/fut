import 'package:flutter/material.dart';

class AlertActionInvitation extends StatefulWidget {
  const AlertActionInvitation({
    super.key,
  });

  @override
  AlertActionInvitationState createState() => AlertActionInvitationState();
}

class AlertActionInvitationState extends State<AlertActionInvitation> {
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
      height: 130.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "El jugador quiere ser parte de tu equipo",
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(100.0, 35.0),
                  ),
                  child: const Text("Aceptar"),
                ),
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(100.0, 35.0),
                  ),
                  child: const Text("Denegar"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
