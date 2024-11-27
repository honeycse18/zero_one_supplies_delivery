import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmedOrderNotifyResponse {
  String type;
  ConfirmedOrderNotifyOrder order;

  ConfirmedOrderNotifyResponse({this.type = '', required this.order});

  factory ConfirmedOrderNotifyResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrderNotifyResponse(
      type: APIHelper.getSafeStringValue(json['type']),
      order: ConfirmedOrderNotifyOrder.getAPIResponseObjectSafeValue(
          json['order']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'order': order.toJson(),
      };

  factory ConfirmedOrderNotifyResponse.empty() =>
      ConfirmedOrderNotifyResponse(order: ConfirmedOrderNotifyOrder.empty());

  static ConfirmedOrderNotifyResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderNotifyResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderNotifyResponse.empty();

  ConfirmedOrderNotificationType get notificationType =>
      ConfirmedOrderNotificationType.toEnumValue(type);
}

class ConfirmedOrderNotifyOrder {
  String type;
  bool read;
  String user;
  ConfirmedOrderNotifyOrderNotificationData notificationData;
  String id;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;

  ConfirmedOrderNotifyOrder({
    this.type = '',
    this.read = false,
    this.user = '',
    required this.notificationData,
    this.id = '',
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConfirmedOrderNotifyOrder.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderNotifyOrder(
        type: APIHelper.getSafeStringValue(json['type']),
        read: APIHelper.getSafeBoolValue(json['read']),
        user: APIHelper.getSafeStringValue(json['user']),
        notificationData: ConfirmedOrderNotifyOrderNotificationData
            .getAPIResponseObjectSafeValue(json['notification_data']),
        id: APIHelper.getSafeStringValue(json['_id']),
        expireAt: APIHelper.getSafeDateTimeValue(json['expireAt']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'read': read,
        'user': user,
        'notification_data': notificationData.toJson(),
        '_id': id,
        'expireAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(expireAt),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory ConfirmedOrderNotifyOrder.empty() => ConfirmedOrderNotifyOrder(
      notificationData: ConfirmedOrderNotifyOrderNotificationData(),
      expireAt: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static ConfirmedOrderNotifyOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderNotifyOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderNotifyOrder.empty();
}

class ConfirmedOrderNotifyOrderNotificationData {
  String status;
  String id;
  String orderNumber;

  ConfirmedOrderNotifyOrderNotificationData(
      {this.status = '', this.id = '', this.orderNumber = ''});

  factory ConfirmedOrderNotifyOrderNotificationData.fromJson(
      Map<String, dynamic> json) {
    return ConfirmedOrderNotifyOrderNotificationData(
      status: APIHelper.getSafeStringValue(json['status']),
      id: APIHelper.getSafeStringValue(json['_id']),
      orderNumber: APIHelper.getSafeStringValue(json['order_number']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        '_id': id,
        'order_number': orderNumber,
      };
  static ConfirmedOrderNotifyOrderNotificationData
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? ConfirmedOrderNotifyOrderNotificationData.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : ConfirmedOrderNotifyOrderNotificationData();
}
