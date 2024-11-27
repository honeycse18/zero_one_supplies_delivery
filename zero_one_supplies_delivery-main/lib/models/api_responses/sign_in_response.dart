import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class SignInResponse {
  bool error;
  String msg;
  String token;
  String role;
  String phone;
  bool verified;
  bool active;

  SignInResponse({
    this.error = false,
    this.msg = '',
    this.token = '',
    this.role = '',
    this.phone = '',
    this.verified = false,
    this.active = false,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      token: APIHelper.getSafeStringValue(json['token']),
      role: APIHelper.getSafeStringValue(json['role']),
      phone: APIHelper.getSafeStringValue(json['phone']),
      verified: APIHelper.getSafeBoolValue(json['verified']),
      active: APIHelper.getSafeBoolValue(json['active']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'token': token,
        'role': role,
        'phone': phone,
        'verified': verified,
        'active': active,
      };

  static SignInResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SignInResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SignInResponse();
}
