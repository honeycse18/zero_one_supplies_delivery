import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomikdeliveryapp/controller/password_recovery_screens/verify_password_phone_otp_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PasswordRecoveryPromptScreen extends StatelessWidget {
  const PasswordRecoveryPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordPhoneOtpController>(
        init: ResetPasswordPhoneOtpController(),
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
                appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppGaps.hGap80,
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                    AppAssetImages.passwordRecoveryIllustration,
                                    height: 240),
                                AppGaps.hGap20,
                                Text(
                                    AppLanguageTranslation
                                        .passwordRecoveryTransKey
                                        .toCurrentLanguage,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                AppGaps.hGap16,
                                Text(
                                    AppLanguageTranslation.pleaseConfirmTransKey
                                        .toCurrentLanguage,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.bodyTextColor,
                                            overflow: TextOverflow.clip)),
                              ],
                            ),
                          ),
                          AppGaps.hGap40,
                          // CountryCodePicker(
                          //   onChanged: controller.onCountryChange,
                          //   initialSelection: 'BD',
                          //   favorite: const ['BD', 'US'],
                          //   showDropDownButton: true,
                          //   showOnlyCountryWhenClosed: true,
                          //   // textStyle: ,
                          // ),
                          AppGaps.hGap12,
                          /* <---- Country selection text field ----> */
                          CountryCodePicker(
                            enabled: true,
                            initialSelection:
                                controller.currentCountryCode.code,
                            onChanged: controller.onCountryChange,
                            builder: (country) {
                              log(country?.flagUri ?? '');
                              return /* CustomTextFormField(
                                isReadOnly: true,
                                onTap: () {},
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      controller.currentCountryCode.flagUri ??
                                          'flags/bd.png',
                                      package: 'country_code_picker',
                                      height: 20,
                                      width: 20,
                                    ),
                                    AppGaps.wGap30,
                                    Container(
                                        height: 26,
                                        width: 2,
                                        color: AppColors.lineShapeColor),
                                  ],
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                    maxHeight: 32, maxWidth: 75),
                                hintText: country?.name ?? 'Bangladesh',
                                suffixIconConstraints: const BoxConstraints(
                                    maxHeight: 32, maxWidth: 32),
                                suffixIcon: SvgPicture.asset(
                                  AppAssetImages.arrowDownSVGLogoLine,
                                  color: AppColors.bodyTextColor,
                                ),
                              ) */
                                  Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                padding: const EdgeInsets.all(15),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          country?.flagUri ?? 'flags/bd.png',
                                          package: 'country_code_picker',
                                          height: 20,
                                          width: 20,
                                        ),
                                        AppGaps.wGap30,
                                        Container(
                                            height: 26,
                                            width: 2,
                                            color: AppColors.lineShapeColor),
                                      ],
                                    ),
                                    AppGaps.wGap16,
                                    Expanded(child: Text(country?.name ?? '')),
                                    AppGaps.wGap10,
                                    SvgPicture.asset(
                                      AppAssetImages.arrowDownSVGLogoLine,
                                      color: AppColors.bodyTextColor,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          // CustomTextFormField(
                          //   isReadOnly: true,
                          //   prefixIcon: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       SvgPicture.asset(
                          //         AppAssetImages.ukSVGLogoColor,
                          //         height: 20,
                          //         width: 20,
                          //       ),
                          //       AppGaps.wGap30,
                          //       Container(
                          //           height: 26,
                          //           width: 2,
                          //           color: AppColors.lineShapeColor),
                          //     ],
                          //   ),
                          //   prefixIconConstraints: const BoxConstraints(
                          //       maxHeight: 32, maxWidth: 75),
                          //   hintText: controller.currentCountryCode.name,
                          //   suffixIconConstraints: const BoxConstraints(
                          //       maxHeight: 32, maxWidth: 32),
                          //   suffixIcon: SvgPicture.asset(
                          //     AppAssetImages.arrowDownSVGLogoLine,
                          //     color: AppColors.bodyTextColor,
                          //   ),
                          // ),
                          AppGaps.hGap24,
                          /* <---- Phone number text field ----> */
                          CustomTextFormField(
                            controller: controller.phoneTextEditingController,
                            textInputType: TextInputType.phone,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.currentCountryCode.dialCode ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.bodyTextColor),
                                ),
                                AppGaps.wGap10,
                                Container(
                                    height: 26,
                                    width: 2,
                                    color: AppColors.lineShapeColor),
                              ],
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 32, maxWidth: 80),
                            hintText: '823 394 939',
                            suffixIconConstraints: const BoxConstraints(
                                minHeight: 32, minWidth: 32),
                          ),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                ),
                /* <-------- Bottom bar of sign up text --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      isLoading: controller.isLoading,
                      buttonText: AppLanguageTranslation
                          .sendCodeTransKey.toCurrentLanguage,
                      onTap: () {
                        controller.onSendCodeButtonTap();
                      }),
                ),
              ),
            ));
  }
}
