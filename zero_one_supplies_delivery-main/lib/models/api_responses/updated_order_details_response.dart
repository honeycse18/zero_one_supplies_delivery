import 'package:ecomikdeliveryapp/models/api_responses/order_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_confirm_order_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class UpdatedOrderDetailsResponse {
  bool error;
  String msg;
  UpdatedOrderDetails data;

  UpdatedOrderDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory UpdatedOrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UpdatedOrderDetailsResponse(
      error: json['error'] as bool,
      data: UpdatedOrderDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson(),
      };

  factory UpdatedOrderDetailsResponse.empty() => UpdatedOrderDetailsResponse(
        data: UpdatedOrderDetails.empty(),
      );
  static UpdatedOrderDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UpdatedOrderDetailsResponse.fromJson(unsafeResponseValue)
          : UpdatedOrderDetailsResponse.empty();
}

class UpdatedOrderDetails {
  String id;
  OuterOrder outerOrder;
  DeliveryRequest deliveryRequest;
  Destination destination;
  String type;
  DeliveryMan deliveryManUpdated;
  OrderDetailsOrder order;
  String status;
  OrderDetailsPickupPosition pickupPosition;
  OrderDetailsUserPosition userPosition;
  OrderDetailsDeliveryMan deliveryMan;

  UpdatedOrderDetails({
    this.id = '',
    required this.outerOrder,
    required this.deliveryRequest,
    required this.destination,
    this.type = '',
    required this.deliveryManUpdated,
    required this.order,
    this.status = '',
    required this.pickupPosition,
    required this.userPosition,
    required this.deliveryMan,
  });

  factory UpdatedOrderDetails.fromJson(Map<String, dynamic> json) =>
      UpdatedOrderDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        outerOrder: OuterOrder.getAPIResponseObjectSafeValue(json['order']),
        deliveryRequest: DeliveryRequest.getAPIResponseObjectSafeValue(
            json['delivery_request']),
        destination:
            Destination.getAPIResponseObjectSafeValue(json['destination']),
        type: APIHelper.getSafeStringValue(json['type']),
        deliveryManUpdated:
            DeliveryMan.getAPIResponseObjectSafeValue(json['delivery_man']),
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
        'order': outerOrder.toJson(),
        'delivery_request': deliveryRequest.toJson(),
        'destination': destination.toJson(),
        'type': type,
        'delivery_man': deliveryManUpdated.toJson(),
        // 'order': order.toJson(),
        'status': status,
        'pickup_position': pickupPosition.toJson(),
        'user_position': userPosition.toJson(),
        // 'delivery_man': deliveryMan.toJson(),
      };

  factory UpdatedOrderDetails.empty() => UpdatedOrderDetails(
      deliveryRequest: DeliveryRequest.empty(),
      deliveryManUpdated: DeliveryMan.empty(),
      destination: Destination.empty(),
      outerOrder: OuterOrder.empty(),
      order: OrderDetailsOrder.empty(),
      pickupPosition: OrderDetailsPickupPosition(),
      userPosition: OrderDetailsUserPosition(),
      deliveryMan: OrderDetailsDeliveryMan.empty());
  static UpdatedOrderDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UpdatedOrderDetails.fromJson(unsafeResponseValue)
          : UpdatedOrderDetails.empty();

  OrderType get orderType => OrderType.toEnumValue(type);
}

class DeliveryRequest {
  String id;
  String sender;
  Receiver receiver;
  Dimensions dimensions;
  int weight;
  PickupAddress pickupAddress;
  DestinationAddress destinationAddress;
  List<String> productImages;
  String status;
  DeliveryCharge deliveryCharge;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int ref;
  String payment;
  String paymentType;
  String deliveryNumber;

