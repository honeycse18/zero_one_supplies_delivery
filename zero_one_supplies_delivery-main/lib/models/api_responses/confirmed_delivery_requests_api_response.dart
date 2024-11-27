import 'package:ecomikdeliveryapp/models/core_api_responses/paginated_data_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmedDeliveryRequestsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ConfirmedDeliveryRequest> data;

  ConfirmedDeliveryRequestsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ConfirmedDeliveryRequestsResponse.fromJson(
      Map<String, dynamic> json) {
    return ConfirmedDeliveryRequestsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.fromJson(json['data'],
          docFromJson: (data) =>
              ConfirmedDeliveryRequest.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ConfirmedDeliveryRequestsResponse.empty() =>
      ConfirmedDeliveryRequestsResponse(data: PaginatedDataResponse.empty());

  static ConfirmedDeliveryRequestsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedDeliveryRequestsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedDeliveryRequestsResponse.empty();
}

class ConfirmedDeliveryRequest {
  String id;
  String status;
  String paymentStatus;
  String deliveryNumber;
  DateTime date;
  double total;
  String paymentMethod;

  ConfirmedDeliveryRequest({
    this.id = '',
    this.status = '',
    this.paymentStatus = '',
    this.deliveryNumber = '',
    required this.date,
    this.total = 0,
    this.paymentMethod = '',
  });

  factory ConfirmedDeliveryRequest.fromJson(Map<String, dynamic> json) {
    return ConfirmedDeliveryRequest(
      id: APIHelper.getSafeStringValue(json['_id']),
      status: APIHelper.getSafeStringValue(json['status']),
      paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
      deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
      date: APIHelper.getSafeDateTimeValue(json['date'],
          dateTimePattern: 'yyyy-MM-dd', toLocal: true),
      total: APIHelper.getSafeDoubleValue(json['total']),
      paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
    );
  }

  factory ConfirmedDeliveryRequest.empty() =>
      ConfirmedDeliveryRequest(date: AppComponents.defaultUnsetDateTime);

  Map<String, dynamic> toJson() => {
        '_id': id,
        'status': status,
        'payment_status': paymentStatus,
        'delivery_number': deliveryNumber,
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date,
            toLocal: true),
        'total': total,
        'payment_method': paymentMethod,
      };

  static ConfirmedDeliveryRequest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedDeliveryRequest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedDeliveryRequest.empty();
  PaymentMethodName get paymentMethodName =>
      PaymentMethodName.toEnumValue(paymentMethod);
  OrderStatus get paymentStatusEnum => OrderStatus.toEnumValue(paymentStatus);
}
