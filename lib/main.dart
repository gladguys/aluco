import 'package:flutter/material.dart';

import 'package:aluco/screen/signin/signin_screen.dart';
import 'theme/main_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SigninScreen(),
    );
  }
}