  DeliveryRequest({
    this.id = '',
    this.sender = '',
    required this.receiver,
    required this.dimensions,
    this.weight = 0,
    required this.pickupAddress,
    this.productImages = const [],
    this.status = '',
    required this.deliveryCharge,
    this.paymentStatus = '',
    required this.createdAt,
    required this.updatedAt,
    this.ref = 0,
    this.payment = '',
    this.paymentType = '',
    this.deliveryNumber = '',
    required this.destinationAddress,
  });

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      id: APIHelper.getSafeStringValue(json['_id']),
      sender: APIHelper.getSafeStringValue(json['sender']),
      receiver: Receiver.getAPIResponseObjectSafeValue(json['receiver']),
      dimensions: Dimensions.getAPIResponseObjectSafeValue(json['dimensions']),
      weight: APIHelper.getSafeIntValue(json['weight']),
      pickupAddress:
          PickupAddress.getAPIResponseObjectSafeValue(json['pickup_address']),
      destinationAddress: DestinationAddress.getAPIResponseObjectSafeValue(
          json['destination_address']),
      productImages: APIHelper.getSafeListValue(json['product_images'])
          .map((e) => APIHelper.getSafeStringValue(e))
          .toList(),
      status: APIHelper.getSafeStringValue(json['status']),
      deliveryCharge:
          DeliveryCharge.getAPIResponseObjectSafeValue(json['deliveryCharge']),
      paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      ref: APIHelper.getSafeIntValue(json['ref']),
      payment: APIHelper.getSafeStringValue(json['payment']),
      paymentType: APIHelper.getSafeStringValue(json['payment_type']),
      deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sender': sender,
        'receiver': receiver.toJson(),
        'dimensions': dimensions.toJson(),
        'weight': weight,
        'pickup_address': pickupAddress.toJson(),
        'destination_address': destinationAddress.toJson(),
        'product_images': productImages,
        'status': status,
        'deliveryCharge': deliveryCharge.toJson(),
        'payment_status': paymentStatus,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'ref': ref,
        'payment': payment,
        'payment_type': paymentType,
        'delivery_number': deliveryNumber,
      };

  factory DeliveryRequest.empty() => DeliveryRequest(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        receiver: Receiver(),
        dimensions: Dimensions(),
        pickupAddress: PickupAddress.empty(),
        destinationAddress: DestinationAddress.empty(),
        deliveryCharge: DeliveryCharge.empty(),
      );
  static DeliveryRequest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequest.fromJson(unsafeResponseValue)
          : DeliveryRequest.empty();

  OrderStatus get paymentMethodStatus => OrderStatus.toEnumValue(paymentStatus);
}

class DeliveryCharge {
  int totalCharge;
  ChargeInfo chargeInfo;
  Measurements measurements;
  String id;

  DeliveryCharge({
    this.totalCharge = 0,
    required this.chargeInfo,
    this.id = '',
    required this.measurements,
  });

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) {
    return DeliveryCharge(
      totalCharge: APIHelper.getSafeIntValue(json['totalCharge']),
      chargeInfo: ChargeInfo.getAPIResponseObjectSafeValue(json['chargeInfo']),
      measurements:
          Measurements.getAPIResponseObjectSafeValue(json['measurements']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalCharge': totalCharge,
        'chargeInfo': chargeInfo.toJson(),
        'measurements': measurements.toJson(),
        '_id': id,
      };

  factory DeliveryCharge.empty() => DeliveryCharge(
        chargeInfo: ChargeInfo.empty(),
        measurements: Measurements(),
      );
  static DeliveryCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryCharge.fromJson(unsafeResponseValue)
          : DeliveryCharge.empty();
}

class ChargeInfo {
  ShippingCharge shippingCharge;
  PackageCharge packageCharge;

  ChargeInfo({required this.shippingCharge, required this.packageCharge});

  factory ChargeInfo.fromJson(Map<String, dynamic> json) => ChargeInfo(
        shippingCharge: ShippingCharge.getAPIResponseObjectSafeValue(
            json['shippingCharge']),
        packageCharge:
            PackageCharge.getAPIResponseObjectSafeValue(json['packageCharge']),
      );

  Map<String, dynamic> toJson() => {
        'shippingCharge': shippingCharge.toJson(),
        'packageCharge': packageCharge.toJson(),
      };

  factory ChargeInfo.empty() => ChargeInfo(
        packageCharge: PackageCharge(),
        shippingCharge: ShippingCharge(),
      );
  static ChargeInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChargeInfo.fromJson(unsafeResponseValue)
          : ChargeInfo.empty();
}

class Dimensions {
  int length;
  int width;
  int height;

  Dimensions({this.length = 0, this.width = 0, this.height = 0});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: APIHelper.getSafeIntValue(json['length']),
        width: APIHelper.getSafeIntValue(json['width']),
        height: APIHelper.getSafeIntValue(json['height']),
      );

  Map<String, dynamic> toJson() => {
        'length': length,
        'width': width,
        'height': height,
      };

  static Dimensions getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Dimensions.fromJson(unsafeResponseValue)
          : Dimensions();
}

