import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(100, 181, 246, 1),
    backgroundColor: Colors.black,
    textTheme: const TextTheme(
        displayMedium: TextStyle(color: Colors.white, fontSize: 18),
        displaySmall: TextStyle(color: Colors.white, fontSize: 12))
    //: const Color.fromRGBO(155, 231, 255, 1)))
    );

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
