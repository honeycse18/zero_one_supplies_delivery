import 'package:ecomikdeliveryapp/controller/contact_us_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    // final screenSize = MediaQuery.of(context).size;
    return GetBuilder<ContactUsScreenController>(
        init: ContactUsScreenController(),
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
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.contactUsTransKey),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    )),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    child: Image(
                                        image: Image.asset(AppAssetImages.bank)
                                            .image),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLanguageTranslation
                                            .addressTransKey.toCurrentLanguage,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        '50 Outer Bypass Road Khulna 9001. \nBangladesh',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    child: Image(
                                        image: Image.asset(AppAssetImages.bank)
                                            .image),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper
                                                .emailAddressTransKey),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        'support@appstick.com.bd',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    child: Image(
                                        image: Image.asset(AppAssetImages.bank)
                                            .image),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper.phoneTransKey),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        '+88012345678',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap25,
                          /* <---- User full name text field ----> */
                          Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.getInTouchTransKey),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          AppGaps.hGap15,
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.yourNameTransKey),
                            hintText: AppLanguageTranslation
                                .yourNameTransKey.toCurrentLanguage,
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.profileSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.emailAddressTransKey),
                            hintText: '  contact@gmail.com',
                            prefixIcon: Image.asset(AppAssetImages.email),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.messageTransKey),
                            hintText: AppLanguageTranslation
                                .typeYourMessageTransKey.toCurrentLanguage,
                            // prefixIcon: Image.asset(AppAssetImages.smsedit),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */

                          /* <---- Password text field ----> */
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
                              LanguageHelper.addBankAccountTransKey),
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
