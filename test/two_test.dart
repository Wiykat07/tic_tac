import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Screens/roll.dart';
import 'package:tic_tac/Screens/two.dart';
import 'package:tic_tac/themes.dart';

void main() {
  final TwoState state = TwoState();
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
  });

  Widget createTestWidget() {
    return MaterialApp(
        title: 'TicTac',
        routes: {
          '/two': (context) => const Two(),
          '/roll': (context) => const Roll(),
        },
        theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
            .theme(),
        home: const Two());
  }

  group('Unit Tests', () {
    test('Is names initalized?', () {
      expect(state.names, []);
    });
  });

  group('Widget Tests', () {
    testWidgets('Is everything there?', (tester) async {
      await tester.pumpWidget(MultiProvider(providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
        ChangeNotifierProvider<Preferences>(
            create: ((context) => Preferences())),
      ], child: createTestWidget()));

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('Do the textformfields work?', (tester) async {
      await tester.pumpWidget(MultiProvider(providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
        ChangeNotifierProvider<Preferences>(
            create: ((context) => Preferences())),
      ], child: createTestWidget()));

      await tester.enterText(find.byKey(const Key('First Player')), 'name');
      await tester.enterText(find.byKey(const Key('Second Player')), 'name2');
    });
    testWidgets('Does the button work?', (tester) async {
      await tester.pumpWidget(MultiProvider(providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
        ChangeNotifierProvider<Preferences>(
            create: ((context) => Preferences())),
      ], child: createTestWidget()));

      final TwoState state2 = tester.state(find.byType(Two));

      await tester.enterText(find.byKey(const Key('First Player')), 'name');
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('Second Player')), 'nameb');

      await tester.pumpAndSettle();

      expect(state2.player2Controller.text, 'nameb');

      await tester.tap(find.byType(OutlinedButton));

      expect(state2.names[0], 'name');
      expect(state2.names[1], 'nameb');
    });
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
