import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: Colors.white),
        backgroundColor: Colors.white,
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black))),
    AppTheme.darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.black),
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
            bodyText1: TextStyle(
          color: Colors.white,
        )))
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
