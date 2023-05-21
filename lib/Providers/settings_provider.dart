import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac/color_data.dart';

class Preferences extends ChangeNotifier {
  ColorsDatabase db = ColorsDatabase();

  final colorBox = Hive.box('Colors');

  String get color {
    return db.colorBox.get(3) as String;
  }

  Color get primary {
    return db.colorBox.get(1, defaultValue: Colors.green) as Color;
  }

  Color get secondary {
    return db.colorBox.get(2, defaultValue: Colors.yellowAccent) as Color;
  }

  String get secondColor {
    return db.colorBox.get(4) as String;
  }

  void initialPrefs() {
    if (colorBox.get(3) == null || colorBox.get(1) == null) {
      db.createInitialColors();
    } else {
      db.loadData();
    }
  }

  void updatePrefs() {
    db.loadData();
    notifyListeners();
  }
}
