import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmOrderUpdatedResponse {
  String type;
  List<ConfirmedOrder> orders;
  ConfirmOrdersUpdated updatedOrders;

  ConfirmOrderUpdatedResponse(
      {this.type = '', required this.updatedOrders, this.orders = const []});

  factory ConfirmOrderUpdatedResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderUpdatedResponse(
      type: APIHelper.getSafeStringValue(json['type']),
      orders: APIHelper.getSafeListValue(json['orders'])
          .map((e) => ConfirmedOrder.getAPIResponseObjectSafeValue(e))
          .toList(),
      updatedOrders:
          ConfirmOrdersUpdated.getAPIResponseObjectSafeValue(json['orders']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'orders': updatedOrders.toJson(),
        // 'orders': orders.map((e) => e.toJson()).toList(),
      };

  factory ConfirmOrderUpdatedResponse.empty() => ConfirmOrderUpdatedResponse(
        updatedOrders: ConfirmOrdersUpdated.empty(),
      );
  static ConfirmOrderUpdatedResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrderUpdatedResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrderUpdatedResponse.empty();
}

class ConfirmOrdersUpdated {
  String id;
  String user;
  int totalProducts;
  List<ConfirmOrder> orders;
  double netAmount;
  String companyCommission;
  double chargedAmount;
  double totalSaveMoney;
  int total;
  String productReceiveTime;
  int estimatedDeliveryHours;
  ConfirmOrdersDelivery delivery;
  String paymentStatus;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int ref;
  int v;
  String payment;
  String paymentMethod;

  ConfirmOrdersUpdated({
    this.id = '',
    this.user = '',
    this.totalProducts = 0,
    this.orders = const [],
    this.netAmount = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
    this.productReceiveTime = '',
    required this.delivery,
    this.paymentStatus = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.ref = 0,
    this.v = 0,
    this.payment = '',
    this.paymentMethod = '',
    this.estimatedDeliveryHours = 0,
  });

  factory ConfirmOrdersUpdated.fromJson(Map<String, dynamic> json) =>
      ConfirmOrdersUpdated(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        totalProducts: APIHelper.getSafeIntValue(json['totalProducts']),
        orders: APIHelper.getSafeListValue(json['orders'])
            .map((e) => ConfirmOrder.getAPIResponseObjectSafeValue(e))
            .toList(),
        netAmount: APIHelper.getSafeDoubleValue(json['netAmount']),
        companyCommission:
            APIHelper.getSafeStringValue(json['company_commission']),
        chargedAmount: (json['charged_amount'] as num).toDouble(),
        totalSaveMoney: APIHelper.getSafeDoubleValue(json['total_save_money']),
        total: APIHelper.getSafeIntValue(json['total']),
        productReceiveTime:
            APIHelper.getSafeStringValue(json['product_receive_time']),
        estimatedDeliveryHours:
            APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
        delivery: ConfirmOrdersDelivery.getAPIResponseObjectSafeValue(
            json['delivery']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        ref: APIHelper.getSafeIntValue(json['ref']),
        v: APIHelper.getSafeIntValue(json['__v']),
        payment: APIHelper.getSafeStringValue(json['payment']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'totalProducts': totalProducts,
        'orders': orders.map((e) => e.toJson()).toList(),
        'netAmount': netAmount,
        'company_commission': companyCommission,
        'charged_amount': chargedAmount,
        'total_save_money': totalSaveMoney,
        'total': total,
        'product_receive_time': productReceiveTime,
        'estimated_delivery_hours': estimatedDeliveryHours,
        'delivery': delivery.toJson(),
        'payment_status': paymentStatus,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'ref': ref,
        '__v': v,
        'payment': payment,
        'payment_method': paymentMethod,
      };

  factory ConfirmOrdersUpdated.empty() => ConfirmOrdersUpdated(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        delivery: ConfirmOrdersDelivery.empty(),
      );
  static ConfirmOrdersUpdated getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrdersUpdated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrdersUpdated.empty();
}

class ConfirmOrdersDelivery {
  ConfirmOrdersDeliveryAddress address;
  String type;
  String id;

  ConfirmOrdersDelivery({required this.address, this.type = '', this.id = ''});

  factory ConfirmOrdersDelivery.fromJson(Map<String, dynamic> json) =>
      ConfirmOrdersDelivery(
        address: ConfirmOrdersDeliveryAddress.getAPIResponseObjectSafeValue(
            json['address']),
        type: APIHelper.getSafeStringValue(json['type']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'type': type,
        '_id': id,
      };

  factory ConfirmOrdersDelivery.empty() =>
      ConfirmOrdersDelivery(address: ConfirmOrdersDeliveryAddress.empty());
  static ConfirmOrdersDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrdersDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrdersDelivery.empty();
}

class ConfirmOrdersDeliveryAddress {
  ConfirmOrdersDeliveryAddressPosition position;
  String id;
  String address;
  String delivery;
  double totalCost;
  int totalDistanceInKm;

  ConfirmOrdersDeliveryAddress({
    required this.position,
    this.id = '',
    this.address = '',
    this.delivery = '',
    this.totalCost = 0,
    this.totalDistanceInKm = 0,
  });

  factory ConfirmOrdersDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      ConfirmOrdersDeliveryAddress(
        position:
            ConfirmOrdersDeliveryAddressPosition.getAPIResponseObjectSafeValue(
                json['position']),
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
        totalDistanceInKm: APIHelper.getSafeIntValue(json['totalDistanceInKm']),
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        '_id': id,
        'address': address,
        'delivery': delivery,
        'totalCost': totalCost,
        'totalDistanceInKm': totalDistanceInKm,
      };

  factory ConfirmOrdersDeliveryAddress.empty() => ConfirmOrdersDeliveryAddress(
      position: ConfirmOrdersDeliveryAddressPosition());
  static ConfirmOrdersDeliveryAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrdersDeliveryAddress.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrdersDeliveryAddress.empty();
}

class ConfirmOrdersDeliveryAddressPosition {
  double latitude;
  double longitude;

  ConfirmOrdersDeliveryAddressPosition({this.latitude = 0, this.longitude = 0});

  factory ConfirmOrdersDeliveryAddressPosition.fromJson(
          Map<String, dynamic> json) =>
      ConfirmOrdersDeliveryAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static ConfirmOrdersDeliveryAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrdersDeliveryAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrdersDeliveryAddressPosition();
}

class ConfirmOrder {
  int total;
  List<StoreWiseCartProduct> products;
  Store store;

  ConfirmOrder({this.total = 0, this.products = const [], required this.store});

  factory ConfirmOrder.fromJson(Map<String, dynamic> json) => ConfirmOrder(
        total: json['total'] as int,
        products: APIHelper.getSafeListValue((json['products']))
            .map((e) => StoreWiseCartProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        store: Store.fromJson(json['store'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'products': products.map((e) => e.toJson()).toList(),
        'store': store.toJson(),
      };

  factory ConfirmOrder.empty() => ConfirmOrder(store: Store());
  static ConfirmOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmOrder.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ConfirmOrder.empty();
}

class Store {
  String? id;
  String? name;

  Store({this.id, this.name});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json['_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
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
          ? StoreWiseCartProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProduct.empty();
}

class StoreWiseCartProductAttribute {
  String key;
  StoreWiseCartProductAttributeOption option;

  StoreWiseCartProductAttribute({this.key = '', required this.option});

  factory StoreWiseCartProductAttribute.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProductAttribute(
        key: APIHelper.getSafeStringValue(json['key']),
        option:
            StoreWiseCartProductAttributeOption.getAPIResponseObjectSafeValue(
                json['option']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'option': option.toJson(),
      };
  factory StoreWiseCartProductAttribute.empty() =>
      StoreWiseCartProductAttribute(
          option: StoreWiseCartProductAttributeOption());

  static StoreWiseCartProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductAttribute.empty();
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
          ? StoreWiseCartProductCategories.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductCategories();
}

class StoreWiseCartRelayPoint {
  String id;
  String name;
  String address;
  StoreWiseCartStoreLocation location;

  StoreWiseCartRelayPoint(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory StoreWiseCartRelayPoint.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartRelayPoint(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: StoreWiseCartStoreLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
      };

  factory StoreWiseCartRelayPoint.empty() =>
      StoreWiseCartRelayPoint(location: StoreWiseCartStoreLocation());

  static StoreWiseCartRelayPoint getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartRelayPoint.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartRelayPoint.empty();
}

class StoreWiseCartProductLocation {
  String type;
  StoreWiseCartStore store;
  StoreWiseCartRelayPoint relayPoint;

  StoreWiseCartProductLocation(
      {this.type = '', required this.store, required this.relayPoint});

  factory StoreWiseCartProductLocation.fromJson(Map<String, dynamic> json) {
    return StoreWiseCartProductLocation(
      type: APIHelper.getSafeStringValue(json['type']),
      store: StoreWiseCartStore.getAPIResponseObjectSafeValue(json['store']),
      relayPoint: StoreWiseCartRelayPoint.getAPIResponseObjectSafeValue(
          json['replay_point']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'type': type,
    };
    switch (type) {
      case 'store':
        map['store'] = store.toJson();
        break;
      case 'replay_point':
        map['replay_point'] = relayPoint.toJson();
        break;
    }
    return map;
  }

  factory StoreWiseCartProductLocation.empty() => StoreWiseCartProductLocation(
      store: StoreWiseCartStore.empty(),
      relayPoint: StoreWiseCartRelayPoint.empty());

  static StoreWiseCartProductLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductLocation.empty();

  ProductLocation get productLocationType =>
      ProductLocation.typeToEnumValue(type);
}

class StoreWiseCartProductAttributeOption {
  String label;
  String value;
  double price;
  String id;

  StoreWiseCartProductAttributeOption(
      {this.label = '', this.value = '', this.price = 0, this.id = ''});

  factory StoreWiseCartProductAttributeOption.fromJson(
          Map<String, dynamic> json) =>
      StoreWiseCartProductAttributeOption(
        label: APIHelper.getSafeStringValue(json['label']),
        value: APIHelper.getSafeStringValue(json['value']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'price': price,
        '_id': id,
      };

  static StoreWiseCartProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductAttributeOption();
}

class StoreWiseCartStore {
  String id;
  String name;
  String address;
  StoreWiseCartStoreLocation location;

  StoreWiseCartStore(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory StoreWiseCartStore.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: StoreWiseCartStoreLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() {
    final map = {
      '_id': id,
      'name': name,
      'address': address,
      'location': location.toJson(),
    };
    if (address.isEmpty) {
      map.remove('address');
    }
    if (location.latitude == Constants.unsetMapLatLng ||
        location.longitude == Constants.unsetMapLatLng) {
      map.remove('location');
    }
    return map;
  }

  factory StoreWiseCartStore.empty() =>
      StoreWiseCartStore(location: StoreWiseCartStoreLocation());

  static StoreWiseCartStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartStore.empty();
}

class StoreWiseCartStoreLocation {
  double latitude;
  double longitude;

  StoreWiseCartStoreLocation(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory StoreWiseCartStoreLocation.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartStoreLocation(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static StoreWiseCartStoreLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartStoreLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartStoreLocation();
}
