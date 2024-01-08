// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:soccer/pages/login/providers/provider_members.dart';
import 'package:soccer/user_preferences.dart';

import '../../models/match_model.dart';
import '../../utils/utils.dart';
import '../custom_drop_down.dart';

class MatchMVP extends StatelessWidget {
  final ProviderMembers providerMembers;
  final MatchModel match;
  MatchMVP({super.key, required this.providerMembers, required this.match});
  late BuildContext _context;
  final UserPreferences _prefs = UserPreferences();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return GestureDetector(
      onTap: () => _onTap(context: context),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.green,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(
                  Icons.star_outline_rounded,
                  size: 20.0,
                  color: Colors.white,
                ),
                Text(
                  "MVP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          const Text(
            "Partido finalizado",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: _content(context: context),
        insetPadding: EdgeInsets.zero,
      ),
    ).then((dynamic value) {});
  }

  String dropdownValue = "1";
  Widget _content({required BuildContext context}) {
    Map<int, String> listFields = providerMembers.getMembersMap();
    listFields.remove(_prefs.userId);
    listFields[0] = "Jugadores";
    dropdownValue = '0';

    return SizedBox(
      width: 90.0,
      height: 150.0,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                CustomDropDown(
                  key: UniqueKey(),
                  dropdownValue: dropdownValue,
                  list: listFields,
                  change: _onChangedField,
                  text: "Selecciona tu MVP",
                  colorText: Colors.black54,
                ),
                /*
                Text(
                  "Una vez seleccionado, no se podrá modificar",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
                )
                */
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedField({required int pos}) {
    UserPreferences prefs = UserPreferences();
    if (pos != 0) {
      List<String> listMVP = [];
      match.mapMVP.forEach((key, value) => listMVP.add('"$key-$value"'));
      listMVP.add('"${prefs.userId}-$pos"');

      match.idMPV = Utils().getMVP(listMVP.toString());

      providerMembers.updateMPV(match: match, newVote: pos);
      providerMembers.getMembers(idMvp: match.idMPV);

      Navigator.pop(_context);
    }
  }
}
