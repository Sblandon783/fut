import 'package:flutter/material.dart';

import '../models/goalers_model.dart';
import 'custom_dropdown.dart';

class CustomListViewDropdown extends StatefulWidget {
  final List<GoalerModel> players;
  final Function onChanged;
  final int idTeam;

  const CustomListViewDropdown({
    required this.players,
    required this.onChanged,
    required this.idTeam,
    Key? key,
  }) : super(key: key);

  @override
  CustomListViewDropdownState createState() => CustomListViewDropdownState();
}

class CustomListViewDropdownState extends State<CustomListViewDropdown> {
  final List<GoalerModel> _listPlayerSelected = [];
  final List<GoalerModel> _listPlayer = [];
  @override
  void initState() {
    super.initState();
    _listPlayer.add(GoalerModel(
        id: -1,
        player: widget.players.isNotEmpty ? "Selecciona" : "No hay jugadores"));
    _listPlayer.addAll(widget.players);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown(onChanged: onChanged, listPlayer: _listPlayer),
        if (_listPlayerSelected.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.white.withOpacity(0.3),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _listPlayerSelected
                      .map(
                        (player) => _generatePlayer(player: player),
                      )
                      .toList()),
            ),
          )
      ],
    );
  }

  Widget _generatePlayer({required GoalerModel player}) => GestureDetector(
        onTap: () => _addGoals(player: player),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 5.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.player),
              Text(player.goals.toString()),
            ],
          ),
        ),
      );

  Future<void> _addGoals({required GoalerModel player}) async {
    /*
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content:
              AlertAddGoals(player: player, onChanged: _changePlayerGoalers),
          insetPadding: EdgeInsets.zero,
        );
      },
    );
    */
  }

  void _changePlayerGoalers(GoalerModel player, int pastGoals) {
    Navigator.pop(context);
    widget.onChanged(widget.idTeam, player.goals, pastGoals);
    setState(() {});
  }

  void onChanged(GoalerModel player) {
    player.goals++;
    _listPlayerSelected.add(player);
    _listPlayer.remove(player);
    if (_listPlayer.length == 1) {
      _listPlayer.clear();
      _listPlayer.add(GoalerModel(id: -1, player: "No hay jugadores"));
    }
    widget.onChanged(widget.idTeam, 1, 0);
    setState(() {});
  }
}
