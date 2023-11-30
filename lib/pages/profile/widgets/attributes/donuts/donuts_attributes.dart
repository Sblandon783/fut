import 'package:flutter/material.dart';

import 'package:soccer/pages/profile/widgets/attributes/donuts/donut_attribute.dart';

import '../../../../login/models/atribbute_model.dart';

class DonutsAttributes extends StatelessWidget {
  final AttributesModel attributes;
  final Function() update;

  const DonutsAttributes(
      {super.key, required this.attributes, required this.update});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DonutAttribute(attribute: attributes.attack, update: update),
              DonutAttribute(attribute: attributes.technique, update: update),
              DonutAttribute(attribute: attributes.creative, update: update),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DonutAttribute(attribute: attributes.defense, update: update),
              DonutAttribute(attribute: attributes.tactic, update: update),
            ],
          ),
        ],
      ),
    );
  }
}
