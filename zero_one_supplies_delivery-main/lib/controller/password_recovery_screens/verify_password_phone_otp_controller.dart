import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomikdeliveryapp/models/api_responses/reset_password_otp_response.dart';
import 'package:ecomikdeliveryapp/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPhoneOtpController extends GetxController {
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  void onSendCodeButtonTap() {
    sendCode();
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
    log("New Country selected: $countryCode");
  }

  String getPhoneFormatted() {
    return "${currentCountryCode.dialCode}${phoneTextEditingController.text}";
  }

  Future<void> sendCode() async {
    final Map<String, Object> requestBody = {
      'user_input': getPhoneFormatted(),
      'type': 'phone',
      'role': Constants.userRoleDelivery,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    ResetPasswordOtpResponse? response =
        await APIRepo.sendResetOtp(requestBodyJson);
    isLoading = false;
    if (response == null) {
      onErrorSendCode(response!); //Need to fix this line
      return;
    } else if (response.error) {
      onFailureSendCode(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessSendCode();
  }

  void onErrorSendCode(ResetPasswordOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onFailureSendCode(ResetPasswordOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessSendCode() {
    Get.offNamed(AppPageNames.passwordRecoveryVerificationScreen,
        arguments: OTPScreenParameter(
            userInput: phoneTextEditingController.text, type: 'phone'));
  }
}
