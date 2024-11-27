import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class TermsConditionResponse {
  bool error;
  String msg;
  TermsConditionShortItem data;

  TermsConditionResponse(
      {this.error = false, this.msg = '', required this.data});

  factory TermsConditionResponse.fromJson(Map<String, dynamic> json) {
    return TermsConditionResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: TermsConditionShortItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory TermsConditionResponse.empty() => TermsConditionResponse(
        data: TermsConditionShortItem.empty(),
      );

  static TermsConditionResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TermsConditionResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TermsConditionResponse.empty();
}

class TermsConditionShortItem {
  String id;
  String title;
  String description;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String key;

  TermsConditionShortItem({
    this.id = '',
    this.title = '',
    this.description = '',
    this.status = false,
    required this.createdAt,
    required this.updatedAt,
    this.key = '',
  });

  factory TermsConditionShortItem.fromJson(Map<String, dynamic> json) =>
      TermsConditionShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        title: APIHelper.getSafeStringValue(json['title']),
        description: APIHelper.getSafeStringValue(json['description']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        key: APIHelper.getSafeStringValue(json['key']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'key': key,
      };

  factory TermsConditionShortItem.empty() => TermsConditionShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  static TermsConditionShortItem getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TermsConditionShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TermsConditionShortItem.empty();
}
