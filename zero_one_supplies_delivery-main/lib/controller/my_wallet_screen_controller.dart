import 'dart:convert';
import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/wallet_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/wallet_histories_response.dart';
import 'package:ecomikdeliveryapp/models/core_api_responses/raw_api_response.dart';
import 'package:ecomikdeliveryapp/screens/bottom_sheets/add_new_payment.dart';
import 'package:ecomikdeliveryapp/screens/bottom_sheets/my_wallet_withdraw.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyWalletScreenController extends GetxController {
  int selectedPaymentOptionIndex = -1;
  SavedWithdrawMethod selectedSavedWithdrawMethod = SavedWithdrawMethod.empty();
  WalletDetails walletDetails = WalletDetails();
  PagingController<int, WalletHistory> walletHistoryController =
      PagingController(firstPageKey: 1);

  void onWithdrawMethodTap(SavedWithdrawMethod value) {
    selectedSavedWithdrawMethod = value;
    update();
  }

  void onWithdrawRadioChange(SavedWithdrawMethod value) {
    onWithdrawMethodTap(value);
  }

  void onWithdrawButtonTap() async {
    final dynamic result =
        await Get.bottomSheet(const MyWalletWithdrawBottomSheet());
    if (result is String) {
      log(result);
      final double? amount = double.tryParse(result);
      if (amount == null) {
        AppDialogs.showErrorDialog(
            messageText: LanguageHelper.currentLanguageText(
                LanguageHelper.mustEnterAmountTransKey));
        return;
      }
      makeWithdraw(
          amount: amount, withdrawMethodID: selectedSavedWithdrawMethod.id);
    }
  }

  void onAddNewButtonTap() async {
    final dynamic result = await Get.bottomSheet(
        const AddNewPaymentBottomSheet(),
        isScrollControlled: true,
        ignoreSafeArea: false);
    if (result is SiteSettingsWithdrawMethodResponse) {
      Get.toNamed(AppPageNames.addWithdrawMethodScreen, arguments: result);
    }
  }

  Future<void> getWalletDetails() async {
    final WalletDetailsResponse? response = await APIRepo.fetchWalletDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetWalletDetails(response);
  }

  _onSuccessGetWalletDetails(WalletDetailsResponse response) async {
    walletDetails = response.data;
    update();
  }

  Future<void> getWalletHistories(int pageNumber) async {
    final WalletHistoriesResponse? response =
        await APIRepo.fetchWalletHistories();
    if (response == null) {
      // APIHelper.onError(response?.msg);
      walletHistoryController.error = response;
      return;
    } else if (response.error) {
      // APIHelper.onFailure(response.msg);
      walletHistoryController.error = response;
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetWalletHistories(response);
  }

  _onSuccessGetWalletHistories(WalletHistoriesResponse response) async {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      // walletHistoryController.appendLastPage([]);
      walletHistoryController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    walletHistoryController.appendPage(response.data.docs, nextPageNumber);
  }

  Future<void> makeWithdraw(
      {required double amount, required String withdrawMethodID}) async {
    final Map<String, dynamic> requestBody = {
      'amount': amount,
      'withdraw_method': withdrawMethodID,
    };
    final String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.makeWithdraw(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.noResponseFoundTransKey));
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessMakeWithdraw(response);
  }

  _onSuccessMakeWithdraw(RawAPIResponse response) async {
    AppDialogs.showSuccessDialog(messageText: response.msg);
    getWalletDetails();
    walletHistoryController.refresh();
    update();
  }

  @override
  void onInit() {
    getWalletDetails();
    walletHistoryController.addPageRequestListener((pageKey) {
      getWalletHistories(pageKey);
    });
    super.onInit();
  }
}
