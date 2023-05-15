import 'package:flutter/material.dart';

class CustomTheme {
  Color? primary = Colors.green;
  Color? secondary = Colors.yellow;

  CustomTheme({this.primary, this.secondary});

  ThemeData theme() {
    return ThemeData(
      appBarTheme:
          AppBarTheme(backgroundColor: primary, foregroundColor: secondary),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(secondary),
        foregroundColor: MaterialStateProperty.all(primary),
      )),
      dialogTheme: DialogTheme(
        backgroundColor: primary,
        titleTextStyle: TextStyle(
          color: secondary,
        ),
      ),
      inputDecorationTheme:
          InputDecorationTheme(labelStyle: TextStyle(color: secondary)),
      primaryColor: secondary,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          background: primary!,
          error: secondary!,
          onBackground: primary!,
          onError: const Color.fromRGBO(238, 238, 238, 1),
          onPrimary: const Color.fromRGBO(238, 238, 238, 1),
          onSecondary: const Color.fromRGBO(238, 238, 238, 1),
          onTertiary: const Color.fromRGBO(238, 238, 238, 1),
          onSurface: const Color.fromRGBO(238, 238, 238, 1),
          primary: secondary!,
          secondary: secondary!,
          surface: secondary!,
          primaryContainer: primary),
      canvasColor: primary,
      textTheme: TextTheme(
          bodyMedium: TextStyle(color: secondary),
          labelMedium: TextStyle(color: secondary),
          titleMedium: TextStyle(color: secondary)),
      scaffoldBackgroundColor: primary,
    );
  }
}