class Measurements {
  int cbmConversionFactor;
  int deliveryRequestPerKgChargeAmount;
  int deliveryRequestPerKmChargeAmount;

  Measurements({
    this.cbmConversionFactor = 0,
    this.deliveryRequestPerKgChargeAmount = 0,
    this.deliveryRequestPerKmChargeAmount = 0,
  });

  factory Measurements.fromJson(Map<String, dynamic> json) => Measurements(
        cbmConversionFactor:
            APIHelper.getSafeIntValue(json['cbm_conversion_factor']),
        deliveryRequestPerKgChargeAmount: APIHelper.getSafeIntValue(
            json['delivery_request_per_kg_charge_amount']),
        deliveryRequestPerKmChargeAmount: APIHelper.getSafeIntValue(
            json['delivery_request_per_km_charge_amount']),
      );

  Map<String, dynamic> toJson() => {
        'cbm_conversion_factor': cbmConversionFactor,
        'delivery_request_per_kg_charge_amount':
            deliveryRequestPerKgChargeAmount,
        'delivery_request_per_km_charge_amount':
            deliveryRequestPerKmChargeAmount,
      };

  static Measurements getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Measurements.fromJson(unsafeResponseValue)
          : Measurements();
}

class DestinationAddress {
  String name;
  String address;
  OrderDetailsPickupPosition position;

  DestinationAddress(
      {this.name = '', this.address = '', required this.position});

  factory DestinationAddress.fromJson(Map<String, dynamic> json) {
    return DestinationAddress(
      name: APIHelper.getSafeStringValue(json['name']),
      address: APIHelper.getSafeStringValue(json['address']),
      position: OrderDetailsPickupPosition.getAPIResponseObjectSafeValue(
          json['position']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'position': position.toJson(),
      };

  factory DestinationAddress.empty() =>
      DestinationAddress(position: OrderDetailsPickupPosition());
  static DestinationAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DestinationAddress.fromJson(unsafeResponseValue)
          : DestinationAddress.empty();
}

class PackageCharge {
  double packageWeight;
  double packageWeightPerKg;
  double total;

  PackageCharge(
      {this.packageWeight = 0, this.packageWeightPerKg = 0, this.total = 0});

  factory PackageCharge.fromJson(Map<String, dynamic> json) => PackageCharge(
        packageWeight: APIHelper.getSafeDoubleValue(json['packageWeight']),
        packageWeightPerKg:
            APIHelper.getSafeDoubleValue(json['packageWeightPerKG']),
        total: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'packageWeight': packageWeight,
        'packageWeightPerKG': packageWeightPerKg,
        'total': total,
      };

  static PackageCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PackageCharge.fromJson(unsafeResponseValue)
          : PackageCharge();
}

class Receiver {
  String name;
  String phone;
  String email;

  Receiver({this.name = '', this.phone = '', this.email = ''});

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
      };

  static Receiver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Receiver.fromJson(unsafeResponseValue)
          : Receiver();
}

class ShippingCharge {
  double totalDistanceInKm;
  double deliveryChargePerKm;
  double total;

