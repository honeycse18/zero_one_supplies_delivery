import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/single_image_upload_response.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_local_stored_keys.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/image_picker_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
export 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    show StorageDirectory;

PathProviderPlatform get _platform => PathProviderPlatform.instance;

/// This file contains helper functions and properties
class Helper {
  static void select1ItemFromList(
      int listLength, int selectionIndex, Function(int, bool) doSelectOnIndex) {
    List.generate(listLength,
            (int booleanDataIndex) => booleanDataIndex == selectionIndex)
        .forEachIndexed((int dataIndex, bool booleanData) =>
            doSelectOnIndex(dataIndex, booleanData));
  }

  static Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  static NumberFormat get _currentNumberFormat {
    try {
      return NumberFormat.currency(
          locale: Constants.fallbackFrenchLocale,
          symbol: AppSingleton.instance.settings.currencySymbol);
    } catch (e) {
      return NumberFormat.currency(
          locale: Constants.fallbackLocale,
          symbol: AppSingleton.instance.settings.currencySymbol);
    }
  }

  /// Return default currency formatted text as string. Example: 45000 will
  /// return as $45,000
  static String getCurrencyFormattedAmountText(double amount) {
    return _currentNumberFormat.format(amount);
  }

  static String getFirstSafeString(List<String> images) {
    return images.firstOrNull ?? '';
  }

  static double getAvailableScreenHeightForBottomSheet(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    final double topUnavailableSpaceValue = MediaQuery.of(context).padding.top;
    final double topAvailableSpaceValue =
        screenSize.height - topUnavailableSpaceValue;
    return topAvailableSpaceValue;
  }

  static String getUserToken() {
    dynamic userToken =
        GetStorage().read(LocalStoredKeyName.loggedInDeliveryToken);
    if (userToken is! String) {
      return '';
    }
    return userToken;
  }

