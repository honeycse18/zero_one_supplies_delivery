import 'package:ecomikdeliveryapp/controller/card_add_success_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardPlacedSuccessScreen extends StatelessWidget {
  const CardPlacedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardPlacedSuccessScreenController>(
        init: CardPlacedSuccessScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                // / <-------- Content --------> /
                body: SafeArea(
                    top: true,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 356,
                                  child: Column(
                                    children: [
                                      // / <---- Illustration image ----> /
                                      Image.asset(AppAssetImages.paypcongrats,
                                          height: 240),
                                      AppGaps.hGap20,
                                      // / <---- Highlighter text and subtitle text ----> /
                                      HighlightAndDetailTextWidget(
                                          slogan: LanguageHelper
                                              .currentLanguageText(
                                                  LanguageHelper
                                                      .congratulationTransKey),
                                          subtitle: LanguageHelper
                                              .currentLanguageText(
                                                  LanguageHelper
                                                      .dontWorryTransKey)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: CustomStretchedTextButtonWidget(
                                    buttonText:
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper.goToHomeTransKey),
                                    onTap: () {
                                      Get.toNamed(AppPageNames.homeScreen);
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                    )),
                // / <-------- Bottom bar --------> /

                // bottomNavigationBar: CustomScaffoldBottomBarWidget(
                //   child: Expanded(
                //     child: Container(
                //       margin: const EdgeInsets.all(10),
                //       child: CustomStretchedTextButtonWidget(
                //           buttonText: 'Go to Home',
                //           onTap: () {
                //             // Go to delivery info screen
                //             Get.toNamed(AppPageNames.homeScreen);
                //           }),
                //     ),
                //   ),
                // ),
              ),
            ));
  }
}