  ShippingCharge({
    this.totalDistanceInKm = 0,
    this.deliveryChargePerKm = 0,
    this.total = 0,
  });

  factory ShippingCharge.fromJson(Map<String, dynamic> json) {
    return ShippingCharge(
      totalDistanceInKm:
          APIHelper.getSafeDoubleValue(json['totalDistanceInKM']),
      deliveryChargePerKm:
          APIHelper.getSafeDoubleValue(json['deliveryChargePerKM']),
      total: APIHelper.getSafeDoubleValue(json['total']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalDistanceInKM': totalDistanceInKm,
        'deliveryChargePerKM': deliveryChargePerKm,
        'total': total,
      };

  static ShippingCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShippingCharge.fromJson(unsafeResponseValue)
          : ShippingCharge();
}

class PickupAddress {
  String name;
  String address;
  OrderDetailsPickupPosition position;

  PickupAddress({this.name = '', this.address = '', required this.position});

  factory PickupAddress.fromJson(Map<String, dynamic> json) => PickupAddress(
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        position: OrderDetailsPickupPosition.getAPIResponseObjectSafeValue(
            json['position']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'position': position.toJson(),
      };

  factory PickupAddress.empty() => PickupAddress(
        position: OrderDetailsPickupPosition(),
      );
  static PickupAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupAddress.fromJson(unsafeResponseValue)
          : PickupAddress.empty();
}

class OuterOrder {
  String id;
  List<StoreWiseOrder> orders;
  String productReceiveTime;
  int estimatedDeliveryHours;
  String status;
  DateTime createdAt;
  String orderNumber;
  OuterOrderUser user;
  OuterOrderDelivery delivery;
  String paymentMethod;
  String paymentStatus;
  double subtotal;
  String companyVat;
  double vat;
  double totalSaveMoney;
  double total;

  OuterOrder({
    this.id = '',
    this.orders = const [],
    this.productReceiveTime = '',
    required this.createdAt,
    required this.delivery,
    this.orderNumber = '',
    this.status = '',
    required this.user,
    this.paymentMethod = '',
    this.paymentStatus = '',
    this.subtotal = 0,
    this.companyVat = '',
    this.vat = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
    this.estimatedDeliveryHours = 0,
  });

  factory OuterOrder.fromJson(Map<String, dynamic> json) => OuterOrder(
        delivery:
            OuterOrderDelivery.getAPIResponseObjectSafeValue(json['delivery']),
        id: APIHelper.getSafeStringValue(json['_id']),
        status: APIHelper.getSafeStringValue(json['status']),
        orders: APIHelper.getSafeListValue(json['orders'])
            .map((e) => StoreWiseOrder.getAPIResponseObjectSafeValue(e))
            .toList(),
        productReceiveTime:
            APIHelper.getSafeStringValue(json['product_receive_time']),
        estimatedDeliveryHours:
            APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        user: OuterOrderUser.getAPIResponseObjectSafeValue(json['user']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        companyVat: APIHelper.getSafeStringValue(json['company_vat']),
        vat: APIHelper.getSafeDoubleValue(json['vat']),
        totalSaveMoney: APIHelper.getSafeDoubleValue(json['total_save_money']),
        total: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'status': status,
        'orders': orders.map((e) => e.toJson()).toList(),
        'product_receive_time': productReceiveTime,
        'estimated_delivery_hours': estimatedDeliveryHours,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'order_number': orderNumber,
        'user': user.toJson(),
        'payment_method': paymentMethod,
        'payment_status': paymentStatus,
        'subtotal': subtotal,
        'company_vat': companyVat,
        'vat': vat,
        'total_save_money': totalSaveMoney,
        'total': total,
        'delivery': delivery.toJson(),
      };

  factory OuterOrder.empty() => OuterOrder(
        delivery: OuterOrderDelivery.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        user: OuterOrderUser(),
      );
  static OuterOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OuterOrder.fromJson(unsafeResponseValue)
          : OuterOrder.empty();

  OrderStatus get paymentMethodStatus => OrderStatus.toEnumValue(paymentStatus);
}

class OuterOrderDelivery {
  String type;
  OrderDetailsAddress address;
  String id;

  OuterOrderDelivery({this.type = '', required this.address, this.id = ''});

  factory OuterOrderDelivery.fromJson(Map<String, dynamic> json) =>
      OuterOrderDelivery(
        type: APIHelper.getSafeStringValue(json['type']),
        address:
            OrderDetailsAddress.getAPIResponseObjectSafeValue(json['address']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'address': address.toJson(),
        '_id': id,
      };

  factory OuterOrderDelivery.empty() => OuterOrderDelivery(
        address: OrderDetailsAddress.empty(),
      );
  static OuterOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OuterOrderDelivery.fromJson(unsafeResponseValue)
          : OuterOrderDelivery.empty();
}

class OrderDetailsAddress {
  String id;
  String address;
  String delivery;
  DeliveryManPosition position;
  double totalCost;
  int totalDistanceInKm;

  OrderDetailsAddress({
    this.id = '',
    this.address = '',
    this.delivery = '',
    required this.position,
    this.totalCost = 0,
    this.totalDistanceInKm = 0,
  });

  factory OrderDetailsAddress.fromJson(Map<String, dynamic> json) =>
      OrderDetailsAddress(
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        position:
            DeliveryManPosition.getAPIResponseObjectSafeValue(json['position']),
        totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
        totalDistanceInKm: APIHelper.getSafeIntValue(json['totalDistanceInKm']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'address': address,
        'delivery': delivery,
        'position': position.toJson(),
        'totalCost': totalCost,
        'totalDistanceInKm': totalDistanceInKm,
      };

  factory OrderDetailsAddress.empty() => OrderDetailsAddress(
        position: DeliveryManPosition(),
      );
  static OrderDetailsAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderDetailsAddress.fromJson(unsafeResponseValue)
          : OrderDetailsAddress.empty();
}

class StoreWiseOrder {
  int total;
  List<StoreWiseCartProduct> products;
  Store store;

  StoreWiseOrder(
      {this.total = 0, this.products = const [], required this.store});

  factory StoreWiseOrder.fromJson(Map<String, dynamic> json) => StoreWiseOrder(
        total: APIHelper.getSafeIntValue(json['total']),
        products: APIHelper.getSafeListValue(json['products'])
            .map((e) => StoreWiseCartProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'products': products.map((e) => e.toJson()).toList(),
        'store': store.toJson(),
      };

  factory StoreWiseOrder.empty() => StoreWiseOrder(store: Store());
  static StoreWiseOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseOrder.fromJson(unsafeResponseValue)
          : StoreWiseOrder.empty();
}

class StoreWiseCartProduct {
  String cartId;
  String product;
  List<StoreWiseCartProductAttribute> attributes;
  double extraPrice;
  int quantity;
  double price;
  double subtotal;
  String store;
  String name;
  String image;
  String unit;
  StoreWiseCartProductCategories categories;
  bool isAuction;
  StoreWiseCartProductLocation productLocation;

  StoreWiseCartProduct({
    this.cartId = '',
    this.product = '',
    this.attributes = const [],
    this.extraPrice = 0,
    this.quantity = 0,
    this.price = 0,
    this.subtotal = 0,
    this.store = '',
    this.name = '',
    this.image = '',
    this.unit = '',
    required this.categories,
    this.isAuction = false,
    required this.productLocation,
  });

  factory StoreWiseCartProduct.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProduct(
        cartId: APIHelper.getSafeStringValue(json['cart_id']),
        product: APIHelper.getSafeStringValue(json['product']),
        attributes: APIHelper.getSafeListValue((json['attributes']))
            .map((e) =>
                StoreWiseCartProductAttribute.getAPIResponseObjectSafeValue(e))
            .toList(),
        extraPrice: APIHelper.getSafeDoubleValue(json['extra_price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categories:
            StoreWiseCartProductCategories.getAPIResponseObjectSafeValue(
                json['categories']),
        isAuction: APIHelper.getSafeBoolValue(json['isAuction']),
        productLocation:
            StoreWiseCartProductLocation.getAPIResponseObjectSafeValue(
                json['product_location']),
      );

  Map<String, dynamic> toJson() {
    final map = {
      'cart_id': cartId,
      'product': product,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'extra_price': extraPrice,
      'quantity': quantity,
      'price': price,
      'subtotal': subtotal,
      'store': store,
      'name': name,
      'image': image,
      'unit': unit,
      'categories': categories.toJson(),
      'isAuction': isAuction,
      'product_location': productLocation.toJson(),
    };
    if (productLocation.productLocationType == ProductLocation.none) {
      map.remove('product_location');
    }
    return map;
  }

  factory StoreWiseCartProduct.empty() => StoreWiseCartProduct(
      categories: StoreWiseCartProductCategories(),
      productLocation: StoreWiseCartProductLocation.empty());

  static StoreWiseCartProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProduct.fromJson(unsafeResponseValue)
          : StoreWiseCartProduct.empty();
}

class StoreWiseCartProductCategories {
  String id;
  String name;

  StoreWiseCartProductCategories({this.id = '', this.name = ''});

  factory StoreWiseCartProductCategories.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProductCategories(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static StoreWiseCartProductCategories getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductCategories.fromJson(unsafeResponseValue)
          : StoreWiseCartProductCategories();
}

class Store {
  String id;
  String name;

  Store({this.id = '', this.name = ''});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue)
          : Store();
}

class OuterOrderUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;

  OuterOrderUser({
    this.firstName = '',
    this.id = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
  });

  factory OuterOrderUser.fromJson(Map<String, dynamic> json) => OuterOrderUser(
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

  static OuterOrderUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OuterOrderUser.fromJson(unsafeResponseValue)
          : OuterOrderUser();
}

class DeliveryMan {
  DeliveryManPosition position;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  bool deliveryService;

  DeliveryMan({
    required this.position,
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.deliveryService = false,
  });

  factory DeliveryMan.fromJson(Map<String, dynamic> json) => DeliveryMan(
        position:
            DeliveryManPosition.getAPIResponseObjectSafeValue(json['position']),
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

  factory DeliveryMan.empty() => DeliveryMan(position: DeliveryManPosition());
  static DeliveryMan getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryMan.fromJson(unsafeResponseValue)
          : DeliveryMan.empty();
}

class DeliveryManPosition {
  double latitude;
  double longitude;

  DeliveryManPosition({this.latitude = 0, this.longitude = 0});

  factory DeliveryManPosition.fromJson(Map<String, dynamic> json) =>
      DeliveryManPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static DeliveryManPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryManPosition.fromJson(unsafeResponseValue)
          : DeliveryManPosition();
}

class Location {
  double latitude;
  double longitude;

  Location({this.latitude = 0, this.longitude = 0});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue)
          : Location();
}

class Destination {
  String id;
  String name;
  String address;
  Location location;
  double charge;
  int estimatedDay;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int estimatedDeliveryHours;

  Destination({
    this.id = '',
    this.name = '',
    this.address = '',
    required this.location,
    this.charge = 0,
    this.estimatedDay = 0,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.estimatedDeliveryHours = 0,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        charge: APIHelper.getSafeDoubleValue(json['charge']),
        estimatedDay: APIHelper.getSafeIntValue(json['estimated_day']),
        active: json['active'] as bool,
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        estimatedDeliveryHours:
            APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
        'charge': charge,
        'estimated_day': estimatedDay,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'estimated_delivery_hours': estimatedDeliveryHours,
      };

  factory Destination.empty() => Destination(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        location: Location(),
      );
  static Destination getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Destination.fromJson(unsafeResponseValue)
          : Destination.empty();
}
