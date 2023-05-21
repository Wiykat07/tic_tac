import 'package:confetti/confetti.dart';
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
  const int diff = 0;
  late GameProvider game;
  late Player p1;
  late Player p2;

  final List<String> keys = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight'
  ];

  setUp(() async {
    game = GameProvider();
    await setUpTestHive();
    await Hive.openBox('Colors');
    p1 = Player(name: 'playerone', piece: false, number: PlayerNumber.player1);
    p2 = Player(name: 'playertwo', piece: true, number: PlayerNumber.player2);
  });

  testWidgets('Initial widgets are all there', (WidgetTester tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Row), findsNWidgets(3));
    for (int i = 0; i < 9; i++) {
      expect(find.byKey(Key(keys[i])), findsOneWidget);
    }
  });

  testWidgets('PiecePlaced Works', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );

    expect(game.board, {});
    await tester.tap(find.byKey(const Key('zero')));

    await tester.pump();

    expect(game.board, {0: false});
  });

  testWidgets('InteractiveSquare Works', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );

    expect(game.currentPlayer.number, PlayerNumber.player1);
    //press the first square
    await tester.tap(find.byKey(const Key('zero')));

    await tester.pump();
    //expect that it changes the board to have 0 valued at false.
    expect(game.board, {0: false});

    //should be player 2's turn
    expect(game.currentPlayer.number, PlayerNumber.player2);

    //press the first square again
    await tester.tap(find.byKey(const Key('zero')));

    await tester.pump();

    //expect that it STILL has 0 valued at false (because it should know not to change things)
    expect(game.board, {0: false});
  });
  testWidgets('InteractiveSquare Works with AI', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );

    expect(game.currentPlayer.number, PlayerNumber.player1);
    //press the first square
    await tester.tap(find.byKey(const Key('zero')));

    await tester.pump();
    //expect that it changes the board to have 0 valued at false and (if the AI is working) have 4:true
    expect(game.board, {0: false, 4: true});
  });
  testWidgets('Confetti Works', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('one')));
    await tester.pump();

    expect(find.byType(ConfettiWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
  });
  testWidgets('tie alert pops up', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('two'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('six'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('three'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('five'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('one'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven'))); //X
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    expect(find.byType(AlertDialog), findsOneWidget);
  });
  testWidgets('win alert pops up', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('one')));
    await tester.pump();

    expect(find.byType(ConfettiWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    expect(find.byType(AlertDialog), findsOneWidget);
  });
  testWidgets('tie alert switch turns button works for two player',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('two'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('six'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('three'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('five'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('one'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven'))); //X
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Switch Turns!'));

    expect(game.board.isEmpty, true);
    expect(game.players[0], p2);
    expect(game.players[1], p1);
  });
  testWidgets('tie alert quit button works for two player', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('two'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('six'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('three'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('five'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('one'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven'))); //X
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Quit'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('tie alert Play again button works for two player',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('two'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('six'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('three'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('five'))); //X
    await tester.pump();
    await tester.tap(find.byKey(const Key('one'))); //O
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven'))); //X
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Play Again!'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('win alert switch turns button works for two player',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('one')));
    await tester.pump();

    expect(find.byType(ConfettiWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Switch Turns!'));

    expect(game.board.isEmpty, true);
    expect(game.players[0], p2);
    expect(game.players[1], p1);
  });

  testWidgets('win alert quit button works for two player', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('one')));
    await tester.pump();

    expect(find.byType(ConfettiWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Quit'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('win alert play again button works for two player',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.player2);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('zero')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('one')));
    await tester.pump();

    expect(find.byType(ConfettiWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Play Again!'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('tie alert change difficulty button works for ai',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'Computer', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          routes: {
            '/single': (context) => const Single(),
            '/board': (context) => const Board(),
          },
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('three')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Change Difficulty'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('tie alert quit button works for Ai', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('three')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Quit'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('tie alert Play again button works for Ai', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a tie state...
    await tester.tap(find.byKey(const Key('four')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('three')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Play Again!'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('win alert change difficulty button works for ai',
      (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          routes: {
            '/single': (context) => const Single(),
            '/board': (context) => const Board(),
          },
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('five')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Change Difficulty'));

    expect(game.board.isEmpty, true);
  });

  testWidgets('win alert quit button works for ai', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('five')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Quit'));

    expect(game.board.isEmpty, true);
  });
  testWidgets('win alert play again button works for ai', (tester) async {
    game.addPlayer(false, 'playerone', PlayerNumber.player1);
    game.addPlayer(true, 'playertwo', PlayerNumber.ai);
    game.switchTurns(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GameProvider>(create: (context) => game),
          ChangeNotifierProvider<Preferences>(
            create: (context) => Preferences(),
          ),
        ],
        child: MaterialApp(
          title: 'TicTac',
          theme: CustomTheme(primary: Colors.green, secondary: Colors.yellow)
              .theme(),
          home: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (_) => const Board(),
                settings: const RouteSettings(arguments: diff),
              );
            },
          ),
        ),
      ),
    );
    //setting up a win state...
    await tester.tap(find.byKey(const Key('five')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('seven')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('eight')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('two')));
    await tester.pump();

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.widgetWithText(TextButton, 'Play Again!'));

    expect(game.board.isEmpty, true);
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
