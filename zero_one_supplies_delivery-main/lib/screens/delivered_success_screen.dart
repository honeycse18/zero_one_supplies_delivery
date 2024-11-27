import 'package:ecomikdeliveryapp/controller/delivery_success_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/delivered_success_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveredSuccessScreen extends StatelessWidget {
  const DeliveredSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveredSuccessScreenController>(
        init: DeliveredSuccessScreenController(),
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
                  screenContext: context,
                  hasBackButton: false,
                ),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Add review illustration ----> */
                        Image.asset(AppAssetImages.deliveredSuccessIllustration,
                            height: 240),
                        AppGaps.hGap56,
                        HighlightAndDetailTextWidget(
                            slogan: LanguageHelper.currentLanguageText(
                                LanguageHelper.deliveredSuccessfullyTransKey),
                            subtitle: LanguageHelper.currentLanguageText(
                                LanguageHelper
                                    .loremIpsumIsSimpleDummyTextTransKey)),
                        AppGaps.hGap32,
                        /* <---- Delivered success distance statistics ----> */
                        DeliveredSuccessDetailWidget(
                            detailTitle: LanguageHelper.currentLanguageText(
                                LanguageHelper.youDrivedTransKey),
                            detailText: '20 min (2.8 km)',
                            buttonText: LanguageHelper.currentLanguageText(
                                LanguageHelper.viewOrderInfoTransKey),
                            onTextButtonTap: () {},
                            iconLocalAssetName:
                                AppAssetImages.locationRoutingSVGLogoLine),
                        AppGaps.hGap24,
                        /* <---- Delivered success earning statistics ----> */
                        DeliveredSuccessDetailWidget(
                            detailTitle: LanguageHelper.currentLanguageText(
                                LanguageHelper.yourEarningTransKey),
                            detailText: '\$ 3.38',
                            buttonText: LanguageHelper.currentLanguageText(
                                LanguageHelper.viewEarningTransKey),
                            onTextButtonTap: () {},
                            iconLocalAssetName:
                                AppAssetImages.walletEmptySVGLogoLine),
                        // Bottom extra spaces
                        AppGaps.hGap30,
                      ],
                    ),
                  )),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: LanguageHelper.currentLanguageText(
                          LanguageHelper.backToHomeTransKey),
                      onTap: () {
                        Get.toNamed(AppPageNames.homeScreen);
                      }),
                ),
              ),
            ));
  }
}
