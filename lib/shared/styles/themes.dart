import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  primarySwatch: Colors.pink,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),

  textTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
    ),
    button: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: Colors.pink,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
  // fontFamily: 'LibreBaskerville',
  textTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
    button: TextStyle(
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
    ),
  ),
);