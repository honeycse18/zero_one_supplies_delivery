import 'package:ecomikdeliveryapp/controller/currency_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/language_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  /// Currently selected language

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyScreenController>(
        init: CurrencyScreenController(),
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
                    hasBackButton: true,
                    titleWidget: Text(AppLanguageTranslation
                        .currencyTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap15,
                        Text(
                            AppLanguageTranslation
                                .selectCurrencyTransKey.toCurrentLanguage,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.primaryColor)),
                        AppGaps.hGap16,
                        /* <---- English language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency = CurrencySetting.usa;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.usaFlagSVGLogoColor,
                          languageNameText: 'USD',
                          isLanguageSelected:
                              controller.currentCurrency == CurrencySetting.usa,
                        ),
                        AppGaps.hGap16,
                        /* <---- Russian language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency =
                                CurrencySetting.russian;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.gbpFlagSVGLogoColor,
                          languageNameText: 'GBP',
                          isLanguageSelected: controller.currentCurrency ==
                              CurrencySetting.russian,
                        ),
                        AppGaps.hGap16,
                        /* <---- French language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency = CurrencySetting.bdt;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.bdtFlagSVGLogoColor,
                          languageNameText: 'BDT',
                          isLanguageSelected:
                              controller.currentCurrency == CurrencySetting.bdt,
                        ),
                        AppGaps.hGap16,
                        /* <---- Canada language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency = CurrencySetting.canada;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.canadaFlagSVGLogoColor,
                          languageNameText: 'CAD',
                          isLanguageSelected: controller.currentCurrency ==
                              CurrencySetting.canada,
                        ),
                        AppGaps.hGap16,
                        /* <---- Australia language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency =
                                CurrencySetting.australian;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.australiaFlagSVGLogoColor,
                          languageNameText: 'AUS',
                          isLanguageSelected: controller.currentCurrency ==
                              CurrencySetting.australian,
                        ),
                        AppGaps.hGap16,
                        /* <---- German language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            controller.currentCurrency = CurrencySetting.german;
                            controller.update();
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.jpyFlagSVGLogoColor,
                          languageNameText: 'JPY',
                          isLanguageSelected: controller.currentCurrency ==
                              CurrencySetting.german,
                        ),
                        // Bottom extra spaces
                        AppGaps.hGap30,
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
