import 'package:flutter/material.dart';

import '../../login/models/member_model.dart';
import '../../login/widgets/custom_drop_down.dart';

class EditProfile extends StatefulWidget {
  final MemberModel member;
  const EditProfile({
    super.key,
    required this.member,
  });

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextEditingController _performanceController = TextEditingController();
  bool _showLoaded = false;
  final Map<int, String> _list = {
    1: 'Buena condición',
    2: 'Óptima condición',
    3: 'Lesionado',
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 180.0,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              )),
          /*
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: 120.0,
              padding: const EdgeInsets.only(top: 5, bottom: 5.0),
              child: TextField(
                controller: _performanceController,
                decoration: const InputDecoration(labelText: "Rendimiento"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
              ),
            ),
          ),
          */
          SizedBox(
            width: 160.0,
            child: CustomDropDown(
              key: UniqueKey(),
              dropdownValue: widget.member.status.toString(),
              list: _list,
              change: _change, //widget.changePosition,
              text: "Condición del jugador",
            ),
          ),
          _showLoaded
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    setState(() => _showLoaded = !_showLoaded);
                    Navigator.pop(context);
                  },
                  child: const Text("Modificar"),
                )
        ],
      ),
    );
  }

  _change({required int pos}) {
    widget.member.status = pos;
  }
}
