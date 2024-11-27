import 'package:ecomikdeliveryapp/controller/my_wallet_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/wallet_histories_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/select_payment_screen_widget.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/my_wallet_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletScreenController>(
        init: MyWalletScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  // color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(LanguageHelper.currentLanguageText(
                      LanguageHelper.walletTransKey)),
                ),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getWalletDetails();
                      controller.walletHistoryController.refresh();
                    },
                    child: CustomScrollView(slivers: [
                      // Top extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap15),
                      /* <---- Card widget ----> */
                      SliverToBoxAdapter(
                        child: Column(children: [
                          SizedBox(
                            height: 150,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /* <---- Orders total data widget ----> */
                                    Container(
                                      width: 145,
                                      padding: const EdgeInsets.all(16),
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              AppComponents
                                                  .defaultBorderRadius),
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomIconButtonWidget(
                                              borderRadiusRadiusValue:
                                                  const Radius.circular(8),
                                              backgroundColor:
                                                  const Color(0xFFF57C1E),
                                              child: SvgPicture.asset(
                                                AppAssetImages
                                                    .walletSVGLogoDualTone,
                                                color: Colors.white,
                                              )),
                                          AppGaps.hGap12,
                                          Expanded(
                                            child: Text(
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller.walletDetails
                                                            .currentBalance),
                                                maxLines: 2,
                                                style: AppTextStyles
                                                    .bodyExtraLargeBoldTextStyle),
                                          ),
                                          AppGaps.hGap5,
                                          Text(
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper.balanceTransKey),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppGaps.wGap16,
                                    /* <---- Ride total data widget ----> */
                                    Container(
                                      width: 145,
                                      padding: const EdgeInsets.all(16),
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              AppComponents
                                                  .defaultBorderRadius),
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomIconButtonWidget(
                                              borderRadiusRadiusValue:
                                                  const Radius.circular(8),
                                              backgroundColor:
                                                  const Color(0xFFFE4651),
                                              child: SvgPicture.asset(
                                                AppAssetImages.withdrawSVGLogo,
                                              )),
                                          AppGaps.hGap16,
                                          Expanded(
                                            child: Text(
                                              Helper
                                                  .getCurrencyFormattedAmountText(
                                                      controller.walletDetails
                                                          .totalWithdraw),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          AppGaps.hGap5,
                                          Text(
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .withdrawTransKey),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppGaps.wGap16,
                                    /* <---- Earning total data widget ----> */
                                    Container(
                                      width: 145,
                                      padding: const EdgeInsets.all(16),
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              AppComponents
                                                  .defaultBorderRadius),
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomIconButtonWidget(
                                              borderRadiusRadiusValue:
                                                  const Radius.circular(8),
                                              backgroundColor:
                                                  AppColors.tertiaryColor,
                                              child: SvgPicture.asset(
                                                AppAssetImages
                                                    .walletSVGLogoDualTone,
                                                color: Colors.white,
                                              )),
                                          AppGaps.hGap16,
                                          Expanded(
                                            child: Text(
                                              Helper
                                                  .getCurrencyFormattedAmountText(
                                                      controller.walletDetails
                                                          .totalEarning),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          AppGaps.hGap5,
                                          Text(
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .yourEarningTransKey),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ]),
                      ),

                      // SliverToBoxAdapter(
                      //     child: PaymentCardWidget(
                      //         child: Column(
                      //   mainAxisSize: MainAxisSize.max,
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                      //     Text('Name',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .caption
                      //             ?.copyWith(color: Colors.white.withOpacity(0.7))),
                      //     AppGaps.hGap2,
                      //     Text('Michel John Doe',
                      //         style: Theme.of(context).textTheme.button?.copyWith(
                      //             color: Colors.white, fontWeight: FontWeight.w600)),
                      //     AppGaps.hGap16,
                      //     Text(
                      //       '****    ****    ****    2382',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .caption
                      //           ?.copyWith(color: Colors.white),
                      //     ),
                      //     AppGaps.hGap16,
                      //     Text('Balance',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .caption
                      //             ?.copyWith(color: Colors.white.withOpacity(0.7))),
                      //     AppGaps.hGap2,
                      //     Text(r'$2373.00',
                      //         style: Theme.of(context).textTheme.button?.copyWith(
                      //             color: Colors.white, fontWeight: FontWeight.w500)),
                      //   ],
                      // ))),
                      const SliverToBoxAdapter(child: AppGaps.hGap32),
                      SliverToBoxAdapter(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: controller.onAddNewButtonTap,
                            child: Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.savedWithdrawMethodTransKey),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            child: CustomTightTextButtonWidget(
                              onTap: controller.onAddNewButtonTap,
                              child: Text(
                                '+ ${LanguageHelper.currentLanguageText(LanguageHelper.addNewTransKey)}',
                                maxLines: 1,
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          )
                        ],
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap32),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          /// Single payment Option
                          final withdrawMethod = controller
                              .walletDetails.savedWithdrawMethods[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PaymentOptionListTileWidget(
                              hasShadow:
                                  controller.selectedSavedWithdrawMethod.id ==
                                      withdrawMethod.id,
                              onTap: () => controller
                                  .onWithdrawMethodTap(withdrawMethod),
                              paymentImageURL: withdrawMethod.logo,
                              // paymentIconWidget: withdrawMethod.paymentImage,
                              paymentName: withdrawMethod.type,
                              radioOnChange: (value) => controller
                                  .onWithdrawRadioChange(withdrawMethod),
                              id: withdrawMethod.id,
                              selectedPaymentOptionId:
                                  controller.selectedSavedWithdrawMethod.id,
                            ),
                          );
                        },
                        childCount: controller
                            .walletDetails.savedWithdrawMethods.length,
                      )),

                      const SliverToBoxAdapter(child: AppGaps.hGap32),
                      SliverToBoxAdapter(
                          child: Text(
                        LanguageHelper.currentLanguageText(
                            LanguageHelper.recentTransactionTransKey),
                        style: Theme.of(context).textTheme.headlineMedium,
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      PagedSliverList.separated(
                          pagingController: controller.walletHistoryController,
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<WalletHistory>(
                                  noItemFoundIndicatorBuilder: (context) =>
                                      Center(
                                        child: EmptyScreenWidget(
                                            image: AppAssetImages.noTransaction,
                                            title: LanguageHelper
                                                .currentLanguageText(
                                                    LanguageHelper
                                                        .noTransactionTransKey),
                                            shortTitle: ''),
                                      ),
                                  itemBuilder: (context, item, index) {
                                    return RecentTransactionWidget(
                                      amount: item.amount,
                                      dateTime: item.createdAt,
                                      status: item.status,
                                      title: item.withdrawMethod.type,
                                      imageURL: item.withdrawMethod.logo,
                                    );
                                  }),
                          separatorBuilder: (context, index) =>
                              AppGaps.emptyGap),
                      /* <---- Recent transaction list ----> */
/*                       SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          /// Get single recent transaction
                          final recentTransaction =
                              FakeData.recentTransactions[index];
                          return RecentTransactionWidget(
                              amount: re, dateTime: dateTime, title: title);
                        },
                        childCount: FakeData.recentTransactions.length,
                      )), */
                      // Bottom extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap30),
                    ]),
                  ),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .withdrawTransKey.toCurrentLanguage,
                      onTap: controller.onWithdrawButtonTap),
                ),
              ),
            ));
  }

/*   ClipRRect deliveryFilter(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                      color: Colors.white.withOpacity(0.4),
                    )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(18.0, 0.0, 12, 0.0),
                            child: const Text(
                              'Withdraw',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
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
                                  image:
                                      Image.asset(AppAssetImages.walletsvglogo)
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
                      AppGaps.hGap12,
                      Row(
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
                      ),

                      AppGaps.hGap10,
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
                      ),
                      AppGaps.hGap5,
                      // const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(10),
                              width: 290,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: CustomStretchedTextButtonWidget(
                                  buttonText: "Send to card",
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor:
                                          Colors.transparent.withOpacity(0.0),
                                      builder: (BuildContext context) {
                                        // return addAccountDelivery();
                                        return AppGaps.emptyGap;
                                      },
                                    );
                                  }))
                        ],
                      ),
                      // const Spacer(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  } */
}
