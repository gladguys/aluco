import 'package:alice/alice.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/global_blocs.dart';
import 'core/error/errors.dart';
import 'core/locator/locator.dart';
import 'core/notification/notification_service.dart';
import 'core/utils/jwt_utils.dart';
import 'screen/home/home_screen.dart';
import 'screen/signin/signin_screen.dart';
import 'theme/main_theme.dart';

SharedPreferences preferences;

Alice alice =
    Alice(navigatorKey: Catcher.navigatorKey, showNotification: false);

NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  Get.key = Catcher.navigatorKey;
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.setupLocalNotification();
  await initializePreferences();
  setupLocator();
  notificationAppLaunchDetails =
      await NotificationService.getNotificationAppLaunchDetails();
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

Future<void> initializePreferences() async {
  preferences = await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: getHomeWidget(),
      ),
    );
  }

  Widget getHomeWidget() {
    if (JWTUtils.userAlreadySignedIn()) {
      return const HomeScreen();
    } else {
      return SigninScreen();
    }
  }
}
