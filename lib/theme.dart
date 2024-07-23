import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      surface: Colors.blue,
      primary: Colors.amber.shade900,
      secondary: Colors.green,
      tertiary: Colors.lightGreen.shade800,
      onSurface: Colors.grey.shade200,
      onInverseSurface: Colors.grey.shade800),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      surface: Colors.blue.shade900,
      primary: Colors.deepOrange.shade900,
      secondary: Colors.green.shade800,
      tertiary: Colors.lightGreen.shade900,
      onSurface: Colors.grey.shade400,
      onInverseSurface: Colors.grey.shade200),
);
