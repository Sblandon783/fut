import 'package:flutter/material.dart';

class CardActivities extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CardActivities({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  static const TextStyle _styletTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 22.0,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _icon(),
                _title(),
                _subTitle(),
              ],
            ),
            _rightContent()
          ],
        ),
      ),
    );
  }

  Widget _title() {
    final List<String> texts = title.split(" ");

    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text.rich(
        TextSpan(
          style: _styletTitle,
          children: <InlineSpan>[
            TextSpan(text: '${texts.first} \n'),
            TextSpan(text: texts[1]),
          ],
        ),
      ),
    );
  }

  Widget _subTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 20.0),
      child: Text(
        subTitle,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 13.0,
        ),
      ),
    );
  }

  Widget _rightContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 28.0,
            color: Colors.grey,
          ),
        ),
        _count(),
      ],
    );
  }

  Widget _icon() {
    return Container(
      height: 55.0,
      width: 55.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(1.0),
            bottomLeft: Radius.circular(1.0),
            bottomRight: Radius.circular(50.0)),
        color: Colors.red.shade400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22.0,
        ),
      ),
    );
  }

  Widget _count() {
    return Container(
      height: 55.0,
      width: 55.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(1.0),
            bottomLeft: Radius.circular(1.0),
            bottomRight: Radius.circular(20.0)),
        color: Colors.red.shade400,
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Center(
          child: Text(
            "2",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
