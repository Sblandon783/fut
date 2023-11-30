import 'package:flutter/material.dart';
import 'package:soccer/pages/login/utils/utils.dart';

import '../../models/atribbute_model.dart';

class FooterAtribbuteContent extends StatelessWidget {
  final AttributesModel attributes;
  final double width;

  const FooterAtribbuteContent({
    super.key,
    required this.width,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final Container divider = Container(
      color: Colors.grey.shade300,
      width: 0.5,
      height: 50.0,
    );
    return Positioned(
      bottom: 10.0,
      left: 0.0,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _generateColumn(
              attr1: attributes.attack,
              attr2: attributes.technique,
            ),
            divider,
            _generateColumn(
              attr1: attributes.creative,
            ),
            divider,
            _generateColumn(
              attr1: attributes.tactic,
              attr2: attributes.defense,
            ),
          ],
        ),
      ),
    );
  }

  Column _generateColumn({
    required AttributeModel attr1,
    AttributeModel? attr2,
  }) {
    return Column(
      children: [
        _generateAttribute(title: attr1.name, total: attr1.total),
        if (attr2 != null) ...[
          const SizedBox(height: 5.0),
          _generateAttribute(title: attr2.name, total: attr2.total)
        ]
      ],
    );
  }

  Column _generateAttribute({required String title, required int total}) {
    return Column(
      children: [
        Text(
          total.toString(),
          style: TextStyle(
            color: Utils().getColorAttributes(total: total),
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}
