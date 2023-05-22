import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/hive_test.dart';
import 'package:tic_tac/color_data.dart';

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
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    db.createInitialColors();
    expect(db.colorBox.get(1), Colors.green);
    expect(db.colorBox.get(2), Colors.yellowAccent);
    expect(db.colorBox.get(3), 'Green');
    expect(db.colorBox.get(4), 'Yellow');
  });
  test('updates primary colors', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    db.updatePrimary(Colors.black, 'Black');
    expect(db.colorBox.get(1), Colors.black);
    expect(db.colorBox.get(3), 'Black');
  });

  test('Updates secondary colors', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }

    db.updateSecondary(Colors.white, 'White');
    expect(db.colorBox.get(2), Colors.white);
    expect(db.colorBox.get(4), 'White');
  });

  tearDown(() => tearDownTestHive());
}
