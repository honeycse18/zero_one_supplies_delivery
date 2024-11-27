import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ActiveStatusResponse {
  bool error;
  String msg;
  ActiveStatusData data;

  ActiveStatusResponse({this.error = false, this.msg = '', required this.data});

  factory ActiveStatusResponse.fromJson(Map<String, dynamic> json) {
    return ActiveStatusResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ActiveStatusData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ActiveStatusResponse.empty() =>
      ActiveStatusResponse(data: ActiveStatusData.empty());

  static ActiveStatusResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusResponse.empty();
}

class ActiveStatusData {
  ActiveStatusDeliveryMan deliveryMan;
  List<ActiveOrder> orders;

  ActiveStatusData({required this.deliveryMan, this.orders = const []});

  factory ActiveStatusData.fromJson(Map<String, dynamic> json) =>
      ActiveStatusData(
        deliveryMan: ActiveStatusDeliveryMan.getAPIResponseObjectSafeValue(
            json['delivery_man']),
        orders: APIHelper.getSafeListValue(json['orders'])
            .map((e) => ActiveOrder.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'delivery_man': deliveryMan.toJson(),
        'orders': orders.map((e) => e.toJson()).toList(),
      };

  factory ActiveStatusData.empty() =>
      ActiveStatusData(deliveryMan: ActiveStatusDeliveryMan.empty());

  static ActiveStatusData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusData.empty();
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
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryMan.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryMan.empty();
}

class ActiveStatusDeliveryManPosition {
  double latitude;
  double longitude;

  ActiveStatusDeliveryManPosition({this.latitude = 0, this.longitude = 0});

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
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveStatusDeliveryManPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveStatusDeliveryManPosition();
}

class ActiveOrder {
  String id;
  String pickupStation;
  ActiveOrderOrder order;
  bool isCompleted;
  String status;
  DateTime createdAt;

  ActiveOrder({
    this.id = '',
    this.pickupStation = '',
    required this.order,
    this.isCompleted = false,
    this.status = '',
    required this.createdAt,
  });

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
        id: APIHelper.getSafeStringValue(json['_id']),
        pickupStation: APIHelper.getSafeStringValue(json['pickup_station']),
        order: ActiveOrderOrder.getAPIResponseObjectSafeValue(json['order']),
        isCompleted: APIHelper.getSafeBoolValue(json['isCompleted']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pickup_station': pickupStation,
        'order': order.toJson(),
        'isCompleted': isCompleted,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory ActiveOrder.empty() => ActiveOrder(
      order: ActiveOrderOrder.empty(),
      createdAt: AppComponents.defaultUnsetDateTime);

  static ActiveOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveOrder.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ActiveOrder.empty();

  OrderStatus get statusAsEnum => OrderStatus.toEnumValue(status);
}

class ActiveOrderOrder {
  String id;
  String orderNumber;
  double total;
  ActiveOrderOrderDelivery delivery;
  String paymentStatus;
  String receivedTime;

  ActiveOrderOrder({
    this.id = '',
    this.orderNumber = '',
    this.total = 0,
    required this.delivery,
    this.paymentStatus = '',
    this.receivedTime = '',
  });

  factory ActiveOrderOrder.fromJson(Map<String, dynamic> json) =>
      ActiveOrderOrder(
        id: APIHelper.getSafeStringValue(json['_id']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        delivery: ActiveOrderOrderDelivery.getAPIResponseObjectSafeValue(
            json['delivery']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        receivedTime: APIHelper.getSafeStringValue(json['received_time']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order_number': orderNumber,
        'total': total,
        'delivery': delivery.toJson(),
        'payment_status': paymentStatus,
        'received_time': receivedTime,
      };

  factory ActiveOrderOrder.empty() =>
      ActiveOrderOrder(delivery: ActiveOrderOrderDelivery());

  static ActiveOrderOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveOrderOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveOrderOrder.empty();
}

class ActiveOrderOrderDelivery {
  double distance;
  double perKmFare;
  double fare;

  ActiveOrderOrderDelivery(
      {this.distance = 0, this.perKmFare = 0, this.fare = 0});

  factory ActiveOrderOrderDelivery.fromJson(Map<String, dynamic> json) =>
      ActiveOrderOrderDelivery(
        distance: APIHelper.getSafeDoubleValue(json['distance']),
        perKmFare: APIHelper.getSafeDoubleValue(json['per_km_fare']),
        fare: APIHelper.getSafeDoubleValue(json['fare']),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'per_km_fare': perKmFare,
        'fare': fare,
      };

  static ActiveOrderOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveOrderOrderDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveOrderOrderDelivery();
}
