import 'package:ecomikdeliveryapp/controller/congratulation_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CongratulationScreenController>(
        init: CongratulationScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Congratulation illustration ----> */
                      Image.asset(AppAssetImages.congratulationIllustration,
                          height: 272),
                      AppGaps.hGap56,
                      HighlightAndDetailTextWidget(
                          slogan: LanguageHelper.currentLanguageText(
                              LanguageHelper.congratulationTransKey),
                          subtitle: LanguageHelper.currentLanguageText(
                              LanguageHelper.dontWorryTransKey)),
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
                        LanguageHelper.goToHomeTransKey),
                    onTap: () {
                      Get.toNamed(AppPageNames.homeScreen, arguments: 0);
                    }),
              ),
            ));
  }
}
