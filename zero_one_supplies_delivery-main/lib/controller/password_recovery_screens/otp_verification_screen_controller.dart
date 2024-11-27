import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/otp_verify_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/reset_password_otp_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/send_otp_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/signup_otp_verification_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationScreenController extends GetxController {
  TextEditingController otpInputTextController = TextEditingController();

  OTPScreenParameter otpScreenParameter = OTPScreenParameter();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  _resetTimer() {
    otpTimerDuration = const Duration(minutes: 2);
  }

  onSendCodeButtonTap() {
    sendCode();
  }

  void onResendButtonTap() {
    /* if (isDurationOver()) {
      _resetTimer();
      resendCode();
    } else {
      AppDialogs.showErrorDialog(messageText: 'Please wait few more seconds');
    } */
    resendCode();
  }

  Future<void> sendCode() async {
    if (otpScreenParameter.fromScreenName ==
        FromScreenName.resetOrForgetPassScreen) {
      final Map<String, Object> requestBody = {
        'user_input': otpScreenParameter.userInput,
        'otp': otpInputTextController.text,
        'role': Constants.userRoleDelivery,
      };
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      OtpVerifyResponse? response =
          await APIRepo.verifyOtpForResetPass(requestBodyJson);
      isLoading = false;
      if (response == null) {
        APIHelper.onError(response?.msg);
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      _onSuccessResponse(response);
    } else {
      final Map<String, Object> requestBody = {
        // 'phone': otpScreenParameter.userInput,
        'otp': otpInputTextController.text,
        'role': Constants.userRoleDelivery,
      };
      switch (AppSingleton.instance.settings.otpOptionAsEnum) {
        case SettingsOTPOption.email:
          requestBody['email'] = otpScreenParameter.userInput;
          break;
        case SettingsOTPOption.sms:
          requestBody['phone'] = otpScreenParameter.userInput;
          break;
        default:
          requestBody['email'] = otpScreenParameter.userInput;
      }
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      SignUpOtpVerificationResponse? response =
          await APIRepo.signUpOtpVerification(requestBodyJson);
      isLoading = false;
      if (response == null) {
        APIHelper.onError(response?.msg);
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      _onSuccessResponseOfVendorVerify(response);
    }
  }

  Future<void> resendCode() async {
    if (otpScreenParameter.fromScreenName ==
        FromScreenName.resetOrForgetPassScreen) {
      final Map<String, Object> requestBody = {
        'user_input': otpScreenParameter.userInput,
        'type': otpScreenParameter.type,
        'role': Constants.userRoleDelivery,
      };
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      ResetPasswordOtpResponse? response =
          await APIRepo.sendResetOtp(requestBodyJson);
      isLoading = false;
      if (response == null) {
        AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
        return;
      } else if (response.error) {
        AppDialogs.showErrorDialog(messageText: response.msg);
        return;
      }
      log(response.toJson().toString());
      _onSuccessResendCode(response.msg);
    } else {
      final Map<String, Object> requestBody = {
        'role': Constants.userRoleDelivery,
      };

      switch (AppSingleton.instance.settings.otpOptionAsEnum) {
        case SettingsOTPOption.email:
          requestBody['email'] = otpScreenParameter.userInput;
          break;
        case SettingsOTPOption.sms:
          requestBody['phone'] = otpScreenParameter.userInput;
          break;
        default:
          requestBody['email'] = otpScreenParameter.userInput;
      }
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      SendOtpResponse? response =
          await APIRepo.sendVerifyUserOTP(requestBodyJson);
      isLoading = false;
      if (response == null) {
        APIHelper.onError(response?.msg);
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      _onSuccessResendCode(response.msg);
    }
  }

  // For resending otp for Reset Password
  void _onSuccessResendCode(String responseMessage) {
    Helper.showSnackBar(responseMessage);
    _resetTimer();
  }

  void _onSuccessResponse(OtpVerifyResponse response) {
    Get.offNamed(AppPageNames.passwordRecoveryCreateScreen,
        arguments: response.token);
  }

  void _onSuccessResponseOfVendorVerify(
      SignUpOtpVerificationResponse response) {
    if (otpScreenParameter.fromScreenName ==
        FromScreenName.resetOrForgetPassScreen) {
      Get.offNamed(AppPageNames.signInScreen);
    } else {
      Get.offNamed(AppPageNames.setupDeliveryManInfoScreen,
          arguments: response.token);
    }
  }

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  /// OTP timer duration value
  Duration otpTimerDuration = const Duration();

  /// OTP timer
  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is OTPScreenParameter) {
      otpScreenParameter = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    otpTimerDuration = const Duration(minutes: 2);
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
      }
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    if (otpTimer.isActive) {
      otpTimer.cancel();
    }
    super.dispose();
  }
}
