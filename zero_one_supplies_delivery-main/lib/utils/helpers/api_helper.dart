import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecomikdeliveryapp/models/api_responses/single_image_upload_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/models/exceptions/internet_connection.dart';
import 'package:ecomikdeliveryapp/models/exceptions/response_status_code.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class APIHelper {
  static Future<void> preAPICallCheck() async {
    // Check internet connection
    final bool isConnectedToInternet = await isConnectedInternet();
    if (!isConnectedToInternet) {
      throw InternetConnectionException(message: 'Not connected to internet');
    }
  }

  static bool isResponseStatusCodeIn400(int? statusCode) {
    try {
      return (statusCode! >= 400 && statusCode < 500);
    } catch (e) {
      return false;
    }
  }

  static void postAPICallCheck(Response<dynamic> response) {
    /// Handling wrong response handling
    if (response.statusCode == null) {
      // return null;
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    if (response.statusCode != 200 &&
        !isResponseStatusCodeIn400(response.statusCode)) {
      // return null;
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    // Try setting response as Map
    final dynamic responseBody = response.body;
    if (responseBody == null) {
      throw Exception('responseBody is null');
    }
    if (responseBody is! Map<String, dynamic>) {
      throw const FormatException('Response type is not Map<String, dynamic>');
    }
  }

  static Map<String, String> getAuthHeaderMap() {
    String loggedInUserBearerToken = Helper.getUserBearerToken();
    return {'Authorization': loggedInUserBearerToken};
  }

  static void handleExceptions(Object? exception) {
    /// API error exception of "connection timed out" handling
    if (exception is InternetConnectionException) {
      AppDialogs.showErrorDialog(
          titleText: 'No internet!',
          messageText: 'Please turn on your wifi or mobile data');
    } else if (exception is SocketException) {
      AppDialogs.showErrorDialog(
          titleText: 'Connection failure!',
          messageText: 'Something went wrong');
    } else if (exception is FormatException) {
      AppDialogs.showErrorDialog(messageText: 'Something went wrong');
    } else {
      AppDialogs.showErrorDialog(messageText: 'Something went wrong');
    }
  }

  static String getSafeStringValue(Object? unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeListValue<T>(Object? unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static DateTime getSafeDateTimeValue(
      Object? unsafeResponseDateTimeStringValue,
      {String dateTimePattern = '',
      bool toLocal = false}) {
    final DateTime defaultDateTime = AppComponents.defaultUnsetDateTime;
    final String safeDateTimeStringValue =
        getSafeStringValue(unsafeResponseDateTimeStringValue);
    return getDateTimeFromServerDateTimeString(safeDateTimeStringValue,
            dateTimePattern: dateTimePattern, toLocal: toLocal) ??
        defaultDateTime;
  }

  static int getSafeIntValue(Object? unsafeResponseIntValue,
      [int defaultIntValue = -1]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      // Now it is safe
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDoubleValue(Object? unsafeResponseDoubleValue,
      [double defaultDoubleValue = -1]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      // Now it is safe
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBoolValue(Object? unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (GetUtils.isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      // Now it is safe
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static DateTime? getDateTimeFromServerDateTimeString(String dateTimeString,
      {String dateTimePattern = '', bool toLocal = false}) {
    try {
      if (dateTimePattern.isNotEmpty) {
        return DateFormat(dateTimePattern)
            .parse(dateTimeString, !toLocal)
            .toLocal();
      }
      return AppComponents.apiDateTimeFormat
          .parse(dateTimeString, !toLocal)
          .toLocal();
    } catch (e) {
      return null;
    }
  }

  static String toServerDateTimeFormattedStringFromDateTime(DateTime dateTime,
      {bool toLocal = false}) {
    return AppComponents.apiDateTimeFormat
        .format(toLocal ? dateTime : dateTime.toUtc());
  }

/* 
  static APIResponseObject getSafeResponseObject(Object? unsafeResponseValue) {
    final APIResponseObject defaultValue = APIResponseObject();
    if (unsafeResponseValue == null) {
      return defaultValue;
    } else if (unsafeResponseValue is Map<String, dynamic>) {
      // Now it is safe
      return APIResponseObject.fromJson(unsafeResponseValue);
    }
    return defaultValue;
  }
 */
  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }

  static Future<bool> isConnectedInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
  }

  static void onError(String? message, [String? title]) {
    if (message == null) {
      return;
    }
    onFailure(message, title);
  }

  static void onFailure(String message, [String? title]) {}

  static void uploadSingleImage(
      Uint8List imageByte,
      void Function(SingleImageUploadResponse, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      {String imageFileName = '',
      String id = '',
      required Map<String, dynamic> additionalData,
      required String token}) async {
    final File imageFile = await Helper.getTempFileFromImageBytes(imageByte);
    AppDialogs.showProcessingDialog(message: 'Image is uploading');
    SingleImageUploadResponse? response = await APIRepo.uploadImage(imageFile,
        imageFileName: imageFileName, id: id, token: token);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    try {
      await imageFile.delete();
    } catch (e) {}
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson()).toString());
    onSuccessUploadSingleImage(response, additionalData);
  }

  static Future<void> deleteImageFile(File imageFile) async {
    try {
      await imageFile.delete();
    } catch (e) {}
  }

  static Future<void> getSiteSettings() async {
    SiteSettingsResponse? response = await APIRepo.getSiteSettings();
    if (response == null) {
      _onErrorGetSiteSettings(response);
      return;
    } else if (response.error) {
      _onFailureGetSiteSettings(response);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetSiteSettings(response);
  }

  static void _onErrorGetSiteSettings(SiteSettingsResponse? response) {
    APIHelper.onError(response?.msg);
  }

  static void _onFailureGetSiteSettings(SiteSettingsResponse response) {
    APIHelper.onFailure(response.msg);
  }

  static void _onSuccessGetSiteSettings(SiteSettingsResponse response) {
    AppSingleton.instance.settings = response.data;
  }
}