  static Future<void> setLoggedInUserToLocalStorage(
      DeliveryManDataResponse userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String vendorDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDelivery, vendorDetailsJson);
  }

  static DeliveryManDataResponse getUser() {
    dynamic loggedInUserJsonString =
        GetStorage().read(LocalStoredKeyName.loggedInDelivery);
    if (loggedInUserJsonString is! String) {
      return DeliveryManDataResponse.empty();
    }
    dynamic loggedInUserJson = jsonDecode(loggedInUserJsonString);
/*     if (loggedInUserJson is! Map<String, dynamic>) {
      return UserDetails.empty();
    } */
    return DeliveryManDataResponse.getAPIResponseObjectSafeValue(
        loggedInUserJson);
  }

  static void logout() async {
    final String? fcmToken = await getFCMToken;
    final Map<String, Object> logoutRequestBody = {
      'user_id': getUser().id,
      'fcm_token': fcmToken ?? '',
    };
    String logoutRequestBodyJson = jsonEncode(logoutRequestBody);
    final logoutResponse = await APIRepo.logout(logoutRequestBodyJson);
    if (logoutResponse == null) {
      APIHelper.onError(logoutResponse?.msg);
    } else if (logoutResponse.error) {
      APIHelper.onFailure(logoutResponse.msg);
    }
    GetStorage().write(LocalStoredKeyName.loggedInDeliveryToken, null);
    GetStorage().write(LocalStoredKeyName.loggedInDelivery, null);
    await AppSingleton.instance.localBox.clear();

    Get.offAllNamed(AppPageNames.signInScreen);
  }

  static String getUserBearerToken() {
    String loggedInUserToken = getUserToken();
    return 'Bearer $loggedInUserToken';
  }

  static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty || (!getUser().isEmpty()));
  }

  static bool isRememberedMe() {
    final dynamic isRememberedMe =
        GetStorage().read(LocalStoredKeyName.rememberMe);
    if (isRememberedMe is bool) {
      return isRememberedMe;
    }
    return false;
  }

  static String? passwordFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return 'Password can not be empty';
      }
      if (text.length < 6) {
        return 'Minimum length 6';
      }
      if (!text.contains(RegExp(r'[0-9]'))) {
        return 'Must contain a digit';
      }
    }
    return null;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> getGPSLocationData() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        AppDialogs.showErrorDialog(
            messageText: 'Location services are disabled. Please turn on GPS');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          AppDialogs.showErrorDialog(
              messageText:
                  'Location permissions are denied. Please try again to permit location access');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        AppDialogs.showErrorDialog(
            messageText:
                'Location permissions are permanently denied, we cannot request permissions. You can permit location by going on app settings.');
        return null;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  /// Generate Material color
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _generateTintColor(color, 0.9),
      100: _generateTintColor(color, 0.8),
      200: _generateTintColor(color, 0.6),
      300: _generateTintColor(color, 0.4),
      400: _generateTintColor(color, 0.2),
      500: color,
      600: _generateShadeColor(color, 0.1),
      700: _generateShadeColor(color, 0.2),
      800: _generateShadeColor(color, 0.3),
      900: _generateShadeColor(color, 0.4),
    });
  }

  // Helper functions for above function
  static int _generateTintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
      _generateTintValue(color.red, factor),
      _generateTintValue(color.green, factor),
      _generateTintValue(color.blue, factor),
      1);

  static int _generateShadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color _generateShadeColor(Color color, double factor) =>
      Color.fromRGBO(
          _generateShadeValue(color.red, factor),
          _generateShadeValue(color.green, factor),
          _generateShadeValue(color.blue, factor),
          1);

  static void showSnackBar(String message) {
    BuildContext? context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static Future<Placemark?> getAddressDetails(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      return placemarks.firstOrNull;
    } catch (e) {
      return null;
    }
  }

  static String getAddressDetailsText(Placemark placemark) {
    String addressText = '';
    if (placemark.name != null && (placemark.name?.isNotEmpty ?? false)) {
      addressText += '${placemark.name}, ';
    }
    if (placemark.subLocality != null &&
        (placemark.subLocality?.isNotEmpty ?? false)) {
      addressText += '${placemark.subLocality}, ';
    }
    if (placemark.administrativeArea != null &&
        (placemark.administrativeArea?.isNotEmpty ?? false)) {
      addressText += '${placemark.administrativeArea}, ';
    }
    if (placemark.postalCode != null &&
        (placemark.postalCode?.isNotEmpty ?? false)) {
      addressText += '${placemark.postalCode}, ';
    }
    if (placemark.country != null && (placemark.country?.isNotEmpty ?? false)) {
      addressText += '${placemark.country}';
    }
    return addressText;
  }

  static Color getColor(String hexCode) {
    final hexColor = hexCode.replaceFirst('#', '');
    return Color((int.tryParse(hexColor, radix: 16) ?? 0) + 0xFF000000);
  }

  static String ddMMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy').format(dateTime);

  static String hhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);
  static int dateTimeDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime.now())
        .inDays;
  }

  /// Returns if today, true
  static bool isToday(DateTime date) {
    return dateTimeDifferenceInDays(date) == 0;
  }

  /// Returns if tomorrow, true
  static bool isTomorrow(DateTime date) {
    return dateTimeDifferenceInDays(date) == 1;
  }

  /// Returns if yesterday, true
  static bool wasYesterday(DateTime date) {
    return dateTimeDifferenceInDays(date) == -1;
  }

  static int getRandom6DigitGeneratedNumber() {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    double next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  static Future<File> getTempFileFromImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${getRandom6DigitGeneratedNumber()}.jpg')
            .create();
    return file.writeAsBytes(imageBytes);
  }

  static void pickImage(
      {String imageName = '',
      required void Function(SingleImageUploadResponse, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final image_picker.XFile? pickedImage =
        await ImagePickerHelper.getPhoneImage();
    if (pickedImage == null) {
      return;
    }
    processPickedImage(pickedImage,
        onSuccessUploadSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static void pickImageForLocal(
      {required void Function(Uint8List, Map<String, dynamic>)
          onSuccessProcessSingleImage,
      Map<String, dynamic> additionalData = const {}}) async {
    final image_picker.XFile? pickedImage =
        await ImagePickerHelper.getPhoneImage();
    if (pickedImage == null) {
      return;
    }
    processPickedImageForLocal(pickedImage,
        onSuccessProcessSingleImage: onSuccessProcessSingleImage,
        additionalData: additionalData);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static void processPickedImage(image_picker.XFile pickedImage,
      {required void Function(SingleImageUploadResponse, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    Uint8List? processedImage =
        await ImagePickerHelper.getProcessedImage(pickedImage);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    if (processedImage == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    }
    final String messageText = imageName.isEmpty
        ? 'Are you sure to set this image?'
        : 'Are you sure to set this image as $imageName?';
    Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    );
    if (confirmResponse is bool && confirmResponse) {
      String imageFileName = '';
      String id = '';
      APIHelper.uploadSingleImage(processedImage, onSuccessUploadSingleImage,
          imageFileName: imageFileName,
          id: id,
          token: token,
          additionalData: additionalData);
    }
  }

  static void processPickedImageForLocal(image_picker.XFile pickedImage,
      {required void Function(Uint8List, Map<String, dynamic>)
          onSuccessProcessSingleImage,
      required Map<String, dynamic> additionalData}) async {
    Uint8List? processedImage =
        await ImagePickerHelper.getProcessedImage(pickedImage);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    if (processedImage == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    }
    onSuccessProcessSingleImage(processedImage, additionalData);
  }

  static Future<void> showNotification(
      {required String title, required String message, String? payload}) async {
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AppSingleton.instance.androidNotificationDetails);
    await AppSingleton.instance.flutterLocalNotificationsPlugin.show(
        generateNotificationID, title, message, notificationDetails,
        payload: payload);
  }

  static void scrollToStart(ScrollController scrollController) {
    if (scrollController.hasClients && !scrollController.position.outOfRange) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  static String avatar2LetterUsername(String firstName, String lastName) {
    if (lastName.isEmpty) {
      if (firstName.isEmpty) {
        return '';
      }
      final firstCharacter = firstName.characters.first;
      final secondCharacter = firstName.characters.length >= 2
          ? firstName.characters.elementAt(1)
          : '';
      return '$firstCharacter$secondCharacter';
    }
    if (firstName.isEmpty) {
      return '';
    }
    final firstCharacter = firstName.characters.first;
    final secondCharacter = lastName.characters.first;
    return '$firstCharacter$secondCharacter';
  }

  static Future<String?> get getFCMToken async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  static int get generateNotificationID {
    final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return id;
  }

  static Future<bool?> setNotificationPermission() async {
    return await AppSingleton.instance.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<T?> exitApp<T>() async {
    return await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static Future<bool> openBrowser(String url) async {
    try {
      return await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication);
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }

  static Future<bool> isFileExists(String filePath) async {
    try {
      return await File(filePath).exists();
    } catch (e) {
      return false;
    }
  }

  static Future<void> launchDefaultBrowserUrl(
      {required String url, BuildContext? context}) async {
    try {
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
        if (context != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Could not launch $url')));
        }
      }
    } catch (e) {}
  }

  static String getFileExtensionFromURL(String url) {
    final regexp = RegExp(r'\.\w+($|\?)', caseSensitive: false);
    final matches = regexp.allMatches(url);
    if (matches.isEmpty) {
      return '';
    }
    String foundExtension = matches.last.group(0) ?? '';
    if (foundExtension.isEmpty) {
      return foundExtension;
    }
    foundExtension = foundExtension.replaceFirst('.', '');
    foundExtension = foundExtension.replaceFirst('?', '');
    return foundExtension;
  }

  static bool isImageFileURL(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
    final regexp = RegExp(
        r'(http(s?):)([/|.|\w|\s|-])*\.(?:' + imageExtensions.join('|') + ')');
    return regexp.hasMatch(url);
  }

  static Future<bool> checkFileDownloadPermission() async {
    try {
      if (Platform.isIOS) {
        return true;
      }

      if (Platform.isAndroid) {
        final info = await DeviceInfoPlugin().androidInfo;
        if (info.version.sdkInt > 28) {
          return true;
        }

        final status = await Permission.storage.status;
        if (status == PermissionStatus.granted) {
          return true;
        }

        final result = await Permission.storage.request();
        return result == PermissionStatus.granted;
      }

      throw StateError('Unknown platform');
    } catch (e) {
      return false;
    }
  }
}
