import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  /// Page controller for managing intro content sequences.
  final PageController pageController = PageController(keepPage: false);

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  @override
  void onReady() {
    _setNotificationPermission();
    super.onReady();
  }
}
