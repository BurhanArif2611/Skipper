import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFFE58624)}) =>
    ThemeData(
  fontFamily: 'Mulish',
  primaryColor: color,
  secondaryHeaderColor: Color(0xFFE58624),
  disabledColor: Color(0xFFE5E7EB),
  backgroundColor: Color(0xFFF3F3F3),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF222222),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: color, secondary: color),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
);