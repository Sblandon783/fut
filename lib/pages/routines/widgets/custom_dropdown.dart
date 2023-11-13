import 'package:flutter/material.dart';

import '../models/goalers_model.dart';

class CustomDropDown extends StatefulWidget {
  final Function onChanged;
  final List<GoalerModel> listPlayer;
  const CustomDropDown({
    Key? key,
    required this.onChanged,
    required this.listPlayer,
  }) : super(key: key);

  @override
  CustomDropDownState createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) => DropdownButton(
        value: widget.listPlayer.first,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: widget.listPlayer
            .map((items) => DropdownMenuItem(
                  value: items,
                  child: Text(items.player),
                ))
            .toList(),
        onChanged: widget.listPlayer.length == 1
            ? null
            : (newValue) {
                if (newValue == 'Selecciona') return;

                widget.onChanged(newValue);
              },
      );
}
