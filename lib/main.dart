import 'package:alice/alice.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/global_blocs.dart';
import 'screen/landing_screen.dart';
import 'theme/main_theme.dart';

SharedPreferences preferences;

Alice alice = Alice(navigatorKey: Get.key);

Future<void> main() async {
  await initializePreferences();
  runApp(MyApp());
}

Future<void> initializePreferences() async {
  preferences = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: globalBlocs,
      child: MaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('pt', 'BR'),
        ],
        home: LandingScreen(),
      ),
    );
  }
}
