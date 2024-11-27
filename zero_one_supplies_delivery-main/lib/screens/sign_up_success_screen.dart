import 'package:ecomikdeliveryapp/controller/sign_up_success_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpSuccessScreenController>(
        init: SignUpSuccessScreenController(),
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
                  appBar: AppBar(
                      title: const Text('Testing'),
                      automaticallyImplyLeading: false,
                      leading: Center(
                        child: CustomIconButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            hasShadow: true,
                            child: SvgPicture.asset(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              color: AppColors.darkColor,
                              height: 18,
                              width: 18,
                            )),
                      )),
                  /* <-------- Content --------> */
                  body: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppGaps.hGap80,
                          /* <---- Sign up success illustration ----> */
                          Image.asset(AppAssetImages.signUpSuccessIllustration,
                              cacheHeight:
                                  controller.illustrationImageCacheHeight,
                              cacheWidth:
                                  controller.illustrationImageCacheWidth,
                              height: 240,
                              width: 288),
                          AppGaps.hGap56,
                          HighlightAndDetailTextWidget(
                              isSpaceShorter: true,
                              slogan: LanguageHelper.currentLanguageText(
                                  LanguageHelper.yourDoneTransKey),
                              subtitle: LanguageHelper.currentLanguageText(
                                  LanguageHelper.pleaseConfirmTransKey)),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                  /* <-------- Bottom bar button --------> */
                  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: CustomStretchedTextButtonWidget(
                        buttonText: LanguageHelper.currentLanguageText(
                            LanguageHelper.sendCodeTransKey),
                        onTap: () {
                          Get.toNamed(
                              AppPageNames.passwordRecoveryPromptScreen);
                        }),
                  )),
            ));
  }
}
