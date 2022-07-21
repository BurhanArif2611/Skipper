import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF68B2C9)}) => ThemeData(
  fontFamily: 'Mulish',
  primaryColor: color,
  secondaryHeaderColor: Color(0xFF89D6ED),
  disabledColor: Color(0xFFBABFC4),
  backgroundColor: Color(0xFFF3F3F3),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: color, secondary: color),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
);