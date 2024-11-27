import 'package:ecomikdeliveryapp/controller/notification_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/user_notification_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/notifications_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryNotificationScreenController>(
        init: DeliveryNotificationScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  /* <-------- Empty appbar with back button --------> */
                  appBar: CoreWidgets.appBarWidget(
                      screenContext: context,
                      titleWidget: Text(LanguageHelper.currentLanguageText(
                          LanguageHelper.notificationTransKey))),
                  /* <-------- Content --------> */
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RefreshIndicator(
                        onRefresh: () async => controller
                            .userNotificationPagingController
                            .refresh(),
                        child: PagedListView.separated(
                          pagingController:
                              controller.userNotificationPagingController,
                          builderDelegate:
                              CoreWidgets.pagedChildBuilderDelegate<
                                  UserNotificationDocResponse>(
                            itemBuilder: (context, item, index) {
                              final notification = item;
                              final previousNotification =
                                  controller.previousNotification(index, item);
                              final bool isNotificationDateChanges =
                                  controller.isNotificationDateChanges(
                                      item, previousNotification);
                              return NotificationWidget(
                                orderNumber:
                                    notification.notificationData.orderNumber,
                                dateTime: notification.createdAt,
                                isDateChanged: isNotificationDateChanges,
                                notificationType: notification.type,
                                isRead: notification.read,
                                onTap: () {},
                              );
                            },
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              AppGaps.hGap24,
                        ),
                      ),
                    ),
                  )

                  /* Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top extra spaces
            AppGaps.hGap80,
            /* <---- Notification list ----> */
            Expanded(
              /* <---- Notification list with date category ----> */
              child: ListView.separated(
                  itemCount: FakeData.fakeNotificationDateGroups.length,
                  padding: const EdgeInsets.only(bottom: 30, top: 24),
                  separatorBuilder: (context, outerIndex) => const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppGaps.screenPaddingValue),
                        child: Divider(height: 32),
                      ),
                  itemBuilder: (context, outerIndex) {
                    /// Single notification category
                    final notificationDateGroup =
                        FakeData.fakeNotificationDateGroups[outerIndex];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppGaps.screenPaddingValue),
                          child: Text(
                              notificationDateGroup.dateHumanReadableText,
                              style: Theme.of(context).textTheme.button),
                        ),
                        AppGaps.hGap24,
                        /* <---- Notification list under a date 
                                 category ----> */
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          // physics: const ClampingScrollPhysics(),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          itemCount: FakeData
                              .fakeNotificationDateGroups[outerIndex]
                              .groupNotifications
                              .length,
                          itemBuilder: (context, index) {
                            /// Single notification
                            final notification = FakeData
                                .fakeNotificationDateGroups[outerIndex]
                                .groupNotifications[index];
                            return SingleNotificationWidget(
                                onDelete: () {},
                                index: index,
                                notification: notification);
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ), */
                  ),
            ));
  }
}
