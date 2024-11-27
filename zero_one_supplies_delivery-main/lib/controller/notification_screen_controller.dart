import 'dart:developer';

import 'package:ecomikdeliveryapp/models/api_responses/user_notification_response.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DeliveryNotificationScreenController extends GetxController {
  final PagingController<int, UserNotificationDocResponse>
      userNotificationPagingController = PagingController(firstPageKey: 1);

  UserNotificationDocResponse? previousNotification(
      int currentIndex, UserNotificationDocResponse notification) {
    log(currentIndex.toString());
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    UserNotificationDocResponse? previousNotification =
        userNotificationPagingController.value.itemList?[previousIndex];
    return previousNotification;
    // return notification.previousNotification;
  }

  bool isNotificationDateChanges(UserNotificationDocResponse notification,
      UserNotificationDocResponse? previousNotification) {
    if (previousNotification == null) {
      return true;
    }
    Duration dateDifference =
        notification.createdAt.difference(previousNotification.createdAt);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  Future<void> getNotifications(int currentPageNumber) async {
    UserNotificationResponse? response =
        await APIRepo.getUserNotifications(currentPageNumber);
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

  onSuccessRetrievingResponse(UserNotificationResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      userNotificationPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    userNotificationPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    userNotificationPagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });

    super.onInit();
  }
}
