import 'package:flutter/material.dart';
import 'package:soccer/pages/activities/widgets/all_teams/all_teams.dart';
import 'package:soccer/pages/activities/widgets/card_activity/subtitle_activity.dart';
import 'package:soccer/pages/activities/widgets/new_challenges/new_challenges.dart';

import '../../utils/activities_const.dart';
import '../new_players/new_players.dart';
import 'icon_activity.dart';
import 'right_content_activity.dart';
import 'title_activity.dart';

class CardActivity extends StatelessWidget {
  final int id;
  final String title;
  final String subTitle;
  final IconData icon;
  final int count;
  final bool disabled;
  const CardActivity({
    super.key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.count,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () => disabled ? null : _onTap(context: context),
        child: Container(
          width: double.infinity,
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: disabled ? Colors.grey.shade400 : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconActivity(icon: icon, count: count),
                  TitleActivity(title: title),
                  SubTitleActivity(subtitle: subTitle),
                ],
              ),
              RightContentActivity(count: count)
            ],
          ),
        ),
      ),
    );
  }

  void _onTap({required BuildContext context}) {
    final Map<int, dynamic> mapView = {
      ActivitiesConst.idNewPlayers: NewPlayers(key: UniqueKey()),
      ActivitiesConst.idNewChallenges: NewChallenges(key: UniqueKey()),
      ActivitiesConst.idAvailableTeams: AllTeams(key: UniqueKey()),
    };
    final route = MaterialPageRoute(builder: (context) => mapView[id]);
    Navigator.push(context, route).then((value) {});
  }
}
