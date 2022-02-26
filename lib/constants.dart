import 'package:flutter/material.dart';

const kSecondaryTextColor = Color.fromARGB(255, 164, 164, 164);
const kBackgroundLight = Color(0x1F000000);

var lightThemeData = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Sarabun',
  primarySwatch: Colors.blue,
  dividerColor: Colors.grey,
  shadowColor: Colors.black38,
  backgroundColor: const Color(0xFFdfe1e5),
  canvasColor: Colors.white,
  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.blue,
      onPrimary: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),
    headline2: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Color(0xFF37383B),
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color(0xFF0B214A),
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
    ),
    headline6: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
    bodyText1: TextStyle(
      color: Color(0xFF37383B),
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Color(0xFFadbac7),
    ),
    subtitle1: TextStyle(
      color: Color(0xFFadbac7),
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      color: Color(0xFF768390),
    ),
  ),
);

var darkThemeData = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Sarabun',
  primaryColor: Colors.lime,
  errorColor: Colors.red,
  shadowColor: const Color(0xFF22272e),
  backgroundColor: const Color(0xFF1c2128),
  canvasColor: const Color(0xFF2d333b),
  dividerColor: const Color(0xFF22272e),
  dialogTheme: const DialogTheme(backgroundColor: Color(0xFF22272e)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.lime,
      onPrimary: Colors.black,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color(0xFFadbac7),
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: Color(0xFFadbac7),
    ),
    headline6: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
    bodyText1: TextStyle(
      color: Color(0xFFadbac7),
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      color: Color(0xFFadbac7),
    ),
    subtitle1: TextStyle(
      color: Color(0xFF768390),
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      color: Color(0xFF768390),
    ),
  ),
);

const RestaurantData = {
  'name': 'Sunshine Road',
  'availableOrders': ['Dine In', 'Take Out'],
};
