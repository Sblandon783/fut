import 'package:flutter/material.dart';

import '../models/member_model.dart';

class CardMember extends StatefulWidget {
  final MemberModel member;
  const CardMember({super.key, required this.member});

  @override
  CardMemberState createState() => CardMemberState();
}

class CardMemberState extends State<CardMember> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 100.0,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Stack(
              children: [
                const Positioned(
                  bottom: 0,
                  left: 10,
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: Image(
                      height: 120.0,
                      image: AssetImage('assets/silueta.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5.0),
                    color: Colors.blue,
                    width: 55.0,
                    child: Text(
                      widget.member.position,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5.0),
                    width: 55.0,
                    child: Text(
                      widget.member.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5.0),
                    width: 55.0,
                    child: Text(
                      widget.member.number.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
