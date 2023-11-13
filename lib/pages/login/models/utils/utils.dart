import 'package:flutter/material.dart';

class Utils {
  final Map<int, Map<String, double>> _mapPosSeven = {
    1: {"top": 85.0, "right": 30.0}, //'POR',
    2: {"top": 135.0, "right": 60.0}, //'LTD',
    3: {"top": 35.0, "right": 60.0}, //'LTI',
    //4: {"top": 85.0, "right": 110.0}, //'DFC',
    5: {"top": 140.0, "right": 160.0}, //'MD',
    6: {"top": 85.0, "right": 110.0}, //'MC',
    7: {"top": 35.0, "right": 160.0}, //'MI',
    //8: {"top": 140.0, "right": 200.0}, //'MD',
    9: {"top": 85.0, "right": 200.0} //'DC'
  };
  get mapPosSeven => _mapPosSeven;

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
}
