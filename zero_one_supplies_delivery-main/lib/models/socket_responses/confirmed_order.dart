import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmedOrder {
  String id;
  String status;
  String orderNumber;
  double total;
  String paymentStatus;
  String paymentMethod;
  int estimatedDeliveryHours;

  ConfirmedOrder({
    this.id = '',
    this.status = '',
    this.orderNumber = '',
    this.total = 0,
    this.paymentStatus = '',
    this.paymentMethod = '',
    this.estimatedDeliveryHours = 0,
  });

  factory ConfirmedOrder.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrder(
      id: APIHelper.getSafeStringValue(json['_id']),
      status: APIHelper.getSafeStringValue(json['status']),
      orderNumber: APIHelper.getSafeStringValue(json['order_number']),
      total: APIHelper.getSafeDoubleValue(json['total']),
      paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
      paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
      estimatedDeliveryHours:
          APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'status': status,
        'order_number': orderNumber,
        'total': total,
        'payment_status': paymentStatus,
        'payment_method': paymentMethod,
        'estimated_delivery_hours': estimatedDeliveryHours,
      };

  static ConfirmedOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrder.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrder();
  PaymentMethodName get paymentMethodName =>
      PaymentMethodName.toEnumValue(paymentMethod);
  OrderStatus get paymentStatusEnum => OrderStatus.toEnumValue(paymentStatus);
}

class ConfirmedOrderCusAddress {
  String deliveryType;
  ConfirmedOrderCusAddressAddressBook addressBook;
  ConfirmedOrderCusAddressPosition position;

  ConfirmedOrderCusAddress(
      {this.deliveryType = '',
      required this.addressBook,
      required this.position});

  factory ConfirmedOrderCusAddress.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderCusAddress(
        deliveryType: APIHelper.getSafeStringValue(json['delivery_type']),
        addressBook: ConfirmedOrderCusAddressAddressBook.fromJson(
            json['address_book'] as Map<String, dynamic>),
        position:
            ConfirmedOrderCusAddressPosition.getAPIResponseObjectSafeValue(
                json['position']),
      );

  Map<String, dynamic> toJson() => {
        'delivery_type': deliveryType,
        'address_book': addressBook.toJson(),
        'position': position.toJson(),
      };

  factory ConfirmedOrderCusAddress.empty() => ConfirmedOrderCusAddress(
      addressBook: ConfirmedOrderCusAddressAddressBook.empty(),
      position: ConfirmedOrderCusAddressPosition());

  static ConfirmedOrderCusAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderCusAddress.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderCusAddress.empty();
}

class ConfirmedOrderCusAddressAddressBook {
  String id;
  String user;
  String name;
  String phone;
  String province;
  String city;
  String area;
  String address;
  String landmark;
  String delivery;
  bool defaultShippingAddress;
  bool defaultBillingAddress;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPrimary;
  String country;
  ConfirmedOrderCusAddressAddressBookLocation location;
  ConfirmedOrderCusAddressPosition position;
  String zipCode;

  ConfirmedOrderCusAddressAddressBook({
    this.id = '',
    this.user = '',
    this.name = '',
    this.phone = '',
    this.province = '',
    this.city = '',
    this.area = '',
    this.address = '',
    this.landmark = '',
    this.delivery = '',
    this.defaultShippingAddress = false,
    this.defaultBillingAddress = false,
    required this.createdAt,
    required this.updatedAt,
    this.isPrimary = false,
    this.country = '',
    required this.location,
    required this.position,
    this.zipCode = '',
  });

