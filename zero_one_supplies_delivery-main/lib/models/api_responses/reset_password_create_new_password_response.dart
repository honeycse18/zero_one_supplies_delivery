import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ResetPasswordCreateNewPasswordResponse {
  bool error;
  String msg;

  ResetPasswordCreateNewPasswordResponse({this.error = false, this.msg = ''});

  factory ResetPasswordCreateNewPasswordResponse.fromJson(
      Map<String, dynamic> json) {
    return ResetPasswordCreateNewPasswordResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static ResetPasswordCreateNewPasswordResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ResetPasswordCreateNewPasswordResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ResetPasswordCreateNewPasswordResponse();
}
