import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Screens/board.dart';
import 'package:tic_tac/Screens/single.dart';
import 'package:tic_tac/themes.dart';

void main() {
  final SingleState myWidgetState = SingleState();

  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
  });

  group('Unit Tests', () {
    test('Is everything initialized?', () {
      expect(myWidgetState.diff, 'Tic');
      expect(myWidgetState.difficulty, ['Tic', 'Tac', 'Toe']);
      expect(myWidgetState.ai, 0);
      expect(myWidgetState.names, []);
      expect(myWidgetState.description, 'The best AI you will ever face.');
    });
    test('Does Difficult do it\'s job?', () {
      expect(myWidgetState.difficult('Tac'), 1);
      expect(myWidgetState.description,
          'It kind of knows how the game is played.',);
    });
  });

  group('Widget Tests', () {
    testWidgets('Is everything there?', (tester) async {
      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
                create: (context) => GameProvider(),),
            ChangeNotifierProvider<Preferences>(
                create: (context) => Preferences(),),
          ],
          child: MaterialApp(
              title: 'TicTac',
              routes: {
                '/single': (context) => const Single(),
                '/board': (context) => const Board(),
              },
              theme:
                  CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                      .theme(),
              home: const Single(),),),);

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsNWidgets(2));
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('Does the textformfield do it\'s job?', (tester) async {
      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
                create: (context) => GameProvider(),),
            ChangeNotifierProvider<Preferences>(
                create: (context) => Preferences(),),
          ],
          child: MaterialApp(
              title: 'TicTac',
              routes: {
                '/single': (context) => const Single(),
                '/board': (context) => const Board(),
              },
              theme:
                  CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                      .theme(),
              home: const Single(),),),);

      await tester.enterText(find.byType(TextFormField), 'name');
    });

    testWidgets('Does the dropdown button work?', (tester) async {
      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
                create: (context) => GameProvider(),),
            ChangeNotifierProvider<Preferences>(
                create: (context) => Preferences(),),
          ],
          child: MaterialApp(
              title: 'TicTac',
              routes: {
                '/single': (context) => const Single(),
                '/board': (context) => const Board(),
              },
              theme:
                  CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                      .theme(),
              home: const Single(),),),);

      final SingleState state = tester.state(find.byType(Single));

      expect(state.diff, 'Tic');

      await tester.tap(find.byType(DropdownButton<String>));

      await tester.pumpAndSettle();

      await tester.tap(find.text('Tac'));

      await tester.pumpAndSettle();

      expect(state.diff, 'Tac');
    });

    testWidgets('Does the outlinebutton work?', (tester) async {
      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
                create: (context) => GameProvider(),),
            ChangeNotifierProvider<Preferences>(
                create: (context) => Preferences(),),
          ],
          child: MaterialApp(
              title: 'TicTac',
              routes: {
                '/single': (context) => const Single(),
                '/board': (context) => const Board(),
              },
              theme:
                  CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                      .theme(),
              home: const Single(),),),);

      final SingleState state = tester.state(find.byType(Single));

      await tester.enterText(find.byType(TextFormField), 'name');

      await tester.tap(find.byType(OutlinedButton));

      expect(state.names[0], 'name');
    });
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
