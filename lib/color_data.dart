import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColorsDatabase {
  Color primary = Colors.green;
  Color secondary = Colors.yellowAccent;
  String colors = 'Green';
  String secondColors = 'Yellow';

  //reference box
  final colorBox = Hive.box('Colors');

  @override
  int get hashCode => Object.hash(primary, secondary, colors, secondColors);

  @override
  bool operator ==(Object other) =>
      other is ColorsDatabase &&
      other.primary == primary &&
      other.secondary == secondary &&
      other.colors == colors &&
      other.secondColors == secondColors;

  //runs first time ever opening this app
  void createInitialColors() {
    colorBox.put(1, primary);
    colorBox.put(2, secondary);
    colorBox.put(3, colors);
    colorBox.put(4, secondColors);
  }

  void loadData() {
    primary = colorBox.get(1) as Color;
    secondary = colorBox.get(2) as Color;
    colors = colorBox.get(3) as String;
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
