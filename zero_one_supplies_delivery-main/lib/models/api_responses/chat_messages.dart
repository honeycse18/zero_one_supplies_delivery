import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';

class ChatMessages {
  String user;
  List<ChatMessage> messages;

  ChatMessages({this.user = '', this.messages = const []});

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
        user: APIHelper.getSafeStringValue(json['user']),
        messages: APIHelper.getSafeListValue(json['messages'])
            .map((e) => ChatMessage.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'messages': messages.map((e) => e.toJson()).toList(),
      };

  static ChatMessages getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessages.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChatMessages();
}

class ChatMessage {
  String id;
  String from;
  String to;
  String message;
  String attachFileURL;
  String fileName;
  bool delivered;
  bool seen;
  DateTime createdAt;

  ChatMessage({
    this.id = '',
    this.from = '',
    this.to = '',
    this.attachFileURL = '',
    this.fileName = '',
    this.message = '',
    this.delivered = false,
    this.seen = false,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: APIHelper.getSafeStringValue(json['_id']),
        from: APIHelper.getSafeStringValue(json['from']),
        to: APIHelper.getSafeStringValue(json['to']),
        attachFileURL: APIHelper.getSafeStringValue(json['attach_file']),
        fileName: APIHelper.getSafeStringValue(json['file_name']),
        message: APIHelper.getSafeStringValue(json['message']),
        delivered: APIHelper.getSafeBoolValue(json['delivered']),
        seen: APIHelper.getSafeBoolValue(json['seen']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'from': from,
        'to': to,
        'attach_file': attachFileURL,
        'file_name': fileName,
        'message': message,
        'delivered': delivered,
        'seen': seen,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory ChatMessage.empty() =>
      ChatMessage(createdAt: AppComponents.defaultUnsetDateTime);

  static ChatMessage getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessage.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChatMessage.empty();
}
