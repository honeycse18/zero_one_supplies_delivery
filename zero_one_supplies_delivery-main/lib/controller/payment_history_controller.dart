import 'package:ecomikdeliveryapp/models/api_responses/payment_history_response.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaymentHistoryScreenController extends GetxController {
  /// Toggle value of hide new password
  final PagingController<int, PaymentHistoryItem>
      paymentHistoryPagingController = PagingController(firstPageKey: 1);

  Future<void> getPaymentHistory(int currentPageNumber) async {
    PaymentHistoryResponse? response =
        await APIRepo.getPaymentHistory(currentPageNumber);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.noNotificationFoundTransKey));
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.somethingWrongTransKey));
      return;
    }
    // log(response.toJson().toString());
    onSuccessRetrievingResponse(response);
  }

  onSuccessRetrievingResponse(PaymentHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      paymentHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    paymentHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    paymentHistoryPagingController.addPageRequestListener((pageKey) {
      getPaymentHistory(pageKey);
    });
    super.onInit();
  }
}
