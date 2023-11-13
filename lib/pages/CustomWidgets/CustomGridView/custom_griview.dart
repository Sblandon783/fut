import 'package:flutter/material.dart';

import '../../routines/models/matches_model.dart';
import '../../routines/widgets/custom_card_teams.dart';

class CustomGridview extends StatefulWidget {
  final List<MatchModel> posts;
  final ScrollController controller;
  final Function deletePost;
  const CustomGridview({
    super.key,
    required this.posts,
    required this.controller,
    required this.deletePost,
  });

  @override
  CustomGridviewState createState() => CustomGridviewState();
}

class CustomGridviewState extends State<CustomGridview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 214, 214, 214),
      child: CustomScrollView(
        controller: widget.controller,
        primary: false,
        slivers: <Widget>[
          SliverGrid.count(
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 1,
            children: widget.posts
                .map(
                  (MatchModel match) => CustomCardTeams(
                      match:
                          match), /*CustomCardPost(
                        match: match,
                        deletePost: widget.deletePost,
                      )*/
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
