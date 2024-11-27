import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/reset_password_create_new_password_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreenController extends GetxController {
  String authToken = '_theToken';
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  /// Toggle value of hide new password
  RxBool toggleHideNewPassword = true.obs;

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;

  /// Toggle value of over 5 characters requirement
  RxBool isPasswordOver5Characters = false.obs;

  /// Toggle value of at least 1 digit number
  RxBool isPasswordHasAtLeastSingleNumberDigit = false.obs;

  /// Create new password editing controller
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController newConfirmPasswordEditingController =
      TextEditingController();

  /// Password strong level value
  PasswordStrongLevel passwordStrongLevel = PasswordStrongLevel.none;

  /// Find if any password text character has number digit.
  bool _detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));

  /// Check password
  void _passwordCheck(String passwordText) {
    _setPasswordStrongLevel(passwordText);
    if (passwordText.length > 5) {
      isPasswordOver5Characters.value = true;
    } else {
      isPasswordOver5Characters.value = false;
    }
    if (_detectPasswordNumber(passwordText)) {
      isPasswordHasAtLeastSingleNumberDigit.value = true;
    } else {
      isPasswordHasAtLeastSingleNumberDigit.value = false;
    }
  }

  /// Simple password strong level algorithm form new password field
  void _setPasswordStrongLevel(String passwordText) {
    final isNumberFound = _detectPasswordNumber(passwordText);
    if (passwordText.isEmpty) {
      passwordStrongLevel = PasswordStrongLevel.none;
    } else {
      if (passwordText.length > 5 && isNumberFound) {
        passwordStrongLevel = PasswordStrongLevel.strong;
        if (passwordText.length > 11 && isNumberFound) {
          passwordStrongLevel = PasswordStrongLevel.veryStrong;
        }
      } else if (passwordText.length > 5) {
        passwordStrongLevel = PasswordStrongLevel.normal;
      } else {
        passwordStrongLevel = PasswordStrongLevel.weak;
      }
    }
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      authToken = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    newPasswordEditingController = TextEditingController();
    newPasswordEditingController.addListener(() {
      _passwordCheck(newPasswordEditingController.text);
      update();
    });
    super.onInit();
  }

  onSavePasswordButtonTap() {
    savePassword();
  }

  Future<void> savePassword() async {
    final Map<String, Object> requestBody = {
      'password': newPasswordEditingController.text,
      'confirmPassword': newConfirmPasswordEditingController.text,
      'role': Constants.userRoleDelivery,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    ResetPasswordCreateNewPasswordResponse? response =
        await APIRepo.resetPassCreateNewPass(requestBodyJson, authToken);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSavePassword(response);
  }

  void onSuccessSavePassword(ResetPasswordCreateNewPasswordResponse response) {
    Get.offNamed(AppPageNames.passwordChangeSuccessScreen);
  }
}
