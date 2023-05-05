import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Screens/board.dart';
import 'package:tic_tac/Screens/settings.dart';
import 'package:tic_tac/Screens/single.dart';
import 'package:tic_tac/Screens/two.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/themes.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ColorAdapter());

  await Hive.openBox('Colors');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GameProvider>(create: (context) => GameProvider()),
    ChangeNotifierProvider<Preferences>(create: ((context) => Preferences())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<Preferences>(builder: (context, pref, child) {
      ThemeData themePicker() {
        ThemeData theme =
            CustomTheme(primary: pref.primary, secondary: pref.secondary)
                .theme();
        return theme;
      }

      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/single': (context) => const Single(),
          '/two': (context) => const Two(),
          '/roll': (context) => const Roll(),
          '/settings': (context) => const SettingsScreen(),
          '/board': (context) => const Board(),
        },
        title: 'TicTac',
        theme: themePicker(),
        home: const MyHomePage(title: 'TicTac'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/single');
                },
                child: const Text('One Player')),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/two');
                },
                child: const Text('Two Player')),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: const Text('Settings'))
          ],
        ),
      ),
    );
  }
}
