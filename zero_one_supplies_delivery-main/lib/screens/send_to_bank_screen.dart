import 'package:ecomikdeliveryapp/controller/send_to_bank_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SendToBankScreen extends StatelessWidget {
  const SendToBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendToBankScreenController>(
        init: SendToBankScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(LanguageHelper.currentLanguageText(
                      LanguageHelper.sendToBankTransKey))),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top extra spaces
                      AppGaps.hGap15,
                      /* <---- Card widget ----> */
                      PaymentCardWidget(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.nameTransKey),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.7))),
                          AppGaps.hGap2,
                          Text('Michel John Doe',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                          AppGaps.hGap16,
                          Text(
                            '****    ****    ****    2382',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                          AppGaps.hGap16,
                          Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.balanceTransKey),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.7))),
                          AppGaps.hGap2,
                          Text(r'$2373.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                        ],
                      )),
                      AppGaps.hGap32,
                      Text(
                          LanguageHelper.currentLanguageText(
                              LanguageHelper.bankInfoTransKey),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: AppColors.primaryColor)),
                      AppGaps.hGap16,
                      /* <---- Account holder name text field ----> */
                      CustomTextFormField(
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.accountHolderNameTransKey),
                          hintText: 'Samantha Smith',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.profileSVGLogoLine,
                              color: AppColors.bodyTextColor)),
                      AppGaps.hGap24,
                      /* <---- Bank name text field ----> */
                      CustomTextFormField(
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.bankNameTransKey),
                          hintText: 'HBSJ Bank of New York',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.bankSVGLogoLine,
                              color: AppColors.bodyTextColor)),
                      AppGaps.hGap24,
                      /* <---- Branch code text field ----> */
                      CustomTextFormField(
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.branchCodeTransKey),
                          hintText: '+3892 2839',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.messageBoxBorderSVGLogoLine,
                              color: AppColors.bodyTextColor)),
                      AppGaps.hGap24,
                      /* <---- Account number text field ----> */
                      CustomTextFormField(
                        labelText: LanguageHelper.currentLanguageText(
                            LanguageHelper.accountNumberTransKey),
                        hintText: '3823 4389 2390',
                        prefixIcon: SvgPicture.asset(
                            AppAssetImages.securityCardSVGLogoLine,
                            color: AppColors.bodyTextColor),
                        textInputType: TextInputType.number,
                      ),
                      AppGaps.hGap24,
                      /* <---- Amount of transfer text field ----> */
                      CustomTextFormField(
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.enterAmountTransferTransKey),
                          hintText: '500',
                          textInputType: TextInputType.number,
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.coinSVGLogoLine,
                              color: AppColors.bodyTextColor)),
                      AppGaps.hGap30,
                    ],
                  ),
                ),
              ),
              /* <-------- Bottom bar --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedButtonWidget(
                onTap: () {
                  // Go to congratualtions screen.
                  Get.toNamed(AppPageNames.congratulationScreen);
                },
                child: Text(LanguageHelper.currentLanguageText(
                    LanguageHelper.sendToBankTransKey)),
              )),
            ));
  }
}
