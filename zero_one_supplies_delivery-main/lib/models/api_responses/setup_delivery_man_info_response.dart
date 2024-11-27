import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class SetupDeliveryManInfoResponse {
  bool error;
  String msg;

  SetupDeliveryManInfoResponse({this.error = false, this.msg = ''});

  factory SetupDeliveryManInfoResponse.fromJson(Map<String, dynamic> json) {
    return SetupDeliveryManInfoResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static SetupDeliveryManInfoResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SetupDeliveryManInfoResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SetupDeliveryManInfoResponse();
}
