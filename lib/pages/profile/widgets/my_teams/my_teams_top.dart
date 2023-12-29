import 'package:flutter/material.dart';

import 'alert_add_team.dart';

class MyTeamsTop extends StatelessWidget {
  final Function({required int idTeam}) onTap;
  const MyTeamsTop({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Mis equipos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          GestureDetector(
              onTap: () => _onTap(context: context),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 27.0,
              )),
        ],
      ),
    );
  }

  _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: AlertAddTeam(),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {
      if (value != null) {
        onTap(idTeam: int.parse(value));
      }
    });
  }
}
