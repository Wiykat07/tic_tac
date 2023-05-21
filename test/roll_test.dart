import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Screens/board.dart';
import 'package:tic_tac/Screens/roll.dart';
import 'package:tic_tac/themes.dart';

void main() {
  final List<String> names = ['a', 'b'];
  setUp(() async {
    await setUpTestHive();
    await Hive.openBox('Colors');
  });

  group('Widget Tests', () {
    testWidgets('Is everything there?', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
              create: (context) => GameProvider(),
            ),
            ChangeNotifierProvider<Preferences>(
              create: (context) => Preferences(),
            ),
          ],
          child: MaterialApp(
            title: 'TicTac',
            routes: {
              '/roll': (context) => const Roll(),
              '/board': (context) => const Board(),
            },
            theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                .theme(),
            home: Navigator(
              onGenerateRoute: (_) {
                return MaterialPageRoute<Widget>(
                  builder: (_) => const Roll(),
                  settings: RouteSettings(arguments: names),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('Does Alertbox appear?', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<GameProvider>(
              create: (context) => GameProvider(),
            ),
            ChangeNotifierProvider<Preferences>(
              create: (context) => Preferences(),
            ),
          ],
          child: MaterialApp(
            title: 'TicTac',
            routes: {
              '/roll': (context) => const Roll(),
              '/board': (context) => const Board(),
            },
            theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
                .theme(),
            home: Navigator(
              onGenerateRoute: (_) {
                return MaterialPageRoute<Widget>(
                  builder: (_) => const Roll(),
                  settings: RouteSettings(arguments: names),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsNothing);

      await tester.tap(find.byType(OutlinedButton));

      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
