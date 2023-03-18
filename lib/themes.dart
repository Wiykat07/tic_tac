import 'package:flutter/material.dart';

ThemeData themeStandard = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.green),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green),
    foregroundColor: MaterialStateProperty.all(Colors.yellow),
  )),
  primaryColor: Colors.yellow,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.yellow)),
  scaffoldBackgroundColor: Colors.green,
);

ThemeData themeBlackWhite = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.black),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.black),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  )),
  primaryColor: Colors.black,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
);
ThemeData themeMichigan = ThemeData(
  appBarTheme: AppBarTheme(color: Colors.blue[900]),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
    foregroundColor: MaterialStateProperty.all(Colors.yellow),
  )),
  primaryColor: Colors.yellow,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.yellow)),
  scaffoldBackgroundColor: Colors.blue[900],
);
