import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.orange[600],
  primaryColorDark: Colors.orange[800],
  accentColor: Colors.grey[850],
  cursorColor: Colors.orange[600],
  scaffoldBackgroundColor: Colors.white,
  textSelectionColor: Colors.orange[300],
  textSelectionHandleColor: Colors.orange[600],
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
    fillColor: Colors.grey[100],
    border: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Colors.orange[600],
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Colors.orange[600],
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Colors.grey[300],
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Colors.orange[600],
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Colors.red[600],
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: Colors.red[700],
      ),
    ),
  ),
);
