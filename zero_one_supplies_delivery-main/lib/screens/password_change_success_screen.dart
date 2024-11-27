import 'package:ecomikdeliveryapp/controller/passward_changed_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangSuccessScreen extends StatelessWidget {
  const PasswordChangSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordChangSuccessScreenController>(
        init: PasswordChangSuccessScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  /* <-------- Empty appbar with back button --------> */
                  appBar: CoreWidgets.appBarWidget(screenContext: context),
                  /* <-------- Content --------> */
                  body: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              AppAssetImages.passwordChangeSuccessIllustration,
                              cacheHeight: (240 * 1.5).toInt(),
                              cacheWidth: (260 * 1.5).toInt(),
                              height: 240,
                              width: 260),
                          AppGaps.hGap56,
                          HighlightAndDetailTextWidget(
                              isSpaceShorter: true,
                              slogan: LanguageHelper.currentLanguageText(
                                  LanguageHelper.passChangedTransKey),
                              subtitle: LanguageHelper.currentLanguageText(
                                  LanguageHelper.dontWorryTransKey)),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                  /* <-------- Bottom bar button --------> */
                  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: CustomStretchedTextButtonWidget(
                        buttonText: LanguageHelper.currentLanguageText(
                            LanguageHelper.keepMeLoginTransKey),
                        onTap: () {
                          Get.toNamed(AppPageNames.homeScreen);
                        }),
                  )),
            ));
  }
}
