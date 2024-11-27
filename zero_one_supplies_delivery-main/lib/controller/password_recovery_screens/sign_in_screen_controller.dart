import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/send_otp_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/sign_in_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_local_stored_keys.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInScreenController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  /// Toggle value of remember me
  ///
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();

  RxBool toggleRememberLogin = false.obs;
  RxBool toggleHidePassword = true.obs;

  void onRememberMeToggle(bool value) async {
    toggleRememberLogin.value = value;
    await GetStorage().write(LocalStoredKeyName.rememberMe, value);
    update();
  }

  void onSignInButtonTap() {
    signIn();
  }

  void onPasswordHideButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onForgotPasswordButtonTap() {
    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        // Go to password recovery enter email address screen
        Get.toNamed(AppPageNames.passwordRecoveryEmailPromptScreen);
        break;
      case SettingsOTPOption.sms:
        // Go to password recovery enter phone number screen
        Get.toNamed(AppPageNames.passwordRecoveryPromptScreen);
        break;
      default:
    }
/*     // Goto verification method selection screen.
    Get.toNamed(AppPageNames.passwordRecoverySelectScreen); */
  }

  Future<void> signIn() async {
    final Map<String, Object> requestBody = {
      'email': emailTextEditingController.text,
      'password': passTextEditingController.text,
      'remember_me': toggleRememberLogin.value,
    };
    final String? fcmToken = await Helper.getFCMToken;
    if (fcmToken != null) {
      requestBody['fcm_token'] = fcmToken;
    }
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    SignInResponse? response = await APIRepo.login(requestBodyJson);
    if (response == null) {
      isLoading = false;
      onErrorSignIn(response);
      return;
    } else if (response.error) {
      isLoading = false;
      onFailureSignIn(response);
      return;
    } else if (response.role != Constants.userRoleDelivery) {
      isLoading = false;
      onWrongUserTypeSignIn();
      return;
    } else if (!response.verified) {
      isLoading = false;
      onUnVerifiedSignIn(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessSignIn(response);
  }

  void onErrorSignIn(SignInResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureSignIn(SignInResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onWrongUserTypeSignIn() {
    AppDialogs.showErrorDialog(
        messageText: LanguageHelper.currentLanguageText(
            LanguageHelper.userDoesNotExistTransKey));
  }

  void onSuccessSignIn(SignInResponse response) async {
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDeliveryToken, response.token);
    getLoggedInUserDetails();
  }

  Future<void> onUnVerifiedSignIn(SignInResponse response) async {
    final Object? dialogResult = await AppDialogs.showActionableDialog(
        messageText: LanguageHelper.currentLanguageText(
            LanguageHelper.yourAccountNotVerifiedTransKey),
        buttonText: LanguageHelper.currentLanguageText(
            LanguageHelper.verifyNowTransKey),
        onTap: () {
          Get.back(result: true);
        });
    sendOTPCode(response);
    // if (dialogResult is bool) {
    // if (dialogResult) {
    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                userInput: emailTextEditingController.text,
                type: 'email',
                fromScreenName: FromScreenName.signupScreen));
        break;
      case SettingsOTPOption.sms:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                userInput: response.phone,
                type: 'phone',
                fromScreenName: FromScreenName.signupScreen));
      default:
    }
    // Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
    //     arguments: OTPScreenParameter(
    //         userInput: response.phone,
    //         type: 'phone',
    //         fromScreenName: FromScreenName.signupScreen));
    // }
    // }
  }

  Future<void> getLoggedInUserDetails() async {
    DeliveryManDetailsResponse? response = await APIRepo.getUserDetails();
    isLoading = false;
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onErrorGetLoggedInUserDetails(DeliveryManDetailsResponse? response) {}

  void onFailureGetLoggedInUserDetails(DeliveryManDetailsResponse response) {}

  void onSuccessGetLoggedInUserDetails(
      DeliveryManDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    Get.offAllNamed(AppPageNames.homeScreen);
  }

  Future<void> sendOTPCode(SignInResponse responseBefore) async {
    final Map<String, Object> requestBody = {
      'phone': responseBefore.phone,
      'role': Constants.userRoleDelivery,
    };

    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        requestBody['email'] = emailTextEditingController.text;
        break;
      case SettingsOTPOption.sms:
        requestBody['phone'] = responseBefore.phone;
        break;
      default:
        requestBody['email'] = emailTextEditingController.text;
    }
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    SendOtpResponse? response =
        await APIRepo.sendVerifyUserOTP(requestBodyJson);
    isLoading = false;
    if (response == null) {
      onErrorSendOTP(response);
      return;
    } else if (response.error) {
      onFailureSendOTP(response);
      return;
    }
    log(response.toJson().toString());
  }

  void onErrorSendOTP(SendOtpResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureSendOTP(SendOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is bool) {
      final isSessionExpired = argument;
      if (isSessionExpired) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .sessionExpiredPleaseLoginTransKey.toCurrentLanguage);
      }
    }
  }

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  @override
  void onInit() {
    _getScreenParameter();
    toggleRememberLogin.value = Helper.isRememberedMe();
    super.onInit();
  }

  @override
  void onReady() {
    _setNotificationPermission();
    super.onReady();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    passTextEditingController.dispose();
    super.onClose();
  }
}
