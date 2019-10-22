import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:aluco/screen/signin/signin_screen.dart';
import 'theme/main_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _subscription =  Connectivity().onConnectivityChanged.listen((result) {
    // TODO(rodrigo): create better way to notificate this
    if (result == ConnectivityResult.none) {
      print('sem net');
    } else {
      print('com net');
    }
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SigninScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
