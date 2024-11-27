import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/language_translations_response.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */
  Future<void> delayAndGotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // In case, the screen is not shown after 2 seconds, Do nothing.
    // Go to intro screen
    Get.offNamedUntil(_pageRouteName, (_) => false);
  }

  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      if (Helper.isRememberedMe()) {
        pageRouteName = AppPageNames.homeScreen;
      } else {
        pageRouteName = AppPageNames.signInScreen;
      }
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

  static Future<void> getLanguageTranslations() async {
    LanguageTranslationsResponse? response =
        await APIRepo.fetchLanguageTranslations();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguageTranslations(response);
  }

  static void _onSuccessGetLanguageTranslations(
      LanguageTranslationsResponse response) async {
    dynamic defaultLanguage =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    bool isDefaultLanguageSet = (defaultLanguage is String);
    for (LanguageTranslation languageTranslation in response.data) {
      languageTranslation.translation[Constants.languageTranslationKeyCode] =
          '${languageTranslation.code}_${languageTranslation.flag}';
      await AppSingleton.instance.localBox
          .put(languageTranslation.name, languageTranslation.translation);
      if (!isDefaultLanguageSet && languageTranslation.isDefault) {
        await AppSingleton.instance.localBox
            .put(Constants.hiveDefaultLanguageKey, languageTranslation.name);
      }
    }
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    delayAndGotoNextScreen();
    APIHelper.getSiteSettings();
    getLanguageTranslations();
    super.onInit();
  }
}
