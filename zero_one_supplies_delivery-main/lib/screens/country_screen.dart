import 'package:ecomikdeliveryapp/controller/country_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/language_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key});

  /// Currently selected language

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryScreenController>(
        init: CountryScreenController(),
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
                        .countryTransKey.toCurrentLanguage)),
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
                                .selectCountryTransKey.toCurrentLanguage,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.primaryColor)),
                        AppGaps.hGap16,
                        /* <---- English language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry = CountrySetting.usa;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.usaFlagSVGLogoColor,
                          languageNameText: 'English',
                          isLanguageSelected:
                              controller.currentCountry == CountrySetting.usa,
                        ),
                        AppGaps.hGap16,
                        /* <---- Russian language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry = CountrySetting.russian;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.russiaFlagSVGLogoColor,
                          languageNameText: 'Russian',
                          isLanguageSelected: controller.currentCountry ==
                              CountrySetting.russian,
                        ),
                        AppGaps.hGap16,
                        /* <---- French language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry = CountrySetting.french;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.franceFlagSVGLogoColor,
                          languageNameText: 'French',
                          isLanguageSelected: controller.currentCountry ==
                              CountrySetting.french,
                        ),
                        AppGaps.hGap16,
                        /* <---- Canada language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry = CountrySetting.canada;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.canadaFlagSVGLogoColor,
                          languageNameText: 'Canada',
                          isLanguageSelected: controller.currentCountry ==
                              CountrySetting.canada,
                        ),
                        AppGaps.hGap16,
                        /* <---- Australia language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry =
                                CountrySetting.australian;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.australiaFlagSVGLogoColor,
                          languageNameText: 'Australia',
                          isLanguageSelected: controller.currentCountry ==
                              CountrySetting.australian,
                        ),
                        AppGaps.hGap16,
                        /* <---- German language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentCountry = CountrySetting.german;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.germanFlagSVGLogoColor,
                          languageNameText: 'German',
                          isLanguageSelected: controller.currentCountry ==
                              CountrySetting.german,
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
