import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/add_withdraw_method_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMethodScreenController extends GetxController {
  SiteSettingsWithdrawMethodResponse targetMethod =
      SiteSettingsWithdrawMethodResponse();

  DeliveryManDataResponse deliveryManDetails = Helper.getUser();

  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountHolderEmailController = TextEditingController();

  void checkInit() {
    log(targetMethod.name);
  }

  void onAddButtonTap() {
    if (accountHolderNameController.text.isEmpty ||
        accountHolderEmailController.text.isEmpty) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.youMustProvideInfoTransKey));
      return;
    }
    AppDialogs.showSuccessDialog(
        messageText: LanguageHelper.currentLanguageText(
            LanguageHelper.addingYourInfoTransKey));
    proceedAddingPayment();
  }

  Future<void> proceedAddingPayment() async {
    // final Map<String, dynamic> details = {
    //   'account_holder_name': accountHolderNameController.text,
    //   'email': accountHolderEmailController.text
    // };
    final Map<String, dynamic> requestBody = {
      'type': targetMethod.name,
      'logo': targetMethod.logo,
      'details': <String, dynamic>{
        'account_holder_name': accountHolderNameController.text,
        'email': accountHolderEmailController.text
      },
    };
    final String requestBodyJson = jsonEncode(requestBody);
    AddWithdrawMethodResponse? response =
        await APIRepo.addWithdrawMethod(requestBodyJson);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.noResponseFoundTransKey));
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessResponse(response);
  }

  onSuccessResponse(AddWithdrawMethodResponse response) {
    Get.offNamed(AppPageNames.cardPlacedSuccessScreen);
  }

  getScreenParameters() {
    final parameter = Get.arguments;
    if (parameter is SiteSettingsWithdrawMethodResponse) {
      targetMethod = parameter;
    }
  }

  @override
  void onInit() {
    getScreenParameters();
    checkInit();
    super.onInit();
  }
}
