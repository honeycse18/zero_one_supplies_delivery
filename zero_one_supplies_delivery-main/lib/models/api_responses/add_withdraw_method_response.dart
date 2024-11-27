import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class AddWithdrawMethodResponse {
  bool error;
  String msg;

  AddWithdrawMethodResponse({this.error = false, this.msg = ''});

  factory AddWithdrawMethodResponse.fromJson(Map<String, dynamic> json) {
    return AddWithdrawMethodResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static AddWithdrawMethodResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AddWithdrawMethodResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AddWithdrawMethodResponse();
}
