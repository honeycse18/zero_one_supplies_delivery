import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class DeliveryManRegResponse {
  bool error;
  String msg;
  DeliveryManDataResponse data;

  DeliveryManRegResponse(
      {this.error = true, this.msg = '', required this.data});

  factory DeliveryManRegResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryManRegResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: DeliveryManDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };
  factory DeliveryManRegResponse.empty() =>
      DeliveryManRegResponse(data: DeliveryManDataResponse.empty());

  static DeliveryManRegResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryManRegResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryManRegResponse.empty();
}

class DeliveryManDataResponse {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String role;
  bool deliveryService;
  DeliveryManResponse deliveryMan;

  DeliveryManDataResponse({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.deliveryService = false,
    required this.deliveryMan,
  });

  factory DeliveryManDataResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryManDataResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        role: APIHelper.getSafeStringValue(json['role']),
        deliveryService: APIHelper.getSafeBoolValue(json['delivery_service']),
        deliveryMan: DeliveryManResponse.getAPIResponseObjectSafeValue(
            json['delivery_man']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'role': role,
        'delivery_service': deliveryService,
        'delivery_man': deliveryMan.toJson(),
      };
  factory DeliveryManDataResponse.empty() =>
      DeliveryManDataResponse(deliveryMan: DeliveryManResponse.empty());

  static DeliveryManDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryManDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryManDataResponse.empty();
}

class DeliveryManResponse {
  String id;
  String address;
  String image;
  String nidNumber;
  String nidImage;
  String addressProof;
  String taxName;
  String taxNumber;
  String status;
  String deliveryMan;
  String country;
  String state;
  String city;
  String zipCode;
  String pickupStation;
  DateTime createdAt;
  DateTime updatedAt;

  DeliveryManResponse({
    this.id = '',
    this.address = '',
    this.image = '',
    this.nidNumber = '',
    this.nidImage = '',
    this.addressProof = '',
    this.taxName = '',
    this.taxNumber = '',
    this.status = '',
    this.deliveryMan = '',
    this.country = '',
    this.state = '',
    this.city = '',
    this.zipCode = '',
    this.pickupStation = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryManResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryManResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
        image: APIHelper.getSafeStringValue(json['image']),
        nidNumber: APIHelper.getSafeStringValue(json['nid_number']),
        nidImage: APIHelper.getSafeStringValue(json['nid_image']),
        addressProof: APIHelper.getSafeStringValue(json['address_proof']),
        taxName: APIHelper.getSafeStringValue(json['tax_name']),
        taxNumber: APIHelper.getSafeStringValue(json['tax_number']),
        status: APIHelper.getSafeStringValue(json['status']),
        deliveryMan: APIHelper.getSafeStringValue(json['delivery_man']),
        country: APIHelper.getSafeStringValue(json['country']),
        state: APIHelper.getSafeStringValue(json['state']),
        city: APIHelper.getSafeStringValue(json['city']),
        zipCode: APIHelper.getSafeStringValue(json['zipcode']),
        pickupStation: APIHelper.getSafeStringValue(json['pickup_station']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'address': address,
        'image': image,
        'nid_number': nidNumber,
        'nid_image': nidImage,
        'address_proof': addressProof,
        'tax_name': taxName,
        'tax_number': taxNumber,
        'status': status,
        'delivery_man': deliveryMan,
        'country': country,
        'state': state,
        'city': city,
        'zipcode': zipCode,
        'pickup_station': pickupStation,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };
  factory DeliveryManResponse.empty() => DeliveryManResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static DeliveryManResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryManResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryManResponse.empty();
}
