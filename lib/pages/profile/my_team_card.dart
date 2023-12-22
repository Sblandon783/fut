import 'package:flutter/material.dart';
import 'package:soccer/pages/profile/models/team_model.dart';
import 'package:soccer/pages/profile/widgets/team/team_view.dart';

class MyTeamCard extends StatelessWidget {
  final TeamModel team;

  const MyTeamCard({super.key, required this.team});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context: context),
      child: SizedBox(
        width: 120.0,
        height: 120.0,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                _teamImage(),
                Text(team.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _teamImage() {
    return SizedBox(
      height: 70.0,
      width: 70.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300.0),
        child: team.image.isEmpty
            ? const Image(
                height: double.infinity,
                image: AssetImage('assets/question_mark.jpeg'),
              )
            : Image.network(height: double.infinity, team.image),
      ),
    );
  }

  void _onTap({required BuildContext context}) {
    final route = MaterialPageRoute(
      builder: (context) => TeamView(
        key: UniqueKey(),
        id: team.id,
      ),
    );
    Navigator.push(context, route).then((value) {});
  }
}
