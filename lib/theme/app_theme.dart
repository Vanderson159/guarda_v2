import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blue.shade800,
  brightness: Brightness.light,
  focusColor: Colors.blue.shade800,
  appBarTheme: AppBarTheme(
    color: Colors.blue.shade800
  ), colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.blue[800],
  ).copyWith(secondary: Colors.blue.shade800),
);