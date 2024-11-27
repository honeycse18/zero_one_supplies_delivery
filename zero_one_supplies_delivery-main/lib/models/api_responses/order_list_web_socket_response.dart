import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class OrderListWebSocketResponse {
  OrderListWebSocketData data;

  OrderListWebSocketResponse({required this.data});

  factory OrderListWebSocketResponse.fromJson(Map<String, dynamic> json) {
    return OrderListWebSocketResponse(
      data: OrderListWebSocketData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };

  factory OrderListWebSocketResponse.empty() => OrderListWebSocketResponse(
        data: OrderListWebSocketData(),
      );
  static OrderListWebSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderListWebSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderListWebSocketResponse.empty();
}

class OrderListWebSocketData {
  bool reload;

  OrderListWebSocketData({this.reload = true});

  factory OrderListWebSocketData.fromJson(Map<String, dynamic> json) =>
      OrderListWebSocketData(
        reload: APIHelper.getSafeBoolValue(json['reload']),
      );

  Map<String, dynamic> toJson() => {
        'reload': reload,
      };

  static OrderListWebSocketData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderListWebSocketData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderListWebSocketData();
}
