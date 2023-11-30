import 'package:flutter/material.dart';
import 'package:soccer/pages/login/models/atribbute_model.dart';
import 'package:soccer/pages/login/utils/utils.dart';
import 'package:soccer/pages/profile/providers/provider_profile.dart';

import '../../../login/models/member_model.dart';
import '../../../login/widgets/card_member/attribute/attributes_draw.dart';

import 'donuts/donuts_attributes.dart';
import 'title_attribute.dart';

class ProfileAttributes extends StatefulWidget {
  final MemberModel member;
  const ProfileAttributes({Key? key, required this.member}) : super(key: key);

  @override
  ProfileAttributesState createState() => ProfileAttributesState();
}

class ProfileAttributesState extends State<ProfileAttributes> {
  bool _show = false;
  final ProviderProfile _provider = ProviderProfile();
  late AttributesModel _oldAttributes;
  @override
  void initState() {
    _oldAttributes = AttributesModel.fromJson(widget.member.attributes.json());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _generateAttributes();
  }

  Widget _generateAttributes() {
    Color color = Utils().mapPosSevenColors[widget.member.idPosition];
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              const TitleAttribute(),
              SizedBox(
                width: 145.0,
                height: 130.0,
                child: AttributesDraw(
                  attributes: widget.member.attributes,
                  color: color,
                  isStack: false,
                  isBlack: true,
                ),
              ),
              DonutsAttributes(
                attributes: widget.member.attributes,
                update: _update,
              ),
              if (_show)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          widget.member.attributes = _oldAttributes;
                          setState(() => _show = false);
                        },
                        child: const Text("Cancelar"),
                      ),
                      const SizedBox(width: 30.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: _save,
                          child: const Text("Guardar"))
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  _update() {
    setState(() {
      _show = true;
    });
  }

  void _save() {
    {
      _provider
          .updateMyAttributes(attributes: widget.member.attributes.json())
          .then((value) {
        if (value) {
          setState(() => _show = false);
        }
      });
    }
  }
}
