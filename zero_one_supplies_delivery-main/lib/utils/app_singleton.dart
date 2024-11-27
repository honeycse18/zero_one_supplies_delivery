import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSingleton {
  static AppSingleton? _instance;
  SiteSettings settings = SiteSettings.empty();
  CameraPosition defaultCameraPosition = Constants.defaultMapCameraPosition;
  late Box localBox;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
          Constants.notificationChannelID, Constants.notificationChannelName,
          channelDescription: Constants.notificationChannelDescription,
          importance: Importance.max,
          priority: Priority.max,
          ticker: Constants.notificationChannelTicker);

  AppSingleton._();

  static void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      log('notification payload: $payload');
    }
    // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  }

  static void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      log('background notification payload: $payload');
    }
    // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  }

  void _initializeLocalNotification() async {
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        // AndroidInitializationSettings('app_icon');
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings( onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse);
  }

  Future<void> initialize() async {
    localBox = await Hive.openBox(Constants.hiveBoxName);
    // _initializeLocalNotification();
    await FlutterDownloader.initialize(
        debug:
            true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
  }

  static AppSingleton get instance => _instance ??= AppSingleton._();
}
