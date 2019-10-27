import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/main_theme.dart';

SharedPreferences preferences;

Future<void> main() async {
  await initializePreferences();
  runApp(MyApp());
}

Future<void> initializePreferences() async {
  preferences = await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _subscription = Connectivity().onConnectivityChanged.listen((result) {
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
      home: SigninScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
