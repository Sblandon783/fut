import 'dart:math';

import 'package:flutter/material.dart';
import 'package:radar_chart/radar_chart.dart';

import '../../../models/atribbute_model.dart';

class AttributesDraw extends StatelessWidget {
  final AttributesModel attributes;
  final Color color;
  final int _length = 5;
  final List<double> values1 = [
    1,
    1,
    1,
    1,
    1,
  ];
  final List<Map<dynamic, dynamic>> _labelsList = [
    {"top": 0.0, "text": "Ata"},
    {"top": 40.0, "right": 0.0, "text": "Cre"},
    {"top": 40.0, "left": 0.0, "text": "Téc"},
    {"bottom": 0.0, "right": 20.0, "text": "Tact"},
    {"bottom": 0.0, "left": 20.0, "text": "Def"},
  ];

  AttributesDraw({
    super.key,
    required this.attributes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final List<double> values2 = [
      _convert(attributes.attack.total),
      _convert(attributes.technique.total),
      _convert(attributes.creative.total),
      _convert(attributes.tactic.total),
      _convert(attributes.defense.total),
    ];
    return Positioned(
      top: 10,
      child: SizedBox(
        width: 140,
        height: 125,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RadarChart(
              length: _length,
              radius: 50,
              initialAngle: pi / 3,
              backgroundColor: Colors.white,
              borderStroke: 1,
              borderColor: Colors.grey,
              radialStroke: 1,
              radialColor: Colors.grey,
              radars: [
                RadarTile(
                  values: values2,
                  borderStroke: 2,
                  borderColor: color,
                  backgroundColor: color.withOpacity(0.4),
                ),
              ],
            ),
            ..._labelsList.map((data) => _label(data: data)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _label({required Map<dynamic, dynamic> data}) => Positioned(
        top: data["top"],
        bottom: data["bottom"],
        left: data["left"],
        right: data["right"],
        child: Text(
          data["text"],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      );

  double _convert(int num) => num / 100;
}
