import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/settings_provider.dart';
import 'package:tic_tac/Screens/settings.dart';
import 'package:tic_tac/color_data.dart';
import 'package:tic_tac/themes.dart';

void main() {
  late ColorsDatabase db;
  const List<Key> keys1 = [
    Key('green'),
    Key('blue'),
    Key('red'),
    Key('yellow'),
    Key('purple'),
    Key('orange'),
    Key('black'),
    Key('white'),
    Key('indigo'),
    Key('cyan')
  ];
  const List<String> semantics = [
    'Green',
    'Blue',
    'Red',
    'Yellow',
    'Purple',
    'Orange',
    'Black',
    'White',
    'Indigo',
    'Cyan'
  ];
  const List<Key> keys2 = [
    Key('green2'),
    Key('blue2'),
    Key('red2'),
    Key('yellow2'),
    Key('purple2'),
    Key('orange2'),
    Key('black2'),
    Key('white2'),
    Key('indigo2'),
    Key('cyan2')
  ];
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
    db = ColorsDatabase();
  });

  testWidgets('All the buttons are there!', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ListenableProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: const SettingsScreen(),
        ),
      ),
    );
    db.createInitialColors();
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(4));
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(Container), findsNWidgets(20));
  });

  testWidgets('Buttons work!', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: const SettingsScreen(),
        ),
      ),
    );

    //primary color buttons work
    for (int i = 0; i < keys1.length; i++) {
      log('button $i');
      await tester.tap(find.byKey(keys1[i]));
      await tester.pump();
    }
    //secondary color buttons work
    for (int i = 0; i < keys2.length; i++) {
      log('second button $i');
      await tester.tap(find.byKey(keys2[i]));
      await tester.pump();
    }

    expect(find.byType(Container), findsNWidgets(20));
  });
  testWidgets('Semantic Test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: const SettingsScreen(),
        ),
      ),
    );
    //at least two labels show up for the colors to match the buttons
    //it will be three if the color is selected
    for (int i = 0; i < keys1.length; i++) {
      log('button $i');
      expect(find.bySemanticsLabel(semantics[i]), findsAtLeastNWidgets(2));
    }
  });
}
