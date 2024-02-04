import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:soccer/pages/login/utils/utils.dart';

import 'package:soccer/pages/login/widgets/card_member/center_content.dart';
import 'package:soccer/pages/login/widgets/card_member/footer_content.dart';
import 'package:soccer/pages/login/widgets/card_member/mvp_content.dart';
import 'package:soccer/user_preferences.dart';

import '../../models/member_model.dart';
import 'alert_poll_performance.dart';
import 'animated_bounce.dart';
import 'attribute/attributes_draw.dart';
import 'background.dart';
import 'footer_atribbute_content.dart';

import 'performance_by_match.dart';
import 'top_content.dart';

class CardMember extends StatefulWidget {
  final int idMatch;
  final MemberModel member;
  final double width;
  final double height;
  final bool isSpecial;
  final bool isSmall;
  final bool isFlip;
  final bool reverse;
  final Future<bool> Function({
    required int idMember,
    required int idMatch,
    required Map<dynamic, dynamic> performance,
  }) updatePerformance;

  final Map<dynamic, dynamic> performance;
  const CardMember({
    super.key,
    this.idMatch = -1,
    required this.member,
    this.width = 150.0,
    this.height = 270.0,
    this.isSpecial = false,
    this.isSmall = false,
    this.isFlip = true,
    this.reverse = false,
    this.performance = const {},
    required this.updatePerformance,
  });

  @override
  CardMemberState createState() => CardMemberState();
}

class CardMemberState extends State<CardMember> {
  final UserPreferences _prefs = UserPreferences();
  final Utils _utils = Utils();
  final Map<int, Color> _statusColor = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.red,
  };
  final Map<int, IconData> _statusIcon = {
    1: Icons.local_fire_department_outlined,
    2: Icons.sensor_occupied_rounded,
    3: Icons.arrow_downward_outlined,
  };
  double _performance = 0.0;
  late Color _color;
  @override
  void initState() {
    _getPerformance();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _color = _utils.mapPosSevenColors[widget.member.idPosition];
    return widget.isSpecial ? AnimatedBounce(child: _content()) : _content();
  }

  Widget _content() {
    Widget frontCard = _genarateCard(child: _frontCard());
    return widget.isSmall
        ? frontCard
        : widget.isFlip
            ? FlipCard(
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                front: frontCard,
                back: _genarateCard(child: _backCard()),
              )
            : widget.reverse
                ? _genarateCard(child: _backCard())
                : frontCard;
  }

  Widget _genarateCard({required Widget child}) {
    return SizedBox(
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: widget.isSpecial ? 8 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: widget.isSpecial
                ? BorderSide(color: _color, width: 3.0)
                : BorderSide.none,
          ),
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _color,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _frontCard() {
    return Stack(
      children: [
        Background(width: widget.width, height: widget.height),
        TopContent(
          idPosition: widget.member.idPosition,
          width: widget.width,
          height: widget.isSmall ? 60.0 : widget.height - 150.0,
          utils: _utils,
        ),
        Positioned(
          top: 7.0,
          right: 1.0,
          child: Container(
            color: const Color.fromARGB(145, 0, 0, 0),
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            width: 50.0,
            child: Icon(
              _statusIcon[widget.member.status],
              color: _statusColor[widget.member.status],
              size: 15.0,
            ),
          ),
        ),
        if (widget.member.goals != 0)
          Positioned(
            top: 30.0,
            right: 1.0,
            child: Container(
                color: const Color.fromARGB(145, 0, 0, 0),
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                width: 45.0,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.sports_soccer, color: Colors.white),
                    Text(
                      widget.member.goals.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )),
          ),
        if (widget.member.isMPV) MVPContent(width: widget.width),
        CenterContent(name: widget.member.name, width: widget.width),
        FooterContent(
          member: widget.member,
          width: widget.width,
          bottom: widget.performance.isNotEmpty ? 30.0 : 10.0,
        ),
        if (widget.performance.isNotEmpty)
          PerformanceByMatch(
            performance: _performance,
            width: widget.width,
            onTap: _onTap,
          )
      ],
    );
  }

  Widget _backCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AttributesDraw(attributes: widget.member.attributes, color: _color),
        Background(width: widget.width, height: widget.height),
        CenterContent(name: widget.member.name, width: widget.width),
        FooterAtribbuteContent(
          attributes: widget.member.attributes,
          width: widget.width,
        ),
      ],
    );
  }

  _onTap() {
    if (_prefs.userId == widget.member.id) {
      return;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: AlertPollPerformance(changePerformace: _changePerformance),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {});
  }

  _changePerformance({required String value}) async {
    double performance = value.isEmpty ? 5.0 : double.parse(value);

    widget.performance[_prefs.userId.toString()] = performance;

    if (widget.performance[-1] != null) {
      widget.performance.remove(-1);
    }
    bool response = await widget.updatePerformance(
        idMember: widget.member.id,
        performance: widget.performance,
        idMatch: widget.idMatch);
    if (response) {
      _getPerformance();
      setState(() {});
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  _getPerformance() {
    _performance = 0.0;
    if (widget.performance.isEmpty) {
      return 5.0;
    }

    widget.performance
        .forEach((key, value) => _performance = _performance + value);
    _performance = (_performance / widget.performance.length);
    _performance = double.parse(_performance.toStringAsFixed(2));
  }
}
