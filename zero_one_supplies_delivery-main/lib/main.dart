import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/utils/app_notification_service.dart';
import 'package:ecomikdeliveryapp/utils/app_pages.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  await AppSingleton.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationService.initialize();
  FirebaseMessaging.onMessage.listen(_onForegroundHandler);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
  runApp(const ZeroOneParcelsApp());
}

Future<void> _onForegroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

Future<void> _onBackgroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

class ZeroOneParcelsApp extends StatelessWidget {
  const ZeroOneParcelsApp({super.key});

  // This widget is the root of this app.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '01 Parcels',
      getPages: AppPages.pages,
      // onGenerateRoute: AppRouteGenerator.generateRoute,
      unknownRoute: AppPages.unknownScreenPageRoute,
      initialRoute: AppPageNames.rootScreen,
      theme: AppThemeData.appThemeData,
    );
  }
}
