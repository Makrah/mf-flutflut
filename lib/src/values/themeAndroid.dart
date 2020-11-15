import 'package:flutter/material.dart';
import 'colors.dart' as colors;

final ThemeData theme = ThemeData(
  primaryColor: colors.primaryColor,
  accentColor: colors.accentColor,
  scaffoldBackgroundColor: colors.backgroundColor,
  fontFamily: 'Heebo',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontFamily: 'Heebo', fontWeight: FontWeight.w900, fontSize: 42),
    headline2: TextStyle(
      fontFamily: 'Heebo',
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    headline3: TextStyle(
        fontFamily: 'Heebo', fontWeight: FontWeight.w700, fontSize: 16),
    bodyText1: TextStyle(
        fontFamily: 'Heebo', fontWeight: FontWeight.w400, fontSize: 14),
  ).apply(
    bodyColor: colors.labelColor,
    displayColor: colors.labelColor,
  ),
  appBarTheme: const AppBarTheme(
      color: colors.backgroundColor,
      iconTheme: IconThemeData(color: colors.accentColor)),
  buttonTheme: const ButtonThemeData(
    buttonColor: colors.accentColor,
    disabledColor: colors.primaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 16,
      fontFamily: 'Heebo',
      color: colors.labelColor,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colors.smoothLabelColor),
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      fontFamily: 'Heebo',
      color: colors.smoothLabelColor,
    ),
  ),
);

final ThemeData themeDark = ThemeData(
    primaryColor: colors.primaryColorDark,
    accentColor: colors.accentColor,
    scaffoldBackgroundColor: colors.backgroundColorDark,
    fontFamily: 'Heebo',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      color: colors.backgroundColorDark,
      iconTheme: IconThemeData(color: colors.accentColor),
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: colors.accentColor,
        disabledColor: colors.primaryColorDark));
