import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomikdeliveryapp/controller/password_recovery_screens/sign_up_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<UserRegScreenController>(
        init: UserRegScreenController(),
        global: false,
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill),
              ),
              child: Scaffold(
                /* <-------- Empty appbar with back button --------> */
                appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Form(
                        key: controller.userRegFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: HighlightAndDetailTextWidget(
                                  isSpaceShorter: true,
                                  slogan: LanguageHelper.currentLanguageText(
                                      LanguageHelper.gettingStartedTransKey),
                                  subtitle: AppLanguageTranslation
                                      .signUpToContinueTransKey
                                      .toCurrentLanguage),
                            ),
                            AppGaps.hGap24,
                            /* <---- User full name text field ----> */
                            CustomTextFormField(
                              controller: controller.firstNameController,
                              validator: controller.nameFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.firstNameTransKey),
                              hintText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.yourFirstNameTransKey),
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.profileSVGLogoLine),
                            ),
                            AppGaps.hGap24,
                            /* <---- User full name text field ----> */
                            CustomTextFormField(
                              controller: controller.lastNameController,
                              validator: controller.nameFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.lastNameTransKey),
                              hintText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.yourLastNameTransKey),
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.profileSVGLogoLine),
                            ),
                            /* AppGaps.hGap24,
                            CustomTextFormField(
                              controller: controller.phoneController,
                              validator: controller.phoneFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.phoneTransKey),
                              hintText: '+8801234567890',
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.phoneSVGLogoLine),
                            ), */
                            AppGaps.hGap24,
                            CustomTextFormField(
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.phoneTransKey),
                              controller: controller.phoneController,
                              textInputType: TextInputType.phone,
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CountryCodePicker(
                                    initialSelection:
                                        controller.currentCountryCode.code,
                                    onChanged: controller.onCountryChange,
                                    builder: (country) {
                                      return Text(
                                        country?.dialCode ?? '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.bodyTextColor),
                                      );
                                    },
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
                            AppGaps.hGap24,
                            /* <---- Email text field ----> */
                            CustomTextFormField(
                              controller: controller.emailController,
                              validator: controller.emailFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.emailAddressTransKey),
                              hintText: 'contact@gmail.com',
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.messageSVGLogoLine),
                            ),
                            AppGaps.hGap24,
                            /* <---- Password text field ----> */
                            Obx(() => CustomTextFormField(
                                  controller: controller.passwordController,
                                  validator: controller.passwordFormValidator,
                                  isPasswordTextField:
                                      controller.toggleHidePassword.value,
                                  labelText: LanguageHelper.currentLanguageText(
                                      LanguageHelper.passwordTransKey),
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onPasswordSuffixEyeButtonTap,
                                      icon: SvgPicture.asset(
                                          AppAssetImages.hideSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap24,
                            /* <---- Password text field ----> */
                            Obx(() => CustomTextFormField(
                                  controller:
                                      controller.confirmPasswordController,
                                  validator:
                                      controller.confirmPasswordFormValidator,
                                  isPasswordTextField: controller
                                      .toggleHideConfirmPassword.value,
                                  labelText: LanguageHelper.currentLanguageText(
                                      LanguageHelper.confirmPasswordTransKey),
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onConfirmPasswordSuffixEyeButtonTap,
                                      icon: SvgPicture.asset(
                                          AppAssetImages.hideSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap24,
                            /* <---- Terms and conditions CheckBox ----> */
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: screenSize.width < 458
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Obx(() => Checkbox(
                                        value: controller
                                            .toggleAgreeTermsConditions.value,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        onChanged: controller
                                            .onToggleAgreeTermsConditions)),
                                  ),
                                ),
                                AppGaps.wGap16,
                                Expanded(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(LanguageHelper.currentLanguageText(
                                          LanguageHelper
                                              .bySigningUpIAgreeToTheTransKey)),
                                      AppGaps.wGap5,
                                      CustomTightTextButtonWidget(
                                          onTap: () {
                                            Get.toNamed(AppPageNames
                                                .termsConditionScreen);
                                          },
                                          child: Text(
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .termsOfServiceTransKey),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          )),
                                      AppGaps.wGap5,
                                      Text(LanguageHelper.currentLanguageText(
                                          LanguageHelper.andTransKey)),
                                      AppGaps.wGap5,
                                      CustomTightTextButtonWidget(
                                          onTap: () {
                                            Get.toNamed(AppPageNames
                                                .privacyPolicyScreen);
                                          },
                                          child: Text(
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .privacyPolicyTransKey),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Bottom extra spaces
                            AppGaps.hGap30,
                          ],
                        ),
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
                      Obx(() => CustomStretchedTextButtonWidget(
                          buttonText: LanguageHelper.currentLanguageText(
                              LanguageHelper.signUpTransKey),
                          onTap: controller.toggleAgreeTermsConditions.value
                              ? controller.onSignUpButtonTap
                              : null)),
                      AppGaps.hGap19,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.alreadyHaveAnAccountTransKey),
                              style: const TextStyle(
                                  color: AppColors.bodyTextColor)),
                          AppGaps.wGap5,
                          /* <---- Sign in TextButton ----> */
                          CustomTightTextButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.signInTransKey),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.primaryColor)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
