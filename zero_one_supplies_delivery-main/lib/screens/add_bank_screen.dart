import 'package:ecomikdeliveryapp/controller/add_bank_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddBankScreen extends StatelessWidget {
  const AddBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<AddBankScreenController>(
        init: AddBankScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Empty appbar with back button --------> */
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.addBankTransKey))),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap5,
                          Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.bankInfoTransKey),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.addAccountTransKey),
                            hintText: AppLanguageTranslation
                                .accountHolderNameTransKey.toCurrentLanguage,
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.profileSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.bankNameTransKey),
                            hintText: AppLanguageTranslation
                                .nfdBankOfNewYorkTransKey.toCurrentLanguage,
                            prefixIcon: Image.asset(AppAssetImages.bank),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.branchCodeTransKey),
                            hintText: '  +3892 2839',
                            prefixIcon: Image.asset(AppAssetImages.smsedit),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.accountNumberTransKey),
                            hintText: '  3823 4389 2390',
                            prefixIcon:
                                Image.asset(AppAssetImages.securitycard),
                          ),
                          AppGaps.hGap24,
                          /* <---- Password text field ----> */

                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                ),
                /* <-------- Bottom bar of sign up text --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Sign up text button ----> */
                      CustomStretchedTextButtonWidget(
                          buttonText: LanguageHelper.currentLanguageText(
                              LanguageHelper.addAccountTransKey),
                          onTap: () {
                            Get.toNamed(AppPageNames.addCardScreen);
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
