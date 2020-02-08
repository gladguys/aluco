import 'dart:convert';
import 'dart:math';

import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/repository/api/lesson_plan_repository.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

// ignore: avoid_classes_with_only_static_members
class NotificationService {
  static final _lessonRepository = G<LessonPlanRepository>();
  static final dateFormat = DateFormat('dd/MM/yyyy');

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Random _random;

  static Future<void> setupLocalNotification() async {
    _random = Random();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  static Future<void> _onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
      final lessonPlan = await _lessonRepository.getById(int.parse(payload));
      preferences.setString('lessonPlan', jsonEncode(lessonPlan.toJson()));
      if (JWTUtils.userAlreadySignedIn()) {
        Get.to(HomeScreen(lessonPlan: lessonPlan));
      } else {
        Get.to(SigninScreen());
      }
    }
  }

  static NotificationDetails _getNotificationDetails({
    String channelId = 'ID',
    String channelName = 'NAME',
    String channelDescription = 'DESCRIPTION',
    String groupKey = 'GROUP-KEY',
    Importance importance = Importance.Max,
    Priority priority = Priority.High,
    AndroidNotificationStyle style = AndroidNotificationStyle.Default,
    StyleInformation styleInformation,
  }) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName, channelDescription,
        importance: importance,
        priority: priority,
        groupKey: groupKey,
        style: style,
        styleInformation: styleInformation,
        ticker: 'ticker');

    return NotificationDetails(androidPlatformChannelSpecifics, null);
  }

  static int _getRandomId() {
    return _random.nextInt(50000);
  }

  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<NotificationAppLaunchDetails>
      getNotificationAppLaunchDetails() async {
    return await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<int> showInstantNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );
    final id = _getRandomId();
    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: payload);
    return id;
  }

  static Future<int> showPeriodicNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required RepeatInterval interval,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );
    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, interval, notificationDetails,
        payload: payload);
    return id;
  }

  static Future<int> showDailyNotificationAtTime(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required Time time,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, notificationDetails,
        payload: payload);
    return id;
  }

  static Future<int> showWeeklyNotificationAtTimeAndWeekDay(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required Day day,
      @required Time time,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id, title, body, day, time, notificationDetails);
    return id;
  }

  static Future<int> scheduleNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required int id,
      @required String title,
      String body,
      String payload,
      @required DateTime notificationDate}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, notificationDate, notificationDetails,
        payload: payload, androidAllowWhileIdle: true);
    return id;
  }

  static Future<int> scheduleNotificationWithAsset(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required String title,
      @required String filePath,
      @required DateTime notificationDate,
      String body,
      String payload}) async {
    final styleInfo = BigPictureStyleInformation(
      filePath,
      BitmapSource.FilePath,
      largeIcon: filePath,
      largeIconBitmapSource: BitmapSource.FilePath,
      contentTitle: title,
      htmlFormatContentTitle: false,
      summaryText: body,
      htmlFormatSummaryText: false,
    );

    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      style: AndroidNotificationStyle.BigPicture,
      styleInformation: styleInfo,
    );
    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, notificationDate, notificationDetails,
        payload: payload);
    return id;
  }
}
