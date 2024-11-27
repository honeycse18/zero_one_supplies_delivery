import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class PickUpStationsResponse {
  bool error;
  PickUpStationDataResponse data;

  PickUpStationsResponse({this.error = false, required this.data});

  factory PickUpStationsResponse.fromJson(Map<String, dynamic> json) {
    return PickUpStationsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      data:
          PickUpStationDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson(),
      };

  factory PickUpStationsResponse.empty() =>
      PickUpStationsResponse(data: PickUpStationDataResponse());

  static PickUpStationsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickUpStationsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickUpStationsResponse.empty();
}

class PickUpStationDataResponse {
  List<PickUpStationDocResponse> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  PickUpStationDataResponse({
    this.docs = const [],
    this.totalDocs = 0,
    this.limit = 0,
    this.page = 0,
    this.totalPages = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory PickUpStationDataResponse.fromJson(Map<String, dynamic> json) =>
      PickUpStationDataResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) =>
                PickUpStationDocResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        page: APIHelper.getSafeIntValue(json['page']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        pagingCounter: APIHelper.getSafeIntValue(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        prevPage: APIHelper.getSafeIntValue(json['prevPage']),
        nextPage: APIHelper.getSafeIntValue(json['nextPage']),
      );

  Map<String, dynamic> toJson() => {
        'docs': docs.map((e) => e.toJson()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  static PickUpStationDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickUpStationDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickUpStationDataResponse();
}

class PickUpStationDocResponse {
  String id;
  String name;
  String address;
  PickUpStationLocationResponse location;
  int charge;
  int estimatedDay;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  PickUpStationDocResponse({
    this.id = '',
    this.name = '',
    this.address = '',
    required this.location,
    this.charge = 0,
    this.estimatedDay = 0,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PickUpStationDocResponse.fromJson(Map<String, dynamic> json) =>
      PickUpStationDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: PickUpStationLocationResponse.getAPIResponseObjectSafeValue(
            json['location']),
        charge: APIHelper.getSafeIntValue(json['charge']),
        estimatedDay: APIHelper.getSafeIntValue(json['estimated_day']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
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
      };

  factory PickUpStationDocResponse.empty() => PickUpStationDocResponse(
      location: PickUpStationLocationResponse(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static PickUpStationDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickUpStationDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickUpStationDocResponse.empty();
}

class PickUpStationLocationResponse {
  int latitude;
  int longitude;

  PickUpStationLocationResponse({this.latitude = 0, this.longitude = 0});

  factory PickUpStationLocationResponse.fromJson(Map<String, dynamic> json) =>
      PickUpStationLocationResponse(
        latitude: APIHelper.getSafeIntValue(json['latitude']),
        longitude: APIHelper.getSafeIntValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static PickUpStationLocationResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickUpStationLocationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickUpStationLocationResponse();
}
