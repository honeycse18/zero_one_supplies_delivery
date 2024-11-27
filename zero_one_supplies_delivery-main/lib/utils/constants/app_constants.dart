import 'package:ecomikdeliveryapp/utils/constants/app_secrets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// This is a Barrel file containing custom configurations of this app. Import
/// this one file to import all the files from below.
export 'app_colors.dart';
export 'app_components.dart';
export 'app_gaps.dart';
export 'app_images.dart';

class Constants {
  static const String appLiveBaseURL =
      'https://backend.01supplies.com/'; // Live backend
  // static const String appLiveBaseURL = 'https://devbackend.01supplies.com/'; // Dev backend
  static const String appLocalhostBaseURL =
      'http://192.168.0.141:8080/'; // Local computer from office
  static const bool isTestOnLocalhost = false;
  static const String appBaseURL =
      isTestOnLocalhost ? appLocalhostBaseURL : appLiveBaseURL;

  static const String googleAPIKey = AppSecrets.googleAPIKey;

  static const String notificationChannelID = '01suppliesDelivery';
  static const String notificationChannelName =
      '01Supplies Delivery Notifications';
  static const String notificationChannelDescription =
      '01 Supplies Delivery app notification channel';
  static const String notificationChannelTicker = 'zeroonedeliveryticker';

  static const int defaultUnsetDateTimeYear = 2000;
  static const double unsetMapLatLng = -999;

  static const String apiDateTimeFormatValue =
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const double bottomSheetBorderRadiusValue = 40;
  static const double dialogBorderRadiusValue = 20;
  static const double buttonBorderRadiusValue = 18;
  // Dialog padding values
  static const double dialogVerticalSpaceValue = 16;
  static const double dialogHalfVerticalSpaceValue = 8;
  static const double dialogHorizontalSpaceValue = 18;
  static const double imageBorderRadiusValue = 14;
  static const double smallBorderRadiusValue = 5;

  /// Screen horizontal padding value
  static const double screenPaddingValue = 24;
  static const double bottomScreenSpaceValue = 30;
  static const double bottomSheetTopPaddingValue = 24;
  static const double auctionGridItemBorderRadiusValue = 20;
  static const double uploadImageButtonBorderRadiusValue = 12;
  static const double defaultBorderRadiusValue = 18;
  static const String userRoleDelivery = 'delivery';
  static const LatLng defaultMapLatLng = LatLng(8.662471152081386,
      1.0180393971192057); // Togo country center map location
  static const double unsetLatLngValue = -999;
  static const CameraPosition defaultMapCameraPosition = CameraPosition(
    target: defaultMapLatLng,
    zoom: defaultMapZoomLevel,
  );
  static const double defaultMapZoomLevel = 12.4746;

  static const String orderStatusPending = 'pending';
  static const String orderStatusApproved = 'approved';
  static const String orderStatusAccepted = 'accepted';
  static const String orderStatusRejected = 'rejected';
  static const String orderStatusPicked = 'picked';
  static const String orderStatusOnWay = 'on_way';
  static const String orderStatusDelivered = 'delivered';

  static const String paymentMethodCashOnDelivery = 'cash_on_delivery';
  static const String paymentMethodStripe = 'stripe';
  static const String paymentMethodPaypal = 'paypal';

  static const String confirmedOrderNotifyTypeConfirmOrder =
      'confirm_order_notify';

  // Push notification types
  static const String pushNotificationTypeConfirmOrder = 'confirm_order';

  static const String orderTypeProductOrder = 'product_order';
  static const String orderTypeDeliveryRequest = 'delivery_request';

  static const String unknown = 'unknown';

  static const String hiveBoxName = 'zero_one_supplies_delivery';
  static const String hiveDefaultLanguageKey = 'default_language';
  static const String languageTranslationKeyCode = '_code';
  static const String fallbackLocale = 'en_US';
  static const String fallbackFrenchLocale = 'fr_FR';

  static const String otpOptionEmail = 'email';
  static const String otpOptionSMS = 'sms';
}
