import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xFFAE2B89)}) => ThemeData(
  fontFamily: 'Mulish',
  primaryColor: color,
  secondaryHeaderColor: Color(0xFFAE2B89),
  /*disabledColor: Color(0xffa2a7ad),*/
  disabledColor: Color(0xFFE5E7EB),
  backgroundColor: Color(0xFF000000),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF222222),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: color, secondary: color),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
);
