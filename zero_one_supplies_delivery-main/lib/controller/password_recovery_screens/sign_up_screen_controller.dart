import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomikdeliveryapp/models/api_responses/user_sign_up_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegScreenController extends GetxController {
  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  final GlobalKey<FormState> userRegFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
    log("New Country selected: $countryCode");
  }

  String getPhoneFormatted() {
    return "${currentCountryCode.dialCode}${phoneController.text}";
  }

  String? nameFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.canNotBeEmptyTransKey);
      }
      if (text.length < 3) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.minimumLength3TransKey);
      }
    }
    return null;
  }

  String? passwordFormValidator(String? text) {
    if (text != null) {
      final String? passwordErrorText = Helper.passwordFormValidator(text);
      if (passwordErrorText != null) {
        return passwordErrorText;
      }
      if (text != confirmPasswordController.text) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.mustMatchConfirmPassTransKey);
      }
      return null;
    }
    return null;
  }

  String? confirmPasswordFormValidator(String? text) {
    if (text != null) {
      final String? passwordErrorText = Helper.passwordFormValidator(text);
      if (passwordErrorText != null) {
        return passwordErrorText;
      }
      if (text != passwordController.text) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.mustMatchPassTransKey);
      }
      return null;
    }
    return null;
  }

  String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.invalidEmailFormatTransKey);
      }
      return null;
    }
    return null;
  }

  String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return LanguageHelper.currentLanguageText(
            LanguageHelper.invalidPhoneFormatTransKey);
      }
      return null;
    }
    return null;
  }

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    toggleAgreeTermsConditions.value = value ?? false;
  }

  void onSignUpButtonTap() {
    if (userRegFormKey.currentState?.validate() ?? false) {
      signUp();
/*       final context = Get.context;
      if (context != null) {
        Get.toNamed(context, AppPageNames.storesignupRegScreen);
      } */
    }
  }

  Future<void> signUp() async {
    final Map<String, Object> requestBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': getPhoneFormatted(),
      'password': passwordController.text
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    UserSignUpResponse? response = await APIRepo.signUp(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessSignUp(response);
  }

  void _onSuccessSignUp(UserSignUpResponse response) async {
    /* await GetStorage()
        .write(LocalStoredKeyName.loggedInVendorToken, response.token);
    getLoggedInVendorDetails(); */
    // Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
    //     arguments: OTPScreenParameter(
    //         userInput: getPhoneFormatted(),
    //         type: 'phone',
    //         fromScreenName: FromScreenName.signupScreen));

    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.sms:
        Get.offNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                userInput: getPhoneFormatted(),
                type: 'phone',
                fromScreenName: FromScreenName.signupScreen));
        break;
      case SettingsOTPOption.email:
        Get.offNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                userInput: emailController.text,
                type: 'email',
                fromScreenName: FromScreenName.signupScreen));
        break;
      default:
    }
  }

  Future<void> getLoggedInDeliveryDetails() async {
    // UserDetailsResponse? response = await APIRepo.getUserDetails();
    // if (response == null) {
    //   onErrorGetLoggedInVendorDetails(response);
    //   return;
    // } else if (response.error) {
    //   onFailureGetLoggedInVendorDetails(response);
    //   return;
    // }
    // log((response.toJson().toString()).toString());
    // onSuccessGetLoggedInVendorDetails(response);
  }

  // void onErrorGetLoggedInVendorDetails(UserDetailsResponse? response) {}

  // void onFailureGetLoggedInVendorDetails(UserDetailsResponse response) {}

  // void onSuccessGetLoggedInVendorDetails(UserDetailsResponse response) async {
  //   await Helper.setLoggedInUserToLocalStorage(response.data);
  //   final context = Get.context;
  //   if (context != null) {
  //     Get.toNamed(AppPageNames.signUpScreen);
  //   }
  // }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
