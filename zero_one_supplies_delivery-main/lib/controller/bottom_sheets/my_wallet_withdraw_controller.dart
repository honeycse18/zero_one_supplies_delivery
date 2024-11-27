import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWalletWithdrawBottomSheetController extends GetxController {
  bool isSelected = false;
  TextEditingController withdrawAmountController = TextEditingController();

  @override
  void onClose() {
    withdrawAmountController.dispose();
    super.onClose();
  }
}
