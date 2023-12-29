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

  Widget _generateData() {
    BoxDecoration decoration = const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10.0),
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: 55.0,
        decoration: decoration,
        child: Row(
          children: [
            _icon(
              icon: Icons.thumb_up_alt_rounded,
              text: widget.team.winner.toString(),
            ),
            _icon(
              icon: Icons.thumb_down_alt_rounded,
              text: widget.team.loose.toString(),
            ),
            _icon(
              icon: Icons.sports_soccer_rounded,
              text: widget.team.equals.toString(),
            ),
            _icon(
              icon: Icons.person,
              text: widget.team.totalMembers.toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget _icon({required IconData icon, required String text}) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
