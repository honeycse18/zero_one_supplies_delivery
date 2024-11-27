import 'package:ecomikdeliveryapp/controller/wait_for_approval_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WaitForApprovalScreen extends StatelessWidget {
  const WaitForApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaitForApprovalScreenController>(
        init: WaitForApprovalScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context, hasBackButton: false),
                /* <-------- Content --------> */
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLanguageTranslation.informationWillBeReviewedTransKey
                            .toCurrentLanguage,
                        textAlign: TextAlign.center,
                      ),
                      AppGaps.hGap5,
                      Text(
                        AppLanguageTranslation
                            .waitForApprovalTransKey.toCurrentLanguage,
                        textAlign: TextAlign.center,
                      ),
                      AppGaps.hGap24,
                      CustomTextButtonWidget(
                          buttonText: AppLanguageTranslation
                              .editYourDetailsTransKey.toCurrentLanguage,
                          onTap: controller.onEditYourDetailsButtonTap),
                      AppGaps.hGap10,
                    ],
                  ),
                ),
              ),
            ));
  }
}
