import 'package:flutter/material.dart';
import 'colors.dart' as colors;

final ThemeData theme = ThemeData(
  primaryColor: colors.primaryColor,
  accentColor: colors.accentColor,
  scaffoldBackgroundColor: colors.backgroundColor,
  fontFamily: "Heebo",
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: "Heebo",
      fontWeight: FontWeight.w900,
    ),
  ).apply(
    bodyColor: colors.labelColor,
    displayColor: colors.labelColor,
  ),
  appBarTheme: AppBarTheme(
      color: colors.backgroundColor,
      iconTheme: IconThemeData(color: colors.accentColor)),
  buttonTheme: ButtonThemeData(
      buttonColor: colors.accentColor, disabledColor: colors.primaryColor),
);

final ThemeData themeDark = ThemeData(
    primaryColor: colors.primaryColorDark,
    accentColor: colors.accentColor,
    scaffoldBackgroundColor: colors.backgroundColorDark,
    fontFamily: "Heebo",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
        color: colors.backgroundColorDark,
        iconTheme: IconThemeData(color: colors.accentColor)),
    buttonTheme: ButtonThemeData(
        buttonColor: colors.accentColor,
        disabledColor: colors.primaryColorDark));
