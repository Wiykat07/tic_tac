import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/hive_test.dart';
import 'package:tic_tac/Providers/settings_provider.dart';
import 'package:tic_tac/color_data.dart';

void main() {
  late Preferences sut;

  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
    sut = Preferences();
  });
  test('Initial values', () {
    expect(
      sut.colorBox,
      Hive.box('Colors'),
    );
    expect(sut.db, ColorsDatabase());
  });
  test('Gets color', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    expect(sut.color, sut.db.colors);
  });
  test('Gets primary', () {
    expect(sut.primary, sut.db.primary);
  });
  test('Gets secondary', () {
    expect(sut.secondary, sut.db.secondary);
  });
  test('Gets secondColor', () {
    expect(sut.secondColor, sut.db.secondColors);
  });
  test('displays initial colors on first opening', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    sut.initialPrefs();
    expect(sut.color, 'Green');
    expect(sut.primary, Colors.green);
    expect(sut.secondary, Colors.yellowAccent);
    expect(sut.secondColor, 'Yellow');
  });

  test('Loads changed colors on multiple openings', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    sut.initialPrefs();
    sut.db.colorBox.put(1, Colors.black);
    sut.db.colorBox.put(3, 'Black');
    sut.initialPrefs();
    expect(sut.color, 'Black');
    expect(sut.primary, Colors.black);
  });
  test('Update prefs works', () {
    if (!Hive.isAdapterRegistered(200)) {
      Hive.registerAdapter(ColorAdapter());
    }
    sut.initialPrefs();
    sut.db.colorBox.put(1, Colors.black);
    sut.db.colorBox.put(3, 'Black');

    sut.updatePrefs();

    expect(sut.color, 'Black');
    expect(sut.primary, Colors.black);
  });

  tearDown(() => tearDownTestHive());
}
