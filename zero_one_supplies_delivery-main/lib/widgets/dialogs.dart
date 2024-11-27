import 'package:ecomikdeliveryapp/utils/constants/app_colors.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_gaps.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_images.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogs {
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ??
        LanguageHelper.currentLanguageText(LanguageHelper.successTransKey);
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.successBackgroundColor,
      titleWidget: Text(dialogTitle,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: AppColors.successColor),
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText:
              LanguageHelper.currentLanguageText(LanguageHelper.okTransKey),
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        )
      ],
    ));
  }

  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ??
        LanguageHelper.currentLanguageText(LanguageHelper.sorryTransKey);
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
          // backgroundColor: AppColors.alertColor,
          onTap: () {
            Get.back();
          },
          child: Text(
              LanguageHelper.currentLanguageText(LanguageHelper.okTransKey)),
        )
      ],
    ));
  }

  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    titleText = AppLanguageTranslation.confirmTransKey.toCurrentLanguage;
    yesButtonText = AppLanguageTranslation.yesTransKey.toCurrentLanguage;
    noButtonText = AppLanguageTranslation.noTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      titleWidget: Text(titleText,
          style: AppTextStyles.titleSmallSemiboldTextStyle,
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        Row(
          children: [
            Expanded(
              child: CustomStretchedOutlinedTextButtonWidget(
                buttonText: noButtonText,
                onTap: onNoTap ??
                    () {
                      Get.back();
                    },
              ),
            ),
            AppGaps.wGap12,
            Expanded(
              child: CustomStretchedTextButtonWidget(
                buttonText: yesButtonText,
                onTap: () async {
                  await onYesTap();
                  if (shouldCloseDialogOnceYesTapped) Get.back();
                },
              ),
            ),
          ],
        )
      ],
    ));
  }

  static Future<Object?> showActionableDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.alertColor,
      String? buttonText,
      void Function()? onTap}) async {
    titleText = AppLanguageTranslation.errorTransKey.toCurrentLanguage;
    buttonText = AppLanguageTranslation.okTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.alertBackgroundColor,
      titleWidget: Text(titleText,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: titleTextColor),
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText: buttonText,
          // backgroundColor: AppColors.alertColor,
          onTap: onTap,
        )
      ],
    ));
  }

  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              LanguageHelper.currentLanguageText(
                  LanguageHelper.imageIsProcessingTransKey),
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(LanguageHelper.currentLanguageText(
                  LanguageHelper.pleaseWaitTransKey)),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<Object?> showProcessingDialog({String? message}) async {
    message = AppLanguageTranslation.messageTransKey.toCurrentLanguage;
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(message,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }
}
