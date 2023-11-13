import 'package:flutter/material.dart';
import 'package:soccer/pages/home/models/match_model.dart';

class CustomCardPost extends StatefulWidget {
  final MatchModel match;
  final bool isComment;
  final Function deletePost;
  const CustomCardPost({
    super.key,
    required this.match,
    this.isComment = false,
    required this.deletePost,
  });

  @override
  CustomCardPostState createState() => CustomCardPostState();
}

class CustomCardPostState extends State<CustomCardPost> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _generateCard();

  Widget _generateCard() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _generateTeam(team: widget.match.teamNameOne, goals: 3),
                  _generateVS(),
                  _generateTeam(team: widget.match.teamNameTwo, goals: 2)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 30.0,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    widget.match.date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _generateTeam({required String team, required int goals}) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: 100.0,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sports_soccer),
                Text(team),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(goals.toString()),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _generateVS() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 25.0),
            Text("VS"),
            Text(
              "-",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      );

  /*
  widget.post.image.length < 200
                  ? Image.network(
                      widget.post.image,
                      height: 215.0,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )
                  : imageFromBase64String(widget.post.image),
                  */
}
