import 'package:flutter/material.dart';

import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:simple_router/simple_router.dart';
import 'config/router.dart';
import 'theme/main_theme.dart';

void main() {
  setupRouter();
  runApp(MyApp());
}

final router = SimpleRouter();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: SimpleRouter.getKey(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SigninScreen(),
    );
  }
}
