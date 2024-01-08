import 'package:flutter/material.dart';

import '../../models/team_model.dart';

class TeamTop extends StatefulWidget {
  final TeamModel team;
  const TeamTop({Key? key, required this.team}) : super(key: key);

  @override
  TeamTopState createState() => TeamTopState();
}

class TeamTopState extends State<TeamTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _generateContent();

  Widget _generateContent() {
    const BorderRadius radius = BorderRadius.only(
      bottomLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 215.0,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //const Background(),

            Container(
              width: double.maxFinite,
              height: 145.0,
              decoration: const BoxDecoration(
                borderRadius: radius,
                color: Colors.white,
              ),
              child: _generateCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateCard() {
    return SizedBox(
      width: 205.0,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: SizedBox(
                height: 90.0,
                width: 90.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: widget.team.image.isEmpty
                      ? const Image(
                          height: double.infinity,
                          image: AssetImage('assets/question_mark.jpeg'),
                        )
                      : Image.network(
                          height: double.infinity, widget.team.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                widget.team.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
              '#${widget.team.id}',
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
