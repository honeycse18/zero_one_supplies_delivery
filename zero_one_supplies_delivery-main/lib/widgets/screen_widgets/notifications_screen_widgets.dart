import 'package:ecomikdeliveryapp/models/fake_data.dart';
import 'package:ecomikdeliveryapp/models/fake_models/notification_model.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_colors.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_components.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_gaps.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Single notification entry widget from notification group
class SingleNotificationWidget extends StatelessWidget {
  final FakeNotificationModel notification;
  const SingleNotificationWidget({
    super.key,
    required this.notification,
  });

  TextStyle? _getTextStyle(FakeNotificationTextModel notificationText) {
    if (notificationText.isBoldText) {
      return const TextStyle(fontWeight: FontWeight.w600);
    } else if (notificationText.isHashText) {
      return const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    } else if (notificationText.isColoredText) {
      return const TextStyle(color: AppColors.primaryColor);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead
                    ? AppColors.bodyTextColor
                    : AppColors.primaryColor),
          ),
          AppGaps.wGap16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: notification.isRead
                              ? AppColors.bodyTextColor
                              : AppColors.darkColor,
                          height: 1.5),
                      children: notification.texts
                          .map((notificationText) => TextSpan(
                              text: notificationText.text,
                              style: _getTextStyle(notificationText)))
                          .toList()),
                ),
                AppGaps.hGap8,
                Text(notification.timeText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.bodyTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification group widget from date wise
class NotificationDateGroupWidget extends StatelessWidget {
  const NotificationDateGroupWidget({
    super.key,
    required this.notificationDateGroup,
    required this.outerIndex,
  });

  final FakeNotificationDateGroupModel notificationDateGroup;
  final int outerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notificationDateGroup.dateHumanReadableText,
            style: Theme.of(context).textTheme.labelLarge),
        AppGaps.hGap24,
        /* <---- Notification list under a date 
                 category ----> */
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => AppGaps.hGap24,
          itemCount: FakeData
              .fakeNotificationDateGroups[outerIndex].groupNotifications.length,
          itemBuilder: (context, index) {
            /// Single notification
            final notification = FakeData.fakeNotificationDateGroups[outerIndex]
                .groupNotifications[index];
            return SingleNotificationWidget(notification: notification);
          },
        ),
      ],
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final bool isRead;
  final String notificationType;
  final String orderNumber;
  final DateTime dateTime;
  final bool isDateChanged;
  final void Function()? onTap;

  const NotificationWidget({
    super.key,
    this.isRead = true,
    required this.notificationType,
    this.onTap,
    required this.dateTime,
    required this.isDateChanged,
    this.orderNumber = '',
  });

  @override
  Widget build(BuildContext context) {
    if (isDateChanged) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              dayText,
              style: AppTextStyles.notificationDateSection,
            ),
          ),
          AppGaps.hGap24,
          _NotificationWidget(
              isRead: isRead,
              notificationType: notificationType,
              dateTime: dateTime,
              orderNumber: orderNumber,
              isDateChanged: isDateChanged,
              onTap: onTap),
        ],
      );
    }
    return _NotificationWidget(
        isRead: isRead,
        notificationType: notificationType,
        dateTime: dateTime,
        isDateChanged: isDateChanged,
        onTap: onTap);
  }

  String get dayText {
    if (Helper.isToday(dateTime)) {
      return AppLanguageTranslation.todayTransKey.toCurrentLanguage;
    }
    if (Helper.wasYesterday(dateTime)) {
      return AppLanguageTranslation.yesterdayTransKey.toCurrentLanguage;
    }
    if (Helper.isTomorrow(dateTime)) {
      return AppLanguageTranslation.tomorrowTransKey.toCurrentLanguage;
    }
    return Helper.ddMMMyyyyFormattedDateTime(dateTime);
  }
}

class _NotificationWidget extends StatelessWidget {
  final bool isRead;
  final String notificationType;
  final DateTime dateTime;
  final bool isDateChanged;
  final String orderNumber;
  final void Function()? onTap;
  const _NotificationWidget({
    this.isRead = true,
    required this.notificationType,
    required this.dateTime,
    required this.isDateChanged,
    this.onTap,
    this.orderNumber = '',
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: () {},
        borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: NotificationDotWidget(isRead: isRead),
            ),
            AppGaps.wGap16,
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text:
                              '${LanguageHelper.currentLanguageText(LanguageHelper.yourOrderTransKey)} #$orderNumber ${LanguageHelper.currentLanguageText(LanguageHelper.isArrivedTransKey)} Railstation ${LanguageHelper.currentLanguageText(LanguageHelper.byTransKey)} Michle Leo Hunter'),
                    ]),
                    style: AppTextStyles.bodyLargeTextStyle.copyWith(
                        color: isRead ? AppColors.bodyTextColor : null)),
                AppGaps.hGap8,
                Text(
                  Helper.hhmmFormattedDateTime(dateTime),
                  style: const TextStyle(
                    color: AppColors.bodyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ))
          ]),
        ));
  }
}
