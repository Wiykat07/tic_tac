import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';

import 'package:hive_flutter/adapters.dart';

void main() {
  late Preferences sut;

  setUp(() async {
    await setUpTestHive();
    Hive.registerAdapter(ColorAdapter());
    await Hive.openBox('Colors');
    sut = Preferences();
  });
  test('Initial values', () {
    expect(sut.primary, Colors.green);
    expect(sut.colors, 'Green');
    expect(sut.secondary, Colors.yellowAccent);
    expect(sut.secondColors, 'Yellow');
  });
  test('Gets colors', () {
    sut.colors = 'Blue';
    expect(sut.color, sut.colors);
    sut.secondColors = 'Red';
    expect(sut.secondColor, sut.secondColors);
  });
  test('updates colors', () {
    sut.primary = Colors.red;
    sut.secondary = Colors.blue;
    sut.colors = "Red";
    sut.secondColors = "Blue";

    sut.updatePrefs();

    expect(sut.colorBox.get(1), Colors.red);
    expect(sut.colorBox.get(2), Colors.blue);
    expect(sut.colorBox.get(3), 'Red');
    expect(sut.colorBox.get(4), 'Blue');
  });
  tearDown(() async {
    await tearDownTestHive();
  });
}
