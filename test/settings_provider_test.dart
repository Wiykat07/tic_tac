import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:tic_tac/colordata.dart';

class MockColors extends Mock implements ColorsDatabase {}

void main() {
  late ColorsDatabase db;

  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
    db = ColorsDatabase();
  });
  test('Initial values', () {
    expect(db.primary, Colors.green);
    expect(db.secondary, Colors.yellowAccent);
    expect(db.colors, 'Green');
    expect(db.secondColors, 'Yellow');
  });
  test('Gets colors', () {
    expect(db.primary, Colors.green);
    expect(db.secondary, Colors.yellowAccent);
    expect(db.colors, 'Green');
    expect(db.secondColors, 'Yellow');
  });
  test('updates colors', () {
    db.primary = Colors.black;
    db.secondary = Colors.white;
    db.colors = 'Black';
    db.secondColors = 'White';

    expect(db.colorBox.get(1), Colors.black);
    expect(db.colorBox.get(3), 'Black');
  });

  tearDown(() => tearDownTestHive());
}
