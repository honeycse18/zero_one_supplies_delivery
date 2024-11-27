import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordRecoveryCreatePasswordScreenController extends GetxController {
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

  /// Password strong level value
  PasswordStrongLevel passwordStrongLevel = PasswordStrongLevel.none;

  /// Find if any password text character has number digit.
  RxBool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]')).obs;

  /// Check password
  void passwordCheck(String passwordText) {
    setPasswordStrongLevel(passwordText);
    if (passwordText.length > 5) {
      isPasswordOver5Characters.value = true;
    } else {
      isPasswordOver5Characters.value = false;
    }
    if (detectPasswordNumber(passwordText).value) {
      isPasswordHasAtLeastSingleNumberDigit.value = true;
    } else {
      isPasswordHasAtLeastSingleNumberDigit.value = false;
    }
  }

  /// Simple password strong level algorithm form new password field
  void setPasswordStrongLevel(String passwordText) {
    final isNumberFound = detectPasswordNumber(passwordText).value;
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

  @override
  void onInit() {
    newPasswordEditingController = TextEditingController();
    newPasswordEditingController.addListener(() {
      // if (mounted) {

      passwordCheck(newPasswordEditingController.text);

      // }
    });
    super.onInit();
  }
}
