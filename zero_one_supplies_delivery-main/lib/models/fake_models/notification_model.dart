import 'package:flutter/material.dart';

class FakeNotificationDateGroupModel {
  String dateHumanReadableText;
  List<FakeNotificationModel> groupNotifications;
  FakeNotificationDateGroupModel({
    required this.dateHumanReadableText,
    required this.groupNotifications,
  });
}

class FakeNotificationModel {
  String name;
  String timeText;
  bool isRead;
  List<FakeNotificationTextModel> texts;
  ImageProvider<Object> image;
  FakeNotificationModel({
    required this.name,
    required this.timeText,
    required this.isRead,
    required this.texts,
    required this.image,
  });
}

class FakeNotificationTextModel {
  String text;
  bool isHashText;
  bool isColoredText;
  bool isBoldText;
  FakeNotificationTextModel({
    required this.text,
    this.isHashText = false,
    this.isColoredText = false,
    this.isBoldText = false,
  });
}
