import 'package:flutter/material.dart';
import 'package:store/Core/colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      primarySwatch: color6,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.dark(),
      textTheme: TextTheme(),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, elevation: 0.0));

  static ThemeData darkTheme = ThemeData(
      primarySwatch: color12,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(),
      // ignore: prefer_const_constructors
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, elevation: 0.0));
}
