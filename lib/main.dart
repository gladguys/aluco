import 'package:alice/alice.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bloc/global_blocs.dart';
import 'theme/main_theme.dart';

SharedPreferences preferences;

Alice alice = Alice(navigatorKey: GlobalKey<NavigatorState>());

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
        home: JWTUtils.userAlreadySignedIn() ? HomeScreen() : SigninScreen(),
      ),
    );
  }
}
