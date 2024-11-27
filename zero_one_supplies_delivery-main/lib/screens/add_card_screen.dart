import 'package:ecomikdeliveryapp/controller/add_card_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<AddCardScreenController>(
        init: AddCardScreenController(),
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
                        LanguageHelper.addCardTransKey))),
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
                                LanguageHelper.cardInfoTransKey),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.nameOnCardTransKey),
                            hintText: AppLanguageTranslation
                                .cardNameTransKey.toCurrentLanguage,
                            prefixIcon: Image.asset(AppAssetImages.debitcard),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */

                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.cardNumberTransKey),
                            hintText: '  **** ***** ****',
                            prefixIcon: Image.asset(AppAssetImages.editcard),
                            suffixIcon: Image.asset(AppAssetImages.hide),
                          ),
                          AppGaps.hGap15,
                          Row(
                            children: [
                              Expanded(
                                //width: 150,
                                child: CustomTextFormField(
                                  labelText: LanguageHelper.currentLanguageText(
                                      LanguageHelper.expirationTransKey),
                                  hintText: '  02/11/21',
                                  prefixIcon:
                                      Image.asset(AppAssetImages.calender),
                                ),
                                // const Spacer()
                              ),
                              AppGaps.wGap10,
                              Expanded(
                                // width: 150,
                                child: CustomTextFormField(
                                  labelText: LanguageHelper.currentLanguageText(
                                      LanguageHelper.cvcTransKey),
                                  hintText: '  398',
                                  prefixIcon:
                                      Image.asset(AppAssetImages.pentool),
                                ),
                              )
                            ],
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.postalCodeTransKey),
                            hintText: '  6 3 5 0',
                            prefixIcon: Image.asset(AppAssetImages.postal),
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
                              LanguageHelper.addCardTransKey),
                          onTap: () {
                            Get.toNamed(AppPageNames.addWithdrawMethodScreen);
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
