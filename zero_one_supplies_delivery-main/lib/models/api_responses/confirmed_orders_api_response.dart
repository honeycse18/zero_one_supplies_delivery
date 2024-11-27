import 'package:ecomikdeliveryapp/models/core_api_responses/paginated_data_response.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmedOrdersAPIResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ConfirmedOrder> data;

  ConfirmedOrdersAPIResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ConfirmedOrdersAPIResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrdersAPIResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.fromJson(json['data'],
          docFromJson: (data) =>
              ConfirmedOrder.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ConfirmedOrdersAPIResponse.empty() =>
      ConfirmedOrdersAPIResponse(data: PaginatedDataResponse.empty());

  static ConfirmedOrdersAPIResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrdersAPIResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrdersAPIResponse.empty();
}
