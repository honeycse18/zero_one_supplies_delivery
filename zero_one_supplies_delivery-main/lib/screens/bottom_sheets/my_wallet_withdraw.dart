import 'dart:ui';

import 'package:ecomikdeliveryapp/controller/bottom_sheets/my_wallet_withdraw_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWalletWithdrawBottomSheet extends StatelessWidget {
  const MyWalletWithdrawBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletWithdrawBottomSheetController>(
        init: MyWalletWithdrawBottomSheetController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18, 0, 12, 0),
                    // margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Color.lerp(Colors.white, Colors.black, 0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.4),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppGaps.hGap18,
                            Row(
                              children: [
                                Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.withdrawTransKey),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  child: Container(
                                    // margin: const EdgeInsets.all(18),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: Image.asset(
                                                AppAssetImages.walletSvgLogo)
                                            .image,
                                        //          xFit.fill
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                  },
                                )
                              ],
                            ),
                            AppGaps.hGap18,
                            AppGaps.hGap12,
                            CustomTextFormField(
                              controller: controller.withdrawAmountController,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.enterAmountTransferTransKey),
                              hintText:
                                  '${LanguageHelper.currentLanguageText(LanguageHelper.exampleTransKey)}: ${Helper.getCurrencyFormattedAmountText(65)}}',
                              prefixIcon: AppGaps.emptyGap,
                              textInputType: TextInputType.number,
                            ),
                            /* Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 18),
                                  child: const Text(
                                    'Enter Amount to Transfer',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ), */

                            /*                       AppGaps.hGap10,
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: const TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(30),
                                  //labelText: 'Enter your name',
                                  hintText: r'Eg: $65',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ), */
                            AppGaps.hGap25,
                            // const Spacer(),
                            CustomStretchedTextButtonWidget(
                                buttonText: LanguageHelper.currentLanguageText(
                                    LanguageHelper.withdrawTransKey),
                                onTap: () {
                                  Get.back(
                                      result: controller
                                          .withdrawAmountController.text);
                                  /* showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors
                                                .transparent
                                                .withOpacity(0.0),
                                            builder: (BuildContext context) {
                                              // return addAccountDelivery();
                                              return AppGaps.emptyGap;
                                            },
                                          ); */
                                }),
                            // const Spacer(),
                            AppGaps.hGap30,
                          ]),
                    ),
                  ),
                ),
              ),
            ));
  }
}
