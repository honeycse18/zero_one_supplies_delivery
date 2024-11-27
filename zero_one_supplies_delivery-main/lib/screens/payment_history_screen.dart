import 'package:ecomikdeliveryapp/controller/payment_history_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/payment_history_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/payment_history_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentHistoryScreenController>(
        init: PaymentHistoryScreenController(),
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
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.paymentHistoryTransKey),
                    )),
                /* <-------- Content --------> */
                body: RefreshIndicator(
                  onRefresh: () async =>
                      controller.paymentHistoryPagingController.refresh(),
                  child: CustomScaffoldBodyWidget(
                      child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap10,
                      ),
                      PagedSliverList.separated(
                        pagingController:
                            controller.paymentHistoryPagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<PaymentHistoryItem>(
                                noItemsFoundIndicatorBuilder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EmptyScreenWidget(
                                  image: AppAssetImages.noTransaction,
                                  title: AppLanguageTranslation
                                      .noHistoryFoundTransKey.toCurrentLanguage,
                                  shortTitle: ''),
                            ],
                          );
                        }, itemBuilder: (context, item, index) {
                          final PaymentHistoryItem history = item;

                          return PaymentHistoryTileWidget(
                            amount: history.amount,
                            date: history.createdAt,
                            orderId: history.order,
                          );
                        }),
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                      ),
                    ],
                  )),
                ),
              ),
            ));
  }
}
