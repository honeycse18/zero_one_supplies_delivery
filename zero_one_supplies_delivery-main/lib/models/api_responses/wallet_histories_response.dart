import 'package:ecomikdeliveryapp/models/core_api_responses/paginated_data_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class WalletHistoriesResponse {
  bool error;
  String msg;
  PaginatedDataResponse<WalletHistory> data;

  WalletHistoriesResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WalletHistoriesResponse.fromJson(Map<String, dynamic> json) {
    return WalletHistoriesResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(json['data'],
          docFromJson: (data) =>
              WalletHistory.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((data) => data.toJson()),
      };

  factory WalletHistoriesResponse.empty() =>
      WalletHistoriesResponse(data: PaginatedDataResponse.empty());

  static WalletHistoriesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletHistoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletHistoriesResponse.empty();
}

class WalletHistory {
  String id;
  String deliveryMan;
  double amount;
  WalletHistoryWithdrawMethod withdrawMethod;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  WalletHistory({
    this.id = '',
    this.deliveryMan = '',
    this.amount = 0,
    required this.withdrawMethod,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        id: APIHelper.getSafeStringValue(json['_id']),
        deliveryMan: APIHelper.getSafeStringValue(json['delivery_man']),
        amount: APIHelper.getSafeDoubleValue(json['amount'], 0),
        withdrawMethod:
            WalletHistoryWithdrawMethod.getAPIResponseObjectSafeValue(
                json['withdraw_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'delivery_man': deliveryMan,
        'amount': amount,
        'withdraw_method': withdrawMethod.toJson(),
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory WalletHistory.empty() => WalletHistory(
      withdrawMethod: WalletHistoryWithdrawMethod.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static WalletHistory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletHistory.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WalletHistory.empty();
}

class WalletHistoryWithdrawMethod {
  String id;
  String deliveryMan;
  String type;
  List<WalletHistoryWithdrawMethodDetail> details;
  DateTime createdAt;
  DateTime updatedAt;
  String logo;

  WalletHistoryWithdrawMethod({
    this.id = '',
    this.deliveryMan = '',
    this.type = '',
    this.details = const [],
    required this.createdAt,
    required this.updatedAt,
    this.logo = '',
  });

  factory WalletHistoryWithdrawMethod.fromJson(Map<String, dynamic> json) {
    return WalletHistoryWithdrawMethod(
      id: APIHelper.getSafeStringValue(json['_id']),
      deliveryMan: APIHelper.getSafeStringValue(json['delivery_man']),
      type: APIHelper.getSafeStringValue(json['type']),
      details: (APIHelper.getSafeListValue(json['details']))
          .map((e) =>
              WalletHistoryWithdrawMethodDetail.getAPIResponseObjectSafeValue(
                  e))
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

  factory WalletHistoryWithdrawMethod.empty() => WalletHistoryWithdrawMethod(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static WalletHistoryWithdrawMethod getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletHistoryWithdrawMethod.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletHistoryWithdrawMethod.empty();
}

class WalletHistoryWithdrawMethodDetail {
  String key;
  String value;

  WalletHistoryWithdrawMethodDetail({this.key = '', this.value = ''});

  factory WalletHistoryWithdrawMethodDetail.fromJson(
          Map<String, dynamic> json) =>
      WalletHistoryWithdrawMethodDetail(
        key: APIHelper.getSafeStringValue(json['key']),
        value: APIHelper.getSafeStringValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };

  static WalletHistoryWithdrawMethodDetail getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletHistoryWithdrawMethodDetail.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletHistoryWithdrawMethodDetail();
}
