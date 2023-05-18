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
import 'package:tic_tac/Screens/homepage.dart';

import 'package:tic_tac/themes.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
  });

  testWidgets('Column and Buttons are there', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(
              create: (context) => GameProvider()),
          ChangeNotifierProvider<Preferences>(
              create: ((context) => Preferences())),
        ],
        child: MaterialApp(
            title: 'TicTac',
            theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                .theme(),
            home: const MyHomePage(title: 'TicTac'))));

    // Verify that we have three outlined buttons and a column.
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNWidgets(3));
  });
}
