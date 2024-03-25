import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFFF8CA0A)}) =>
    ThemeData(
  fontFamily: 'Mulish',
  primaryColor: color,
  secondaryHeaderColor: Color(0xFFF8CA0A),
  disabledColor: Color(0xFFE5E7EB),
  backgroundColor: Color(0xFF19181E),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF000000),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: color, secondary: color),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)


  ),
);