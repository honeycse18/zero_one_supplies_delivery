import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  /// Toggle value of popup notification
  RxBool togglePopupNotification = true.obs;

  /// Toggle value of text notification
  RxBool toggleTextNotification = false.obs;

  String get currentLanguageText {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      return currentLanguageName;
    }
    return '';
  }
}
