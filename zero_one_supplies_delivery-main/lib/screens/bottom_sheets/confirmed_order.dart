import 'package:ecomikdeliveryapp/controller/bottom_sheets/confirmed_order_bottom_sheet_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/confirmed_delivery_requests_api_response.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ConfirmedOrderBottomSheet extends StatelessWidget {
  const ConfirmedOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<ConfirmedOrderBottomSheetController>(
        init: ConfirmedOrderBottomSheetController(),
        builder: (controller) => Container(
              height: screenHeight * 0.8,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 5),
              child: ClipRRect(
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGaps.hGap18,
                        Text(
                            AppLanguageTranslation
                                .confirmedOrdersTransKey.toCurrentLanguage,
                            style: AppTextStyles.titleSmallSemiboldTextStyle),
                        AppGaps.hGap18,
                        Row(
                          children: [
                            Expanded(
                                child: TabToggleButtonWidget(
                                    onTap: () {
                                      controller.isCurrentTabDeliveryRequest =
                                          false;
                                    },
                                    isSelected:
                                        !controller.isCurrentTabDeliveryRequest,
                                    text: AppLanguageTranslation
                                        .ordersTransKey.toCurrentLanguage)),
                            AppGaps.wGap5,
                            Expanded(
                                child: TabToggleButtonWidget(
                                    onTap: () {
                                      controller.isCurrentTabDeliveryRequest =
                                          true;
                                    },
                                    isSelected:
                                        controller.isCurrentTabDeliveryRequest,
                                    text: AppLanguageTranslation
                                        .deliveryRequestsTransKey
                                        .toCurrentLanguage))
                          ],
                        ),
                        AppGaps.hGap18,
                        Expanded(
                            child: RefreshIndicator(
                          onRefresh: () async => controller
                                  .isCurrentTabDeliveryRequest
                              ? controller
                                  .confirmedDeliveryRequestsPagingController
                                  .refresh()
                              : controller.confirmedOrdersPagingController
                                  .refresh(),
                          child: Builder(builder: (context) {
                            if (controller.isCurrentTabDeliveryRequest) {
                              return PagedListView.separated(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 12),
                                pagingController: controller
                                    .confirmedDeliveryRequestsPagingController,
                                builderDelegate:
                                    CoreWidgets.pagedChildBuilderDelegate<
                                        ConfirmedDeliveryRequest>(
                                  itemBuilder: (index, item, context) =>
                                      CustomListTileWidget(
                                          // onTap: () {},
                                          child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                AppLanguageTranslation
                                                    .deliveryRequestsTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodyTextStyle),
                                          ),
                                          Text(
                                              Helper
                                                  .getCurrencyFormattedAmountText(
                                                      item.total),
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle)
                                        ],
                                      ),
                                      AppGaps.hGap8,
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item.deliveryNumber,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle),
                                          Text(
                                              item.paymentMethodName
                                                  .viewableText,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor))
                                        ],
                                      ),
                                      AppGaps.hGap12,
                                      /*                                       if (item.products.isNotEmpty)
                                    Row(
                                      children: [
                                        SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: CachedNetworkImageWidget(
                                                imageURL: item
                                                    .products.first.image,
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ))),
                                        AppGaps.wGap12,
                                        Expanded(
                                          child: Text(
                                              item.products.first.name,
                                              maxLines: 2,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        item.products.first
                                                            .price),
                                                style: AppTextStyles
                                                    .bodyLargeSemiboldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor)),
                                            Text(
                                                '${item.products.first.quantity} ${item.products.first.unit}',
                                                style: AppTextStyles
                                                    .bodyTextStyle),
                                          ],
                                        )
                                      ],
                                    ), */
                                    ],
                                  )),
                                  noItemFoundIndicatorBuilder: (context) =>
                                      Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(AppLanguageTranslation
                                            .noConfirmedOrderTransKey
                                            .toCurrentLanguage)
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap10,
                              );
                            }
                            return PagedListView.separated(
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 12),
                              pagingController:
                                  controller.confirmedOrdersPagingController,
                              builderDelegate: CoreWidgets
                                  .pagedChildBuilderDelegate<ConfirmedOrder>(
                                itemBuilder: (index, item, context) =>
                                    CustomListTileWidget(
                                        // onTap: () {},
                                        child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .orderIdTransKey),
                                              style:
                                                  AppTextStyles.bodyTextStyle),
                                        ),
                                        Text(
                                            Helper
                                                .getCurrencyFormattedAmountText(
                                                    item.total),
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle)
                                      ],
                                    ),
                                    AppGaps.hGap8,
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.orderNumber,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle),
                                        Text(
                                            item.paymentMethodName.viewableText,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor))
                                      ],
                                    ),
                                    AppGaps.hGap12,
                                    /*                                     if (item.products.isNotEmpty)
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CachedNetworkImageWidget(
                                              imageURL:
                                                  item.products.first.image,
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit
                                                                .cover)),
                                                  ))),
                                      AppGaps.wGap12,
                                      Expanded(
                                        child: Text(
                                            item.products.first.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              Helper
                                                  .getCurrencyFormattedAmountText(
                                                      item.products.first
                                                          .price),
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor)),
                                          Text(
                                              '${item.products.first.quantity} ${item.products.first.unit}',
                                              style: AppTextStyles
                                                  .bodyTextStyle),
                                        ],
                                      )
                                    ],
                                  ), */
                                  ],
                                )),
                                noItemFoundIndicatorBuilder: (context) =>
                                    Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(AppLanguageTranslation
                                          .noConfirmedOrderTransKey
                                          .toCurrentLanguage)
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap10,
                            );
                          }),
                        )),
                        // AppGaps.hGap30,
                      ]),
                ),
              ),
            ));
  }
}
