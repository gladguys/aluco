import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.orange[600],
  primaryColorDark: Colors.orange[800],
  accentColor: Colors.grey[850],
  cursorColor: Colors.orange[600],
  scaffoldBackgroundColor: Colors.orange[600],
  textSelectionColor: Colors.orange[300],
  textSelectionHandleColor: Colors.orange[600],
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
        width: 2.0,
        color: Colors.red[700],
      ),
    ),
  ),
);
