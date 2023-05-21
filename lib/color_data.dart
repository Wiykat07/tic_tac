import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColorsDatabase {
  Color primary = Colors.green;
  Color secondary = Colors.yellowAccent;
  String colors = 'Green';
  String secondColors = 'Yellow';

  //reference box
  final colorBox = Hive.box('Colors');

  //runs first time ever opening this app
  void createInitialColors() {
    primary = Colors.green;
    secondary = Colors.yellowAccent;
    colors = 'Green';
    secondColors = 'Yellow';
  }

  void loadData() {
    primary = colorBox.get(1) as Color;
    secondary = colorBox.get(2) as Color;
    colors = colorBox.get(3) as String;
    log('Color is $colors');
    secondColors = colorBox.get(4) as String;
  }

  void updatePrimary(Color p, String c) {
    colorBox.put(1, p);
    colorBox.put(3, c);
  }

  void updateSecondary(Color s, String c) {
    colorBox.put(2, s);
    colorBox.put(4, c);
  }
}
