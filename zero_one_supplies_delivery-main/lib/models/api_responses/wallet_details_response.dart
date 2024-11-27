import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';

class WalletDetailsResponse {
  bool error;
  String msg;
  WalletDetails data;

  WalletDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WalletDetailsResponse.fromJson(Map<String, dynamic> json) {
    return WalletDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: WalletDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory WalletDetailsResponse.empty() =>
      WalletDetailsResponse(data: WalletDetails());

  static WalletDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletDetailsResponse.empty();
}

class WalletDetails {
  double totalEarning;
  double totalWithdraw;
  double currentBalance;
  List<SavedWithdrawMethod> savedWithdrawMethods;

  WalletDetails({
    this.totalEarning = 0,
    this.totalWithdraw = 0,
    this.currentBalance = 0,
    this.savedWithdrawMethods = const [],
  });

  factory WalletDetails.fromJson(Map<String, dynamic> json) => WalletDetails(
        totalEarning: APIHelper.getSafeDoubleValue(json['total_earning'], 0),
        totalWithdraw: APIHelper.getSafeDoubleValue(json['total_withdraw'], 0),
        currentBalance: APIHelper.getSafeDoubleValue(json['current_balance']),
        savedWithdrawMethods: (APIHelper.getSafeListValue(
                json['saved_withdraw_methods']))
            .map((e) => SavedWithdrawMethod.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total_earning': totalEarning,
        'total_withdraw': totalWithdraw,
        'current_balance': currentBalance,
        'saved_withdraw_methods':
            savedWithdrawMethods.map((e) => e.toJson()).toList(),
      };

  static WalletDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WalletDetails();
}

class SavedWithdrawMethod {
  String id;
  String deliveryMan;
  String type;
  List<SavedWithdrawMethodDetail> details;
  DateTime createdAt;
  DateTime updatedAt;
  String logo;

  SavedWithdrawMethod({
    this.id = '',
    this.deliveryMan = '',
    this.type = '',
    this.details = const [],
    required this.createdAt,
    required this.updatedAt,
    this.logo = '',
  });

  factory SavedWithdrawMethod.fromJson(Map<String, dynamic> json) {
    return SavedWithdrawMethod(
      id: APIHelper.getSafeStringValue(json['_id']),
      deliveryMan: APIHelper.getSafeStringValue(json['delivery_man']),
      type: APIHelper.getSafeStringValue(json['type']),
      details: APIHelper.getSafeListValue(json['details'])
          .map(
              (e) => SavedWithdrawMethodDetail.getAPIResponseObjectSafeValue(e))
          .toList(),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      logo: APIHelper.getSafeStringValue(json['logo']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'delivery_man': deliveryMan,
        'type': type,
        'details': details.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'logo': logo,
      };

  factory SavedWithdrawMethod.empty() => SavedWithdrawMethod(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static SavedWithdrawMethod getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedWithdrawMethod.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedWithdrawMethod.empty();
}

class SavedWithdrawMethodDetail {
  String key;
  String value;

  SavedWithdrawMethodDetail({this.key = '', this.value = ''});

  factory SavedWithdrawMethodDetail.fromJson(Map<String, dynamic> json) =>
      SavedWithdrawMethodDetail(
        key: APIHelper.getSafeStringValue(json['key']),
        value: APIHelper.getSafeStringValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  static SavedWithdrawMethodDetail getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedWithdrawMethodDetail.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedWithdrawMethodDetail();
}
