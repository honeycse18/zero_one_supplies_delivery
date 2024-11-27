/* <-------- Enums for various screens --------> */

import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';

enum ResetPasswordSelectedChoice {
  none,
  mail,
  phoneNumber,
}

enum PasswordStrongLevel {
  none,
  error,
  weak,
  normal,
  strong,
  veryStrong,
}

enum FromScreenName {
  signupScreen,
  googleSignupScreen,
  resetOrForgetPassScreen,
  vendorScreen,
  homeScreen;
}

enum LanguageSetting { english, russian, french, canada, australian, german }

enum CountrySetting { usa, russian, french, canada, australian, german }

enum CurrencySetting { usa, russian, bdt, canada, australian, german }

enum HomeScreenStatus { offline, online, orderList, currentOrderDetails }

enum OrderStatus {
  pending(Constants.orderStatusPending, 'Pending'),
  approved(Constants.orderStatusApproved, 'Approved'),
  accepted(Constants.orderStatusAccepted, 'Accepted'),
  rejected(Constants.orderStatusRejected, 'Rejected'),
  picked(Constants.orderStatusPicked, 'Picked'),
  onWay(Constants.orderStatusOnWay, 'On the way'),
  delivered(Constants.orderStatusDelivered, 'Delivered'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const OrderStatus(this.stringValue, this.viewableText);

  static OrderStatus toEnumValue(String value) {
    final Map<String, OrderStatus> stringToEnumMap = {
      OrderStatus.pending.stringValue: OrderStatus.pending,
      OrderStatus.approved.stringValue: OrderStatus.approved,
      OrderStatus.accepted.stringValue: OrderStatus.accepted,
      OrderStatus.rejected.stringValue: OrderStatus.rejected,
      OrderStatus.picked.stringValue: OrderStatus.picked,
      OrderStatus.onWay.stringValue: OrderStatus.onWay,
      OrderStatus.delivered.stringValue: OrderStatus.delivered,
      OrderStatus.unknown.stringValue: OrderStatus.unknown,
    };
    return stringToEnumMap[value] ?? OrderStatus.unknown;
  }
}

enum ConfirmedOrderNotificationType {
  confirmOrder(Constants.confirmedOrderNotifyTypeConfirmOrder),
  unknown(Constants.unknown);

  final String stringValue;
  const ConfirmedOrderNotificationType(this.stringValue);

  static ConfirmedOrderNotificationType toEnumValue(String value) {
    final Map<String, ConfirmedOrderNotificationType> stringToEnumMap = {
      ConfirmedOrderNotificationType.confirmOrder.stringValue:
          ConfirmedOrderNotificationType.confirmOrder,
      ConfirmedOrderNotificationType.unknown.stringValue:
          ConfirmedOrderNotificationType.unknown,
    };
    return stringToEnumMap[value] ?? ConfirmedOrderNotificationType.unknown;
  }
}

enum PaymentMethodName {
  cashOnDelivery(Constants.paymentMethodCashOnDelivery, 'Cash on delivery'),
  stripe(Constants.paymentMethodStripe, 'Stripe'),
  paypal(Constants.paymentMethodPaypal, 'Paypal'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const PaymentMethodName(this.stringValue, this.viewableText);

  static PaymentMethodName toEnumValue(String value) {
    final Map<String, PaymentMethodName> stringToEnumMap = {
      PaymentMethodName.cashOnDelivery.stringValue:
          PaymentMethodName.cashOnDelivery,
      PaymentMethodName.stripe.stringValue: PaymentMethodName.stripe,
      PaymentMethodName.paypal.stringValue: PaymentMethodName.paypal,
      PaymentMethodName.unknown.stringValue: PaymentMethodName.unknown,
    };
    return stringToEnumMap[value] ?? PaymentMethodName.unknown;
  }
}

enum SettingsOTPOption {
  email(Constants.otpOptionEmail, 'Email'),
  sms(Constants.otpOptionSMS, 'SMS'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const SettingsOTPOption(this.stringValue, this.stringValueForView);

  static SettingsOTPOption toEnumValue(String value) {
    final Map<String, SettingsOTPOption> stringToEnumMap = {
      SettingsOTPOption.email.stringValue: SettingsOTPOption.email,
      SettingsOTPOption.sms.stringValue: SettingsOTPOption.sms,
      SettingsOTPOption.unknown.stringValue: SettingsOTPOption.unknown,
    };
    return stringToEnumMap[value] ?? SettingsOTPOption.unknown;
  }
}

enum PushNotificationTypeStatus {
  confirmOrder(Constants.pushNotificationTypeConfirmOrder, 'Confirm order'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const PushNotificationTypeStatus(this.stringValue, this.stringValueForView);

  static PushNotificationTypeStatus toEnumValue(String value) {
    final Map<String, PushNotificationTypeStatus> stringToEnumMap = {
      PushNotificationTypeStatus.confirmOrder.stringValue:
          PushNotificationTypeStatus.confirmOrder,
    };
    return stringToEnumMap[value] ?? PushNotificationTypeStatus.unknown;
  }

  static PushNotificationTypeStatus toEnumValueFromViewable(String value) {
    final Map<String, PushNotificationTypeStatus> stringToEnumMap = {
      PushNotificationTypeStatus.confirmOrder.stringValueForView:
          PushNotificationTypeStatus.confirmOrder,
    };
    return stringToEnumMap[value] ?? PushNotificationTypeStatus.unknown;
  }
}

enum ProductLocation {
  none(-1, '', ''),
  store(1, 'store', 'Store'),
  pickupStations(2, 'replay_point', 'Pickup station');

  final int selectionIndex;
  final String type;
  final String viewableText;
  const ProductLocation(this.selectionIndex, this.type, this.viewableText);

  static ProductLocation get defaultValue => ProductLocation.none;

  static List<ProductLocation> get list => [store, pickupStations];

  static ProductLocation indexToEnumValue(int selectionIndex) {
    final Map<int, ProductLocation> stringToEnumMap = {
      ProductLocation.store.selectionIndex: ProductLocation.store,
      ProductLocation.pickupStations.selectionIndex:
          ProductLocation.pickupStations,
    };
    return stringToEnumMap[selectionIndex] ?? defaultValue;
  }

  static ProductLocation typeToEnumValue(String type) {
    final Map<String, ProductLocation> stringToEnumMap = {
      ProductLocation.store.type: ProductLocation.store,
      ProductLocation.pickupStations.type: ProductLocation.pickupStations,
    };
    return stringToEnumMap[type] ?? defaultValue;
  }
}

enum OrderType {
  productOrder(Constants.orderTypeProductOrder, 'Product order'),
  deliveryRequest(Constants.orderTypeDeliveryRequest, 'Delivery request'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const OrderType(this.stringValue, this.viewableText);

  static OrderType get defaultValue => OrderType.unknown;

  static OrderType toEnumValue(String value) {
    final Map<String, OrderType> stringToEnumMap = {
      OrderType.productOrder.stringValue: OrderType.productOrder,
      OrderType.deliveryRequest.stringValue: OrderType.deliveryRequest,
      OrderType.unknown.stringValue: OrderType.unknown,
    };
    return stringToEnumMap[value] ?? OrderType.defaultValue;
  }
}
