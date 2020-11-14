import 'package:flutter/cupertino.dart';
import 'colors.dart' as colors;

final CupertinoThemeData themeiOS = CupertinoThemeData(
    primaryColor: colors.primaryColor,
    scaffoldBackgroundColor: colors.backgroundColor,
    primaryContrastingColor: colors.accentColor,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: "Heebo",
      ),
    )
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: TextTheme(
    //   headline1: TextStyle(
    //       fontFamily: "Heebo", fontWeight: FontWeight.w900, fontSize: 42),
    //   headline2: TextStyle(
    //     fontFamily: "Heebo",
    //     fontWeight: FontWeight.w400,
    //     fontSize: 24,
    //   ),
    //   headline3: TextStyle(
    //       fontFamily: "Heebo", fontWeight: FontWeight.w700, fontSize: 16),
    //   bodyText1: TextStyle(
    //       fontFamily: "Heebo", fontWeight: FontWeight.w400, fontSize: 14),
    // ).apply(
    //   bodyColor: colors.labelColor,
    //   displayColor: colors.labelColor,
    // ),
    // appBarTheme: AppBarTheme(
    //     color: colors.backgroundColor,
    //     iconTheme: IconThemeData(color: colors.accentColor)),
    // buttonTheme: ButtonThemeData(
    //   buttonColor: colors.accentColor,
    //   disabledColor: colors.primaryColor,
    // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   labelStyle: TextStyle(
    //     fontSize: 16,
    //     fontFamily: "Heebo",
    //     color: colors.labelColor,
    //   ),
    //   enabledBorder: UnderlineInputBorder(
    //     borderSide: BorderSide(color: colors.smoothLabelColor),
    //   ),
    //   hintStyle: TextStyle(
    //     fontSize: 16,
    //     fontFamily: "Heebo",
    //     color: colors.smoothLabelColor,
    //   ),
    // ),
    );
