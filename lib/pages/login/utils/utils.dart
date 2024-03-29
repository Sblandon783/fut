import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:soccer/pages/login/models/atribbute_model.dart';

import '../models/member_model.dart';

class Utils {
  final Map<int, String> _positions = {
    1: 'POR',
    2: 'LTD',
    3: 'LTI',
    4: 'DFC',
    5: 'MD',
    6: 'MC',
    7: 'DC'
  };

  Map<int, String> get getPositions => _positions;

  final Map<int, dynamic> _mapPosSix = {
    1: {
      "name": "2-1-2-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 35.0, "right": 160.0}, //'MI',
        6: {"top": 85.0, "right": 110.0}, //'MC',
        7: {"top": 140.0, "right": 160.0}, //'MD',
      },
    },
    2: {
      "name": "1-2-2-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 85.0, "right": 180.0}, //'MI',
        6: {"top": 45.0, "right": 120.0}, //'MC',
        7: {"top": 130.0, "right": 120.0}, //'MD',
      }
    },
    3: {
      "name": "2-3-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 35.0, "right": 160.0}, //'MI',
        6: {"top": 85.0, "right": 60.0}, //'MC',
        7: {"top": 140.0, "right": 160.0}, //'MD',
      }
    }
  };

  final Map<int, dynamic> _mapPosSeven = {
    1: {
      "name": "1-2-1-2-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 35.0, "right": 160.0}, //'MI',
        6: {"top": 85.0, "right": 110.0}, //'MC',
        7: {"top": 140.0, "right": 160.0}, //'MD',
        9: {"top": 85.0, "right": 200.0} //'DC'
      },
    },
    2: {
      "name": "2-2-2-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 45.0, "right": 200.0}, //'MI',
        6: {"top": 55.0, "right": 120.0}, //'MC',
        7: {"top": 120.0, "right": 120.0}, //'MD',
        9: {"top": 135.0, "right": 200.0} //'DC'
      }
    },
    3: {
      "name": "2-1-1-2-1",
      "positions": {
        1: {"top": 85.0, "right": 30.0}, //'POR',
        2: {"top": 135.0, "right": 60.0}, //'LTD',
        3: {"top": 35.0, "right": 60.0}, //'LTI',
        5: {"top": 40.0, "right": 200.0}, //'MI',
        6: {"top": 85.0, "right": 80.0}, //'MC',
        7: {"top": 85.0, "right": 140.0}, //'MD',
        9: {"top": 135.0, "right": 200.0} //'DC'
      }
    }
  };

  Map<int, Map<String, double>> getAlign(
      {required int idField, required int idAlign}) {
    Map<int, Map<int, dynamic>> map = {};
    Map<int, dynamic> currentMap = idField == 1 ? _mapPosSix : _mapPosSeven;

    currentMap.forEach((key, value) {
      map[key] = value["positions"];
    });
    return map[idAlign] ?? currentMap[1]["positions"];
  }

  Map<int, String> getNameAlign({required int idField}) {
    Map<int, String> map = {};
    Map<int, dynamic> currentMap = idField == 1 ? _mapPosSix : _mapPosSeven;
    currentMap.forEach((key, value) {
      map[key] = value["name"];
    });
    return map;
  }

  final Map<int, MaterialColor> _mapPosSevenColors = {
    1: Colors.blue, //'POR',
    2: Colors.green, //'LTD',
    3: Colors.green, //'LTI',
    //4: {"top": 85.0, "right": 110.0}, //'DFC',
    5: Colors.cyan, //'MD',
    6: Colors.orange, //'MC',
    7: Colors.cyan, //'MI',
    //8: {"top": 140.0, "right": 200.0}, //'MD',
    9: Colors.red //'DC'
  };
  get mapPosSevenColors => _mapPosSevenColors;

  final Map<int, String> _mapPosition = {
    1: 'POR',
    2: 'LTD',
    3: 'LTI',
    4: 'DFC',
    5: 'MD',
    6: 'MC',
    7: 'MI',
    8: 'MD',
    9: 'DC'
  };

  get mapPosition => _mapPosition;

  final Map<int, String> _images = {
    1: 'portero.png', //'POR',
    2: 'player_lt_small.png', //'LTD',
    3: 'player_lt_small.png', //'LTI',
    4: 'player_lt_small.png', //'DFC',
    5: 'player_mcd_small.png', //'MD',
    6: 'player_mc.png', // 'MC',
    7: 'player_mcd_small.png', //'MI',
    8: 'player_mcd_small.png', //'MD',
    9: 'player_dc_small.png', //'DC'
  };

  get images => _images;

  Map<dynamic, dynamic> attributesDefault = {
    "attack": 50,
    "technique": 50,
    "creative": 50,
    "tactic": 50,
    "defense": 50
  };

  MemberModel getMember({required int position}) {
    final MemberModel member = MemberModel(
      id: -1,
      name: '',
      number: -1,
      position: Utils().mapPosition[position],
      idPosition: position,
      date: '',
      included: false,
      titular: false,
      attributes: AttributesModel.fromJson(attributesDefault),
    );
    return member;
  }

  Map<int, int> getMap({required dynamic text}) {
    if (text == null || text.isEmpty) return {};
    List<String> list = json.decode(text).cast<String>();

    Map<int, int> map = {
      for (String v in list)
        int.parse(v.split('/').first): int.parse(v.split('/').last)
    };

    return map;
  }

  getDate({required String date}) {
    if (date.isEmpty) {
      return DateTime.now();
    }
    final DateTime parsedDateCurrent = DateTime.parse(date);

    initializeDateFormatting('es');
    return DateFormat.MMMEd('es').format(parsedDateCurrent).toUpperCase();
  }

  getParsedDate({required dynamic date}) {
    if (date == null) {
      return DateTime.now();
    }
    final DateTime parsedDateCurrent = DateTime.parse(date);
    return parsedDateCurrent;
  }

  getHour({required String date}) {
    final DateTime parsedDate = DateTime.parse(date);
    DateFormat dateFormat = DateFormat("HH:mm");
    String string = dateFormat.format(parsedDate);
    return string;
  }

  Color getColorAttributes({required int total}) {
    if (total <= 50) {
      return Colors.red;
    } else if (total > 50 && total < 75) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  getMVP(dynamic value) {
    if (value == null || value == "") {
      return -1;
    }
    Map<int, int> map = Utils().getMap(text: value);
    return findMax(map.values.toList());
  }

  findMax(Iterable list) => list
      .fold(
          {},
          (map, element) =>
              map..update(element, (value) => value + 1, ifAbsent: () => 1))
      .entries
      .reduce((e1, e2) => e1.value > e2.value ? e1 : e2)
      .key;
}
