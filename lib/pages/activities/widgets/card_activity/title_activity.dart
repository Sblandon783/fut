import 'package:flutter/material.dart';
import '../../utils/activities_const.dart';

class TitleActivity extends StatelessWidget {
  final String title;

  const TitleActivity({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final List<String> texts = title.split(" ");
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text.rich(
        TextSpan(
          style: ActivitiesConst.styleTitle,
          children: <InlineSpan>[
            TextSpan(text: '${texts.first} \n'),
            TextSpan(text: texts[1]),
          ],
        ),
      ),
    );
  }
}
