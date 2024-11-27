import 'package:ecomikdeliveryapp/models/api_responses/active_status_response.dart';

import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ActiveStatusUpdatedResponse {
  bool error;
  String msg;
  ActiveStatusUpdated data;

  ActiveStatusUpdatedResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ActiveStatusUpdatedResponse.fromJson(Map<String, dynamic> json) {
    return ActiveStatusUpdatedResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ActiveStatusUpdated.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ActiveStatusUpdatedResponse.empty() => ActiveStatusUpdatedResponse(
        data: ActiveStatusUpdated.empty(),
      );
  static ActiveStatusUpdatedResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusUpdatedResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusUpdatedResponse.empty();
}

class ActiveStatusUpdated {
  ActiveStatusDeliveryMan deliveryMan;
  List<ActiveOrder> orders;
  List<ActiveStatusDeliveryItem> deliveryItems;

  ActiveStatusUpdated(
      {required this.deliveryMan,
      this.deliveryItems = const [],
      this.orders = const []});

  factory ActiveStatusUpdated.fromJson(Map<String, dynamic> json) =>
      ActiveStatusUpdated(
        deliveryMan: ActiveStatusDeliveryMan.getAPIResponseObjectSafeValue(
            json['delivery_man']),
        deliveryItems: APIHelper.getSafeListValue(json['delivery_items'])
            .map((e) =>
                ActiveStatusDeliveryItem.getAPIResponseObjectSafeValue(e))
            .toList(),
        orders: APIHelper.getSafeListValue(json['orders'])
            .map((e) => ActiveOrder.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'delivery_man': deliveryMan.toJson(),
        'delivery_items': deliveryItems.map((e) => e.toJson()).toList(),
        'orders': orders.map((e) => e.toJson()).toList(),
      };

  factory ActiveStatusUpdated.empty() =>
      ActiveStatusUpdated(deliveryMan: ActiveStatusDeliveryMan.empty());
  static ActiveStatusUpdated getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusUpdated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusUpdated.empty();
}

class ActiveStatusDeliveryItem {
  String id;
  String pickupStation;
  ActiveStatusDeliveryItemOrder order;
  DeliveryRequest deliveryRequest;

  bool isCompleted;
  String status;
  DateTime createdAt;
  String type;

  ActiveStatusDeliveryItem({
    this.id = '',
    this.pickupStation = '',
    required this.order,
    this.isCompleted = false,
    this.status = '',
    required this.createdAt,
    required this.deliveryRequest,
    this.type = '',
  });

  factory ActiveStatusDeliveryItem.fromJson(Map<String, dynamic> json) =>
      ActiveStatusDeliveryItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        pickupStation: APIHelper.getSafeStringValue(json['pickup_station']),
        order: ActiveStatusDeliveryItemOrder.getAPIResponseObjectSafeValue(
            json['order']),
        isCompleted: APIHelper.getSafeBoolValue(json['isCompleted']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        type: APIHelper.getSafeStringValue(json['type']),
        deliveryRequest: DeliveryRequest.getAPIResponseObjectSafeValue(
            json['delivery_request']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pickup_station': pickupStation,
        'order': order.toJson(),
        'isCompleted': isCompleted,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'type': type,
        'delivery_request': deliveryRequest.toJson(),
      };

  factory ActiveStatusDeliveryItem.empty() => ActiveStatusDeliveryItem(
        deliveryRequest: DeliveryRequest(),
        createdAt: AppComponents.defaultUnsetDateTime,
        order: ActiveStatusDeliveryItemOrder(),
      );
  static ActiveStatusDeliveryItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryItem.empty();

  OrderStatus get statusAsEnum => OrderStatus.toEnumValue(status);
  OrderType get orderType => OrderType.toEnumValue(type);
}

class DeliveryRequest {
  String id;
  String paymentStatus;
  String deliveryNumber;
  String date;
  double total;
  String paymentMethod;

  DeliveryRequest({
    this.id = '',
    this.paymentStatus = '',
    this.date = '',
    this.total = 0,
    this.paymentMethod = '',
    this.deliveryNumber = '',
  });

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      id: APIHelper.getSafeStringValue(json['_id']),
      paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
      deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
      date: APIHelper.getSafeStringValue(json['date']),
      total: APIHelper.getSafeDoubleValue(json['total']),
      paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'payment_status': paymentStatus,
        'delivery_number': deliveryNumber,
        'date': date,
        'total': total,
        'payment_method': paymentMethod,
      };

  static DeliveryRequest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequest();
}

class ActiveStatusDeliveryMan {
  String id;
  ActiveStatusDeliveryManPosition position;
  bool deliveryService;

  ActiveStatusDeliveryMan(
      {this.id = '', required this.position, this.deliveryService = false});

  factory ActiveStatusDeliveryMan.fromJson(Map<String, dynamic> json) =>
      ActiveStatusDeliveryMan(
        id: APIHelper.getSafeStringValue(json['_id']),
        position: ActiveStatusDeliveryManPosition.getAPIResponseObjectSafeValue(
            json['position']),
        deliveryService: APIHelper.getSafeBoolValue(json['delivery_service']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'position': position.toJson(),
        'delivery_service': deliveryService,
      };

  factory ActiveStatusDeliveryMan.empty() =>
      ActiveStatusDeliveryMan(position: ActiveStatusDeliveryManPosition());
  static ActiveStatusDeliveryMan getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryMan.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryMan.empty();
}

class ActiveStatusDeliveryItemOrder {
  String id;
  String orderNumber;
  double total;
  String paymentStatus;
  String paymentMethod;
  int estimatedDeliveryHours;

  ActiveStatusDeliveryItemOrder({
    this.id = '',
    this.orderNumber = '',
    this.total = 0,
    this.paymentStatus = '',
    this.paymentMethod = '',
    this.estimatedDeliveryHours = 0,
  });

  factory ActiveStatusDeliveryItemOrder.fromJson(Map<String, dynamic> json) =>
      ActiveStatusDeliveryItemOrder(
        id: APIHelper.getSafeStringValue(json['_id']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        estimatedDeliveryHours:
            APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order_number': orderNumber,
        'total': total,
        'payment_status': paymentStatus,
        'payment_method': paymentMethod,
        'estimated_delivery_hours': estimatedDeliveryHours,
      };

  static ActiveStatusDeliveryItemOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryItemOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryItemOrder();
}

class ActiveStatusDeliveryManPosition {
  double latitude;
  double longitude;

  ActiveStatusDeliveryManPosition({this.latitude = 0.0, this.longitude = 0.0});

  factory ActiveStatusDeliveryManPosition.fromJson(Map<String, dynamic> json) =>
      ActiveStatusDeliveryManPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static ActiveStatusDeliveryManPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryManPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryManPosition();
}
