import 'package:ecomikdeliveryapp/models/core_api_responses/paginated_data_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class PaymentHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<PaymentHistoryItem> data;

  PaymentHistoryResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            PaymentHistoryItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory PaymentHistoryResponse.empty() =>
      PaymentHistoryResponse(data: PaginatedDataResponse.empty());
  static PaymentHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaymentHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PaymentHistoryResponse.empty();
}

class PaymentHistoryItem {
  String id;
  String deliveryMan;
  String order;
  String delivery;
  double amount;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentHistoryItem({
    this.id = '',
    this.deliveryMan = '',
    this.order = '',
    this.delivery = '',
    this.amount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        deliveryMan: APIHelper.getSafeStringValue(json['delivery_man']),
        order: APIHelper.getSafeStringValue(json['order']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'delivery_man': deliveryMan,
        'order': order,
        'delivery': delivery,
        'amount': amount,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory PaymentHistoryItem.empty() => PaymentHistoryItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static PaymentHistoryItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaymentHistoryItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PaymentHistoryItem.empty();
}
