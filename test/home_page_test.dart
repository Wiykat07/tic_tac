// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:hive_test/hive_test.dart';

import 'package:tic_tac/main.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
  });
  testWidgets('Tic Tac test run', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
        ChangeNotifierProvider<Preferences>(
            create: ((context) => Preferences())),
      ],
      child: const MyApp(),
    ));

    // Verify that we have three outlined buttons.
    expect(find.bySubtype<Column>(), findsNWidgets(1));

    // check that the buttons do something
    await tester.tap(find.widgetWithText(OutlinedButton, 'Settings'));

    await tester.tap(find.widgetWithText(OutlinedButton, 'Two Player'));

    await tester.tap(find.widgetWithText(OutlinedButton, 'One Player'));
  });
  tearDown(() async => await tearDownTestHive());
}
