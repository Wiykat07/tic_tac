import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Preferences extends ChangeNotifier {
  Color primary = Colors.green;
  Color secondary = Colors.yellowAccent;
  String colors = 'Green';
  String secondColors = 'Yellow';

  Box colorBox = Hive.box('Colors');

  String get color {
    return colors;
  }

  String get secondColor {
    return secondColors;
  }

  void updatePrefs() {
    colorBox.put(1, primary);
    colorBox.put(2, secondary);
    colorBox.put(3, colors);
    colorBox.put(4, secondColors);

    notifyListeners();
  }
}
