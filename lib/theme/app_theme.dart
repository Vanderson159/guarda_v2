import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.blue[800],
  ),
  primaryColor: Colors.blue.shade800,
  buttonColor: Colors.blue.shade800,
  brightness: Brightness.light,
  accentColor: Colors.blue.shade800,
  focusColor: Colors.blue.shade800,
  appBarTheme: AppBarTheme(
    color: Colors.blue.shade800
  ),
);