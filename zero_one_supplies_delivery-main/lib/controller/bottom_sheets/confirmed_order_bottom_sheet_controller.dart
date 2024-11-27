import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/confirmed_delivery_requests_api_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/confirmed_orders_api_response.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ConfirmedOrderBottomSheetController extends GetxController {
  PagingController<int, ConfirmedOrder> confirmedOrdersPagingController =
      PagingController(firstPageKey: 1);
  PagingController<int, ConfirmedDeliveryRequest>
      confirmedDeliveryRequestsPagingController =
      PagingController(firstPageKey: 1);
  bool _isCurrentTabDeliveryRequest = false;
  bool get isCurrentTabDeliveryRequest => _isCurrentTabDeliveryRequest;
  set isCurrentTabDeliveryRequest(bool value) {
    _isCurrentTabDeliveryRequest = value;
    update();
  }

  Future<void> getConfirmedOrders(int currentPageNumber) async {
    final ConfirmedOrdersAPIResponse? response =
        await APIRepo.fetchConfirmedOrders(currentPageNumber);
    if (response == null) {
      confirmedOrdersPagingController.error = response?.msg;
      return;
    } else if (response.error) {
      confirmedOrdersPagingController.error = response.msg;
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetConfirmedOrders(response);
  }

  _onSuccessGetConfirmedOrders(ConfirmedOrdersAPIResponse response) {
    if (!(Get.isBottomSheetOpen ?? false)) {
      return;
    }
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      confirmedOrdersPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    confirmedOrdersPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  Future<void> getConfirmedDeliveryRequests(int currentPageNumber) async {
    final ConfirmedDeliveryRequestsResponse? response =
        await APIRepo.fetchConfirmedDeliveryRequests(currentPageNumber);
    if (response == null) {
      confirmedOrdersPagingController.error = response?.msg;
      return;
    } else if (response.error) {
      confirmedOrdersPagingController.error = response.msg;
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetConfirmedDeliveryRequests(response);
  }

  _onSuccessGetConfirmedDeliveryRequests(
      ConfirmedDeliveryRequestsResponse response) {
    if (!(Get.isBottomSheetOpen ?? false)) {
      return;
    }
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      confirmedDeliveryRequestsPagingController
          .appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    confirmedDeliveryRequestsPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    confirmedOrdersPagingController.addPageRequestListener((pageKey) {
      getConfirmedOrders(pageKey);
    });
    confirmedDeliveryRequestsPagingController.addPageRequestListener((pageKey) {
      getConfirmedDeliveryRequests(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    confirmedOrdersPagingController.dispose();
    confirmedDeliveryRequestsPagingController.dispose();
    super.onClose();
  }
}
