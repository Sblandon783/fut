import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../routines/widgets/views/my_routines_view.dart';
import '../models/members_model.dart';

class MemberCardPayment extends StatelessWidget {
  final MemberModel member;
  const MemberCardPayment({super.key, required this.member});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _routines(context),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 220.0,
            width: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _generateTop(),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                    child: Text(
                      (member.name.length > 15
                              ? '${member.name.substring(0, 15)}...'
                              : member.name)
                          .toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
                _generateRow(
                  icon: Icons.payment_rounded,
                  text: 'Último pago ',
                  subText: '2023-04-19',
                ),
                _generateRow(
                  icon: Icons.calendar_month_rounded,
                  text: 'Siguiente pago ',
                  subText: '2023-04-19',
                ),
              ],
            ),
          ),
        ),
      );

  Widget _generateTop() => SizedBox(
        height: 110.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 80.0,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.5, 0.9],
                  colors: _generateColor(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                ),
                width: 90.0,
                height: 90.0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: member.image.contains('https')
                      ? NetworkImage(member.image)
                      : imageFromBase64String(),
                ),
              ),
            ),
          ],
        ),
      );

  void _routines(BuildContext context) {
    final route = MaterialPageRoute(
        builder: (context) => MyRoutinesView(userId: member.id));
    Navigator.push(context, route);
  }

  List<Color> _generateColor() {
    return [
      const Color.fromARGB(255, 29, 166, 157),
      const Color.fromARGB(255, 29, 166, 157),
      Colors.green.shade300,
    ];
  }

  Widget _generateRow({
    required IconData icon,
    required String text,
    required String subText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Icon(
                  icon,
                  size: 16.0,
                  color: Colors.grey,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19.0),
            child: Text(subText,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  imageFromBase64String() {
    Uint8List profile = base64.decode(member.image);
    return MemoryImage(profile);
  }

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  String base64String(Uint8List data) => base64Encode(data);
}
