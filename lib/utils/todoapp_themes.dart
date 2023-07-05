//making things of appa

import 'package:flutter/material.dart';

import 'app_styles.dart';

class TodoThemsData {
  static final lightTheme = ThemeData(
    canvasColor: kDarkCardC,
    datePickerTheme: const DatePickerThemeData(
        headerBackgroundColor: kprimarycolor,
        todayBorder: BorderSide(color: kprimarycolor),
        rangePickerSurfaceTintColor: kprimarycolor),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kFontBlackC),
        bodyMedium: TextStyle(color: kFontBlackC),
        bodySmall: TextStyle(color: kFontBlackC)),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kprimarycolor,
    colorScheme: const ColorScheme.light(),
    cardColor: kCardColor,
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: kGreenColor,
      focusColor: kTextFieldColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kprimarycolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kprimarycolor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  //darkThem
  static final darkTheme = ThemeData(
      canvasColor: kDarkCardC,
      datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: kprimarycolor,
          todayBorder: BorderSide(color: kprimarycolor),
          rangePickerSurfaceTintColor: kprimarycolor),
      scaffoldBackgroundColor: kDarkScaffoldC,
      colorScheme: const ColorScheme.dark(),
      primaryColor: kprimarycolor,
      inputDecorationTheme: InputDecorationTheme(
          hoverColor: kDarkGreenColor,
          focusColor: kDarkGreenColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kprimarycolor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kprimarycolor),
            borderRadius: BorderRadius.circular(12),
          )));

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
