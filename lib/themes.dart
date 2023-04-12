import 'package:flutter/material.dart';

ThemeData themeStandard = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green, foregroundColor: Colors.yellow),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.yellow),
    foregroundColor: MaterialStateProperty.all(Colors.green),
  )),
  primaryColor: Colors.yellow,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.green,
      error: Colors.red,
      onBackground: Colors.green,
      onError: Color.fromRGBO(238, 238, 238, 1),
      onPrimary: Color.fromRGBO(238, 238, 238, 1),
      onSecondary: Color.fromRGBO(238, 238, 238, 1),
      onTertiary: Color.fromRGBO(238, 238, 238, 1),
      onSurface: Color.fromRGBO(238, 238, 238, 1),
      primary: Colors.yellow,
      secondary: Colors.yellow,
      surface: Colors.yellow,
      primaryContainer: Colors.green),
  canvasColor: Colors.green,
  textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.yellow),
      titleMedium: TextStyle(color: Colors.yellow)),
  scaffoldBackgroundColor: Colors.green,
);

ThemeData themeBlackWhite = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black, foregroundColor: Colors.white),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.black),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  )),
  primaryColor: Colors.black,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Colors.black,
      error: Colors.red,
      onBackground: Colors.white,
      onError: Color.fromRGBO(238, 238, 238, 1),
      onPrimary: Color.fromRGBO(238, 238, 238, 1),
      onSecondary: Color.fromRGBO(238, 238, 238, 1),
      onTertiary: Color.fromRGBO(238, 238, 238, 1),
      onSurface: Color.fromRGBO(238, 238, 238, 1),
      primary: Colors.black,
      secondary: Colors.black,
      surface: Colors.black,
      primaryContainer: Colors.white),
  canvasColor: Colors.white,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
);
ThemeData themeMichigan = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[900], foregroundColor: Colors.yellow),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.yellow),
    foregroundColor: MaterialStateProperty.all(Colors.blue[900]),
  )),
  primaryColor: Colors.yellow,
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      background: Colors.blue[900]!,
      error: Colors.red,
      onBackground: Colors.green,
      onError: const Color.fromRGBO(238, 238, 238, 1),
      onPrimary: const Color.fromRGBO(238, 238, 238, 1),
      onSecondary: const Color.fromRGBO(238, 238, 238, 1),
      onTertiary: const Color.fromRGBO(238, 238, 238, 1),
      onSurface: const Color.fromRGBO(238, 238, 238, 1),
      primary: Colors.yellow,
      secondary: Colors.yellow,
      surface: Colors.yellow,
      primaryContainer: Colors.blue[900]!),
  canvasColor: Colors.blue[900]!,
  textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.yellow),
      titleMedium: TextStyle(color: Colors.yellow)),
  scaffoldBackgroundColor: Colors.blue[900],
);
