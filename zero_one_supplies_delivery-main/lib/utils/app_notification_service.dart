import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  // static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      AppSingleton.instance.flutterLocalNotificationsPlugin;

  static Future<bool?> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/launcher_icon'));
    // android: AndroidInitializationSettings('notification'));
    return await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            _onForegroundNotificationTap,
        onDidReceiveNotificationResponse: _onBackgroundNotificationTap);
  }

  static void _onForegroundNotificationTap(
      NotificationResponse notificationResponse) {
    // _onNotificationTap(notificationResponse);
  }

  static void _onBackgroundNotificationTap(
      NotificationResponse notificationResponse) {
    // _onNotificationTap(notificationResponse);
  }

  static void _onNotificationTap(NotificationResponse notificationResponse) {
    log(notificationResponse.payload.toString());
    if (notificationResponse.payload == null) {
      return;
    }
    try {
      final payloadAsMap = jsonDecode(notificationResponse.payload!);
      if (payloadAsMap is! Map) {
        return;
      }
      const String payloadTypeMapKeyName = 'type';
      final PushNotificationTypeStatus type =
          PushNotificationTypeStatus.toEnumValue(
              payloadAsMap[payloadTypeMapKeyName]);
      if (type == PushNotificationTypeStatus.confirmOrder) {
        Get.toNamed(AppPageNames.homeScreen);
      }
    } catch (e) {
      return;
    }
  }
}
