import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ConfirmedOrdersResponse {
  String type;
  List<ConfirmedOrder> orders;
  ConfirmedOrdersResponse({this.type = '', this.orders = const []});

  factory ConfirmedOrdersResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrdersResponse(
      type: APIHelper.getSafeStringValue(json['type']),
      orders: APIHelper.getSafeListValue(json['orders'])
          .map((e) => ConfirmedOrder.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'orders': orders.map((e) => e.toJson()).toList(),
      };

  static ConfirmedOrdersResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ConfirmedOrdersResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ConfirmedOrdersResponse();
}
