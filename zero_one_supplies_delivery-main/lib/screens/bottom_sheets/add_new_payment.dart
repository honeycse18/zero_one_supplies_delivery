import 'dart:ui';

import 'package:ecomikdeliveryapp/controller/bottom_sheets/add_new_payment_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_colors.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_gaps.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_images.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/select_payment_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewPaymentBottomSheet extends StatelessWidget {
  const AddNewPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = MediaQuery.of(context).size.height - 200;
    return GetBuilder<AddNewPaymentBottomSheetController>(
        init: AddNewPaymentBottomSheetController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white.withOpacity(0.5),
                              )),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          18.0, 0.0, 12, 0.0),
                                      child: Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper.addAccountTransKey),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(18),
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Image.asset(AppAssetImages
                                                    .walletSvgLogo)
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

                                AppGaps.hGap5,
                                // const Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: bottomSheetHeight,
                                        // width: 300,
                                        child: CustomScrollView(slivers: [
                                          SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                            (context, index) {
                                              /// Single payment Option
                                              final paymentOption =
                                                  controller.siteSetting[index];
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child:
                                                    PaymentOptionListTileWidget(
                                                  onTap: () => controller
                                                      .onAddAccountMethodTap(
                                                          paymentOption),
                                                  paymentName:
                                                      paymentOption.name,
                                                  radioOnChange: (value) =>
                                                      controller
                                                          .onAddAccountRadioChange(
                                                              paymentOption),
                                                  id: paymentOption.id,
                                                  paymentImageURL:
                                                      paymentOption.logo,
                                                  selectedPaymentOptionId:
                                                      controller
                                                          .selectedAddNewAccountMethod
                                                          .id,
                                                  hasShadow: controller
                                                          .selectedAddNewAccountMethod
                                                          .id ==
                                                      paymentOption.id,
                                                ),
                                              );
                                            },
                                            childCount:
                                                controller.siteSetting.length,
                                          )),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                // const Spacer(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(10),
                                          // width: 290,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child:
                                              CustomStretchedTextButtonWidget(
                                                  buttonText: LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .addCardTransKey),
                                                  onTap: controller
                                                      .onAddCardButtonTap)),
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
