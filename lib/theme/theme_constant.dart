import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
        accentColor: Colors.black
    ),
    textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black, fontSize: 22),
        labelLarge: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
        labelMedium: TextStyle(color: Colors.black, fontSize: 15),
        labelSmall: TextStyle(color: Colors.black, fontSize: 12)),
    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0, foregroundColor: Colors.black));

ThemeData darkTheme = ThemeData(
    backgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        brightness : Brightness.dark,
        accentColor: Colors.white
    ),
    textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white, fontSize: 22),
        labelLarge: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
        labelMedium: TextStyle(color: Colors.white, fontSize: 15),
        labelSmall: TextStyle(color: Colors.white, fontSize: 12)),
    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0, foregroundColor: Colors.white));
