import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac/color_data.dart';

class Preferences extends ChangeNotifier {
  ColorsDatabase db = ColorsDatabase();

  final colorBox = Hive.box('Colors');

  String get color {
    return db.colors;
  }

  Color get primary {
    return db.primary;
  }

  Color get secondary {
    return db.secondary;
  }

  String get secondColor {
    return db.secondColors;
  }

  void initialPrefs() {
    if (colorBox.get(3) == null || colorBox.get(1) == null) {
      db.createInitialColors();
    } else {
      db.loadData();
    }
    notifyListeners();
  }

  Future<void> updatePrefs() async {
    db.loadData();
    notifyListeners();
  }
}
