import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.orange[600],
  primaryColorLight: Colors.orange[200],
  primaryColorDark: Colors.orange[800],
  accentColor: Colors.grey[850],
  cursorColor: Colors.orange[600],
  scaffoldBackgroundColor: Colors.grey[200],
  textSelectionColor: Colors.orange[300],
  textSelectionHandleColor: Colors.orange[600],
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    textTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 24.0,
        color: Colors.orange[600],
      ),
    ),
  ),
  fontFamily: 'Ubuntu',
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.orange[800]),
    filled: true,
    fillColor: Colors.white,
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange[600],
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange[600],
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[300],
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.orange[600],
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red[600],
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.red[600],
      ),
    ),
  ),
);