  factory ConfirmedOrderCusAddressAddressBook.fromJson(
          Map<String, dynamic> json) =>
      ConfirmedOrderCusAddressAddressBook(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        province: APIHelper.getSafeStringValue(json['province']),
        city: APIHelper.getSafeStringValue(json['city']),
        area: APIHelper.getSafeStringValue(json['area']),
        address: APIHelper.getSafeStringValue(json['address']),
        landmark: APIHelper.getSafeStringValue(json['landmark']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        defaultShippingAddress:
            APIHelper.getSafeBoolValue(json['default_shipping_address']),
        defaultBillingAddress:
            APIHelper.getSafeBoolValue(json['default_billing_address']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        isPrimary: APIHelper.getSafeBoolValue(json['is_primary']),
        country: APIHelper.getSafeStringValue(json['country']),
        location: ConfirmedOrderCusAddressAddressBookLocation
            .getAPIResponseObjectSafeValue(json['location']),
        position:
            ConfirmedOrderCusAddressPosition.getAPIResponseObjectSafeValue(
                json['position']),
        zipCode: APIHelper.getSafeStringValue(json['zip_code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'name': name,
        'phone': phone,
        'province': province,
        'city': city,
        'area': area,
        'address': address,
        'landmark': landmark,
        'delivery': delivery,
        'default_shipping_address': defaultShippingAddress,
        'default_billing_address': defaultBillingAddress,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'is_primary': isPrimary,
        'country': country,
        'location': location.toJson(),
        'position': position.toJson(),
        'zip_code': zipCode,
      };

  factory ConfirmedOrderCusAddressAddressBook.empty() =>
      ConfirmedOrderCusAddressAddressBook(
          createdAt: AppComponents.defaultUnsetDateTime,
          updatedAt: AppComponents.defaultUnsetDateTime,
          location: ConfirmedOrderCusAddressAddressBookLocation(),
          position: ConfirmedOrderCusAddressPosition());

  static ConfirmedOrderCusAddressAddressBook getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderCusAddressAddressBook.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderCusAddressAddressBook.empty();
}

class ConfirmedOrderCusAddressAddressBookLocation {
  String type;
  List<double> coordinates;

  ConfirmedOrderCusAddressAddressBookLocation(
      {this.type = '', this.coordinates = const []});

  factory ConfirmedOrderCusAddressAddressBookLocation.fromJson(
          Map<String, dynamic> json) =>
      ConfirmedOrderCusAddressAddressBookLocation(
        type: APIHelper.getSafeStringValue(json['type']),
        coordinates: APIHelper.getSafeListValue(json['coordinates'])
            .map((e) => APIHelper.getSafeDoubleValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates.map((e) => e).toList(),
      };

  static ConfirmedOrderCusAddressAddressBookLocation
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? ConfirmedOrderCusAddressAddressBookLocation.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : ConfirmedOrderCusAddressAddressBookLocation();
}

class ConfirmedOrderCusAddressPosition {
  double latitude;
  double longitude;

  ConfirmedOrderCusAddressPosition(
      {this.latitude = Constants.unsetLatLngValue,
      this.longitude = Constants.unsetLatLngValue});

  factory ConfirmedOrderCusAddressPosition.fromJson(
          Map<String, dynamic> json) =>
      ConfirmedOrderCusAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static ConfirmedOrderCusAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderCusAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderCusAddressPosition();
}

class ConfirmedOrderDelivery {
  double distance;
  double perKmFare;
  double fare;

  ConfirmedOrderDelivery(
      {this.distance = 0, this.perKmFare = 0, this.fare = 0});

  factory ConfirmedOrderDelivery.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderDelivery(
        distance: APIHelper.getSafeDoubleValue(json['distance'], 0),
        perKmFare: APIHelper.getSafeDoubleValue(json['per_km_fare'], 0),
        fare: APIHelper.getSafeDoubleValue(json['fare'], 0),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'per_km_fare': perKmFare,
        'fare': fare,
      };
  static ConfirmedOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderDelivery();
}

class ConfirmedOrderDiscountCoupon {
  String code;
  double value;
  String discountType;

  ConfirmedOrderDiscountCoupon(
      {this.code = '', this.value = 0, this.discountType = ''});

  factory ConfirmedOrderDiscountCoupon.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrderDiscountCoupon(
      code: APIHelper.getSafeStringValue(json['code']),
      value: APIHelper.getSafeDoubleValue(json['value'], 0),
      discountType: APIHelper.getSafeStringValue(json['discount_type']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'value': value,
        'discount_type': discountType,
      };
  static ConfirmedOrderDiscountCoupon getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderDiscountCoupon.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderDiscountCoupon();
}

class ConfirmedOrderPickupStation {
  String id;
  String name;
  String address;
  double charged;
  ConfirmedOrderPickupStationPickupLocation pickupLocation;

  ConfirmedOrderPickupStation({
    this.id = '',
    this.name = '',
    this.address = '',
    this.charged = 0,
    required this.pickupLocation,
  });

  factory ConfirmedOrderPickupStation.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderPickupStation(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        charged: APIHelper.getSafeDoubleValue(json['charged'], 0),
        pickupLocation: ConfirmedOrderPickupStationPickupLocation
            .getAPIResponseObjectSafeValue(json['pickup_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'charged': charged,
        'pickup_location': pickupLocation.toJson(),
      };

  factory ConfirmedOrderPickupStation.empty() => ConfirmedOrderPickupStation(
      pickupLocation: ConfirmedOrderPickupStationPickupLocation());

  static ConfirmedOrderPickupStation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderPickupStation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderPickupStation.empty();
}

class ConfirmedOrderPickupStationPickupLocation {
  double latitude;
  double longitude;

  ConfirmedOrderPickupStationPickupLocation(
      {this.latitude = 0, this.longitude = 0});

  factory ConfirmedOrderPickupStationPickupLocation.fromJson(
      Map<String, dynamic> json) {
    return ConfirmedOrderPickupStationPickupLocation(
      latitude: APIHelper.getSafeDoubleValue(json['latitude'], 0),
      longitude: APIHelper.getSafeDoubleValue(json['longitude'], 0),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static ConfirmedOrderPickupStationPickupLocation
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? ConfirmedOrderPickupStationPickupLocation.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : ConfirmedOrderPickupStationPickupLocation();
}

class ConfirmedOrderProduct {
  String product;
  ConfirmedOrderProductStore store;
  String name;
  String image;
  String unit;
  double price;
  int quantity;
  double subtotal;
  String id;

  ConfirmedOrderProduct({
    this.product = '',
    required this.store,
    this.name = '',
    this.image = '',
    this.unit = '',
    this.price = 0,
    this.quantity = 0,
    this.subtotal = 0,
    this.id = '',
  });

  factory ConfirmedOrderProduct.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderProduct(
        product: APIHelper.getSafeStringValue(json['product']),
        store: ConfirmedOrderProductStore.getAPIResponseObjectSafeValue(
            json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        price: APIHelper.getSafeDoubleValue(json['price'], 0),
        quantity: APIHelper.getSafeIntValue(json['quantity'], 0),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal'], 0),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'product': product,
        'store': store.toJson(),
        'name': name,
        'image': image,
        'unit': unit,
        'price': price,
        'quantity': quantity,
        'subtotal': subtotal,
        '_id': id,
      };

  factory ConfirmedOrderProduct.empty() =>
      ConfirmedOrderProduct(store: ConfirmedOrderProductStore.empty());

  static ConfirmedOrderProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderProduct.empty();
}

class ConfirmedOrderProductStore {
  String id;
  String name;
  String location;
  String description;
  ConfirmedOrderProductStoreVendor vendor;
  String logo;

  ConfirmedOrderProductStore({
    this.id = '',
    this.name = '',
    this.location = '',
    this.description = '',
    required this.vendor,
    this.logo = '',
  });

  factory ConfirmedOrderProductStore.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        location: APIHelper.getSafeStringValue(json['location']),
        description: APIHelper.getSafeStringValue(json['description']),
        vendor: ConfirmedOrderProductStoreVendor.getAPIResponseObjectSafeValue(
            json['vendor']),
        logo: APIHelper.getSafeStringValue(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'location': location,
        'description': description,
        'vendor': vendor.toJson(),
        'logo': logo,
      };

  factory ConfirmedOrderProductStore.empty() =>
      ConfirmedOrderProductStore(vendor: ConfirmedOrderProductStoreVendor());

  static ConfirmedOrderProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderProductStore.empty();
}

class ConfirmedOrderProductStoreVendor {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;

  ConfirmedOrderProductStoreVendor(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phone = ''});

  factory ConfirmedOrderProductStoreVendor.fromJson(
          Map<String, dynamic> json) =>
      ConfirmedOrderProductStoreVendor(
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
  static ConfirmedOrderProductStoreVendor getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderProductStoreVendor.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderProductStoreVendor();
}

class ConfirmedOrderUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String image;

  ConfirmedOrderUser({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.image = '',
  });

  factory ConfirmedOrderUser.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'image': image,
      };
  static ConfirmedOrderUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderUser();
}

class ConfirmedOrderVatApplied {
  String type;
  double value;

  ConfirmedOrderVatApplied({this.type = '', this.value = 0});

  factory ConfirmedOrderVatApplied.fromJson(Map<String, dynamic> json) =>
      ConfirmedOrderVatApplied(
        type: APIHelper.getSafeStringValue(json['type']),
        value: APIHelper.getSafeDoubleValue(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };

  static ConfirmedOrderVatApplied getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrderVatApplied.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrderVatApplied();
}
