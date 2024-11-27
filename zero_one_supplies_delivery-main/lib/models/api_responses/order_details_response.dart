import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class OrderDetailsResponse {
  bool error;
  String msg;
  OrderDetails data;

  OrderDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: OrderDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory OrderDetailsResponse.empty() =>
      OrderDetailsResponse(data: OrderDetails.empty());

  static OrderDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsResponse.empty();
}

class OrderDetails {
  String id;
  OrderDetailsOrder order;
  String status;
  OrderDetailsPickupPosition pickupPosition;
  OrderDetailsUserPosition userPosition;
  OrderDetailsDeliveryMan deliveryMan;

  OrderDetails({
    this.id = '',
    required this.order,
    this.status = '',
    required this.pickupPosition,
    required this.userPosition,
    required this.deliveryMan,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        order: OrderDetailsOrder.getAPIResponseObjectSafeValue(json['order']),
        status: APIHelper.getSafeStringValue(json['status']),
        pickupPosition:
            OrderDetailsPickupPosition.getAPIResponseObjectSafeValue(
                json['pickup_position']),
        userPosition: OrderDetailsUserPosition.getAPIResponseObjectSafeValue(
            json['user_position']),
        deliveryMan: OrderDetailsDeliveryMan.getAPIResponseObjectSafeValue(
            json['delivery_man']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order': order.toJson(),
        'status': status,
        'pickup_position': pickupPosition.toJson(),
        'user_position': userPosition.toJson(),
        'delivery_man': deliveryMan.toJson(),
      };

  factory OrderDetails.empty() => OrderDetails(
      order: OrderDetailsOrder.empty(),
      pickupPosition: OrderDetailsPickupPosition(),
      userPosition: OrderDetailsUserPosition(),
      deliveryMan: OrderDetailsDeliveryMan.empty());

  static OrderDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : OrderDetails.empty();
}

class OrderDetailsDeliveryMan {
  OrderDetailsDeliveryManPosition position;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  bool deliveryService;

  OrderDetailsDeliveryMan({
    required this.position,
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.deliveryService = false,
  });

  factory OrderDetailsDeliveryMan.fromJson(Map<String, dynamic> json) =>
      OrderDetailsDeliveryMan(
        position: OrderDetailsDeliveryManPosition.getAPIResponseObjectSafeValue(
            json['position']),
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        deliveryService: APIHelper.getSafeBoolValue(json['delivery_service']),
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'delivery_service': deliveryService,
      };

  factory OrderDetailsDeliveryMan.empty() =>
      OrderDetailsDeliveryMan(position: OrderDetailsDeliveryManPosition());

  static OrderDetailsDeliveryMan getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsDeliveryMan.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsDeliveryMan.empty();
}

class OrderDetailsDeliveryManPosition {
  double latitude;
  double longitude;

  OrderDetailsDeliveryManPosition({this.latitude = 0, this.longitude = 0});

  factory OrderDetailsDeliveryManPosition.fromJson(Map<String, dynamic> json) =>
      OrderDetailsDeliveryManPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static OrderDetailsDeliveryManPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsDeliveryManPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsDeliveryManPosition();
}

class OrderDetailsUserPosition {
  double latitude;
  double longitude;

  OrderDetailsUserPosition({this.latitude = 0, this.longitude = 0});

  factory OrderDetailsUserPosition.fromJson(Map<String, dynamic> json) =>
      OrderDetailsUserPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static OrderDetailsUserPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsUserPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsUserPosition();
}

class OrderDetailsPickupPosition {
  double latitude;
  double longitude;

  OrderDetailsPickupPosition({this.latitude = 0, this.longitude = 0});

  factory OrderDetailsPickupPosition.fromJson(Map<String, dynamic> json) =>
      OrderDetailsPickupPosition(
        latitude: APIHelper.getSafeDoubleValue(
          json['latitude'],
        ),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static OrderDetailsPickupPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsPickupPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsPickupPosition();
}

class OrderDetailsOrder {
  String id;
  String orderNumber;
  OrderDetailsOrderUser user;
  List<OrderDetailsOrderProduct> products;
  double subtotal;
  double vat;
  double pickupStationCharged;
  OrderDetailsOrderDelivery delivery;
  double total;
  String paymentMethod;
  String paymentStatus;

  OrderDetailsOrder({
    this.id = '',
    this.orderNumber = '',
    required this.user,
    this.products = const [],
    this.subtotal = 0,
    this.vat = 0,
    this.pickupStationCharged = 0,
    required this.delivery,
    this.total = 0,
    this.paymentMethod = '',
    this.paymentStatus = '',
  });

  factory OrderDetailsOrder.fromJson(Map<String, dynamic> json) =>
      OrderDetailsOrder(
        id: APIHelper.getSafeStringValue(json['_id']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        user: OrderDetailsOrderUser.getAPIResponseObjectSafeValue(json['user']),
        products: (APIHelper.getSafeListValue(json['products']))
            .map((e) =>
                OrderDetailsOrderProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        vat: APIHelper.getSafeDoubleValue(json['vat']),
        pickupStationCharged:
            APIHelper.getSafeDoubleValue(json['pickup_station_charged']),
        delivery: OrderDetailsOrderDelivery.getAPIResponseObjectSafeValue(
            json['delivery']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order_number': orderNumber,
        'user': user.toJson(),
        'products': products.map((e) => e.toJson()).toList(),
        'subtotal': subtotal,
        'vat': vat,
        'pickup_station_charged': pickupStationCharged,
        'delivery': delivery.toJson(),
        'total': total,
        'payment_method': paymentMethod,
        'payment_status': paymentStatus,
      };

  factory OrderDetailsOrder.empty() => OrderDetailsOrder(
      user: OrderDetailsOrderUser(), delivery: OrderDetailsOrderDelivery());

  static OrderDetailsOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsOrder.empty();

  PaymentMethodName get paymentMethodAsEnum =>
      PaymentMethodName.toEnumValue(paymentMethod);
}

class OrderDetailsOrderUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;

  OrderDetailsOrderUser(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phone = ''});

  factory OrderDetailsOrderUser.fromJson(Map<String, dynamic> json) =>
      OrderDetailsOrderUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
      };
  static OrderDetailsOrderUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsOrderUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsOrderUser();
}

class OrderDetailsOrderDelivery {
  double distance;
  double perKmFare;
  double fare;

  OrderDetailsOrderDelivery(
      {this.distance = 0, this.perKmFare = 0, this.fare = 0});

  factory OrderDetailsOrderDelivery.fromJson(Map<String, dynamic> json) =>
      OrderDetailsOrderDelivery(
        distance: APIHelper.getSafeDoubleValue(json['distance']),
        perKmFare: APIHelper.getSafeDoubleValue(json['per_km_fare']),
        fare: APIHelper.getSafeDoubleValue(json['fare']),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'per_km_fare': perKmFare,
        'fare': fare,
      };

  static OrderDetailsOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsOrderDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsOrderDelivery();
}

class OrderDetailsOrderProduct {
  String product;
  String name;
  String image;
  String unit;
  double price;
  int quantity;
  double subtotal;
  String id;

  OrderDetailsOrderProduct({
    this.product = '',
    this.name = '',
    this.image = '',
    this.unit = '',
    this.price = 0,
    this.quantity = 0,
    this.subtotal = 0,
    this.id = '',
  });

  factory OrderDetailsOrderProduct.fromJson(Map<String, dynamic> json) =>
      OrderDetailsOrderProduct(
        product: APIHelper.getSafeStringValue(json['product']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'product': product,
        'name': name,
        'image': image,
        'unit': unit,
        'price': price,
        'quantity': quantity,
        'subtotal': subtotal,
        '_id': id,
      };
  static OrderDetailsOrderProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsOrderProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderDetailsOrderProduct();
}
