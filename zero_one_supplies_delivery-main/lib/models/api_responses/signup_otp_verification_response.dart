import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class SignUpOtpVerificationResponse {
  bool error;
  String msg;
  String token;

  SignUpOtpVerificationResponse(
      {this.error = false, this.msg = '', this.token = ''});

  factory SignUpOtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return SignUpOtpVerificationResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      token: APIHelper.getSafeStringValue(json['token']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'token': token,
      };
  static SignUpOtpVerificationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SignUpOtpVerificationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SignUpOtpVerificationResponse();
}
