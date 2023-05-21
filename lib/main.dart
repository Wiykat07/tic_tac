import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/game_provider.dart';
import 'package:tic_tac/Providers/settings_provider.dart';
import 'package:tic_tac/Screens/board.dart';
import 'package:tic_tac/Screens/home_page.dart';
import 'package:tic_tac/Screens/settings.dart';
import 'package:tic_tac/Screens/single.dart';
import 'package:tic_tac/Screens/two.dart';
import 'package:tic_tac/themes.dart';

import 'Screens/roll.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());

  final colorBox = await Hive.openBox('Colors');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
          create: (context) => GameProvider(),
        ),
        ListenableProvider<Preferences>(
          create: (context) => Preferences(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      theme: CustomTheme(
        primary: Provider.of<Preferences>(context, listen: true).primary,
        secondary: Provider.of<Preferences>(context, listen: true).secondary,
      ).theme(),
      home: const MyHomePage(title: 'TicTac'),
    );
  }
}
