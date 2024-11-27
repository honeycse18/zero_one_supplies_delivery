import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomikdeliveryapp/models/api_responses/active_status_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/order_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_active_status_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_order_details_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Drawer content list widgets
class DrawerList extends StatelessWidget {
  final DeliveryManDataResponse deliveryManDetails;
  final GlobalKey<ScaffoldState> homeScaffoldKey;
  final void Function()? onConfirmedOrdersTap;
  final void Function()? onSettingsTap;
  const DrawerList({
    super.key,
    required this.deliveryManDetails,
    required this.homeScaffoldKey,
    this.onConfirmedOrdersTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // borderRadius: const BorderRadius.only( topRight: Radius.circular(100),),
          // color: Color.lerp(Colors.white, Colors.black, 0.2),
          ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap50,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomIconButtonWidget(
                      onTap: () {
                        Get.back();
                      },
                      backgroundColor: Colors.white.withOpacity(0.5),
                      child: SvgPicture.asset(
                        AppAssetImages.closeSVGLogoLine,
                        color: Colors.black,
                      )),
                ],
              ),
              AppGaps.hGap20,
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  height: 83,
                  width: 83,
                  child: CachedNetworkImageWidget(
                      imageURL: deliveryManDetails.deliveryMan.image,
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          )),
                ),
                /* CircleAvatar(
                  backgroundImage: Image.asset(
                    AppAssetImages.myAccountProfilePicture,
                  ).image,
                  radius: 44,
                ) */
                AppGaps.wGap24,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${deliveryManDetails.firstName} ${deliveryManDetails.lastName}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.black),
                      ),
                      AppGaps.hGap10,
                      /* <---- Profile phone number ----> */
                      Text(deliveryManDetails.phone,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.7))),
                      AppGaps.hGap5,
                      /* <---- Profile email address ----> */
                      Text(deliveryManDetails.email,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.7))),
                    ],
                  ),
                )
              ]),
              AppGaps.hGap48,

              DrawerMenuWidget(
                  text: AppLanguageTranslation
                      .seeConfirmedOrdersTransKey.toCurrentLanguage,
                  localAssetIconName: AppAssetImages.noteSVGLogoDualTone,
                  onTap: onConfirmedOrdersTap),
              AppGaps.hGap24,
              DrawerMenuWidget(
                  text: AppLanguageTranslation.chatTransKey.toCurrentLanguage,
                  localAssetIconName: AppAssetImages.messageSVGLogoLine,
                  onTap: () {
                    Get.toNamed(AppPageNames.chatRecipientScreen);
                  }),
              AppGaps.hGap24,
              DrawerMenuWidget(
                  text: LanguageHelper.currentLanguageText(
                      LanguageHelper.updateDeliveryManRegistrationTransKey),
                  localAssetIconName: AppAssetImages.noteSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.setupDeliveryManInfoScreen);
                  }),
              AppGaps.hGap24,
              /* <---- Notification drawer menu button ----> */
/*               DrawerMenuWidget(
                  text: 'Notification',
                  localAssetIconName:
                      AppAssetImages.notificationSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.notificationsScreen);
                  }),
              AppGaps.hGap24,

              /* <---- Insight drawer menu button ----> */
              DrawerMenuWidget(
                  text: 'Insight',
                  localAssetIconName: AppAssetImages.chartSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.insightScreen);
                  }),
              AppGaps.hGap24,
              */
              /* <---- Wallet drawer menu button ----> */
              DrawerMenuWidget(
                  text: LanguageHelper.currentLanguageText(
                      LanguageHelper.myWalletTransKey),
                  localAssetIconName: AppAssetImages.walletSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.myWalletScreen);
                  }),
              AppGaps.hGap24,
              DrawerMenuWidget(
                  text: AppLanguageTranslation
                      .paymentHistoryTransKey.toCurrentLanguage,
                  localAssetIconName: AppAssetImages.paymentHistoryIconlTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.paymentHistory);
                  }),
              AppGaps.hGap24,
              /*
              /* <---- Support drawer menu button ----> */
              DrawerMenuWidget(
                  text : 'Support Ticket',
                  localAssetIconName: AppAssetImages.supportSVGLogo,
                  onTap: () {
                    Get.toNamed(AppPageNames.supportScreen);
                  }),
              AppGaps.hGap24,
              /* <---- Review drawer menu button ----> */
              DrawerMenuWidget(
                  text: 'Contact Us',
                  localAssetIconName: AppAssetImages.contactUsSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.contactUsScreen);
                  }),

              AppGaps.hGap24, */
              /* <---- Terms and conditions drawer menu button ----> */
              DrawerMenuWidget(
                  text: LanguageHelper.currentLanguageText(
                      LanguageHelper.termsConditionTransKey),
                  localAssetIconName: AppAssetImages.noteSVGLogoDualTone,
                  onTap: () {
                    Get.toNamed(AppPageNames.termsConditionScreen);
                  }),
              AppGaps.hGap24,
              /* <---- Setting drawer menu button ----> */
              DrawerMenuWidget(
                  text: LanguageHelper.currentLanguageText(
                      LanguageHelper.settingTransKey),
                  localAssetIconName: AppAssetImages.settingSVGLogoDualTone,
                  onTap: onSettingsTap),

              AppGaps.hGap24,
              /* <---- Sign out drawer menu button ----> */
              DrawerMenuWidget(
                  text: LanguageHelper.currentLanguageText(
                      LanguageHelper.signOutTransKey),
                  localAssetIconName: AppAssetImages.logoutSVGLogoDualTone,
                  onTap: () {
                    Helper.logout();
                  }),
              // Bottom extra spaces
              AppGaps.hGap50,
            ],
          ),
        ),
      ),
    );
  }
}

/// Single drawer menu widget
class DrawerMenuWidget extends StatelessWidget {
  final String text;
  final String localAssetIconName;
  final void Function()? onTap;
  const DrawerMenuWidget({
    super.key,
    required this.text,
    required this.localAssetIconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              fixedSize: const Size(48, 48),
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: SvgPicture.asset(
                localAssetIconName,
                color: AppColors.primaryColor,
                height: 24,
                width: 24,
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            Transform.scale(
                scaleX: -1,
                child: SvgPicture.asset(AppAssetImages.arrowLeftSVGLogoLine,
                    color: Colors.black.withOpacity(0.6))),
          ],
        ));
  }
}

/// Delivery single product details list tile
class DeliveryProductListTile extends StatelessWidget {
  final String productImageURL;
  final String name;
  final int itemCount;
  final double price;
  const DeliveryProductListTile({
    super.key,
    required this.productImageURL,
    required this.name,
    required this.itemCount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, bottom: 16, right: 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: CachedNetworkImageWidget(
              imageURL: productImageURL,
              imageBuilder: (context, imageProvider) => Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
          ),
          AppGaps.wGap8,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
              AppGaps.hGap8,
              Text(
                  '$itemCount ${LanguageHelper.currentLanguageText(LanguageHelper.itemTransKey)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.bodyTextColor,
                      )),
            ],
          )),
          Text(
            Helper.getCurrencyFormattedAmountText(price),
            // '\$$priceText',
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class SlidingUpPanelBottomWidget extends StatelessWidget {
  final OrderStatus orderStatus;
  final void Function()? onPrimaryButtonTap;
  final void Function()? onCancelButtonTap;
  const SlidingUpPanelBottomWidget({
    super.key,
    required this.orderStatus,
    this.onPrimaryButtonTap,
    this.onCancelButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    switch (orderStatus) {
      case OrderStatus.pending:
        return _PendingBottomButtonWidget(
            primaryButtonText: nextStepPrimaryButtonText,
            onPrimaryButtonTap: onPrimaryButtonTap,
            cancelButtonText: LanguageHelper.currentLanguageText(
                LanguageHelper.declineDeliveryTransKey),
            onCancelButtonTap: onCancelButtonTap);
      case OrderStatus.accepted:
        return CustomStretchedTextButtonWidget(
            buttonText: nextStepPrimaryButtonText, onTap: onPrimaryButtonTap);
      case OrderStatus.rejected:
        return CustomStretchedTextButtonWidget(
            buttonText: nextStepPrimaryButtonText, onTap: null);
      case OrderStatus.picked:
        return CustomStretchedTextButtonWidget(
            buttonText: nextStepPrimaryButtonText, onTap: onPrimaryButtonTap);
      case OrderStatus.onWay:
        return CustomStretchedTextButtonWidget(
            buttonText: nextStepPrimaryButtonText, onTap: onPrimaryButtonTap);
      case OrderStatus.delivered:
        return CustomStretchedTextButtonWidget(
            buttonText: nextStepPrimaryButtonText, onTap: null);
      default:
        return const _InvisibleBottomButtonWidget();
    }
  }

  String get nextStepPrimaryButtonText {
    switch (orderStatus) {
      case OrderStatus.pending:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.acceptDeliveryTransKey);
      case OrderStatus.accepted:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.markAsPickedTransKey);
      case OrderStatus.rejected:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.deliveryRejectedTransKey);
      case OrderStatus.picked:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.markAsOnWayTransKey);
      case OrderStatus.onWay:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.markAsDeliveredTransKey);
      case OrderStatus.delivered:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.orderIsDeliveredTransKey);
      default:
        return '';
    }
  }
}

class _PendingBottomButtonWidget extends StatelessWidget {
  const _PendingBottomButtonWidget({
    required this.primaryButtonText,
    required this.onPrimaryButtonTap,
    required this.cancelButtonText,
    required this.onCancelButtonTap,
  });

  final String primaryButtonText;
  final void Function()? onPrimaryButtonTap;
  final String cancelButtonText;
  final void Function()? onCancelButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomStretchedTextButtonWidget(
            buttonText: primaryButtonText,
            onTap: onPrimaryButtonTap,
          ),
        ),
        AppGaps.wGap10,
        Expanded(
          child: CustomStretchedOutlinedTextButtonWidget(
            backgroundColor: AppColors.shadeColor1,
            buttonText: cancelButtonText,
            onTap: onCancelButtonTap,
          ),
        ),
      ],
    );
  }
}

class _InvisibleBottomButtonWidget extends StatelessWidget {
  const _InvisibleBottomButtonWidget();

  @override
  Widget build(BuildContext context) {
    return AppGaps.emptyGap;
  }
}

class OrderPriceAmountRowWidget extends StatelessWidget {
  final String amountName;
  final double amount;
  const OrderPriceAmountRowWidget({
    super.key,
    required this.amountName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          amountName,
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.w500),
        ),
        Text(Helper.getCurrencyFormattedAmountText(amount),
            style: const TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class PanelBuilderContentWidget extends StatelessWidget {
  final HomeScreenStatus screenStatus;
  final OrderType orderOfType;
  final OrderStatus orderStatus;
  final UpdatedOrderDetails orderDetails;
  final ScrollController scrollController;
  final Widget gpsButtonWidget;
  final Widget customerMessageCallButton;
  final List<ActiveStatusDeliveryItem> orders;
  final void Function(ActiveStatusDeliveryItem) onOrderTap;
  final void Function()? onBackButtonTap;
  final Future<void> Function() onRefresh;
  const PanelBuilderContentWidget({
    super.key,
    required this.scrollController,
    required this.gpsButtonWidget,
    required this.customerMessageCallButton,
    required this.screenStatus,
    required this.orderStatus,
    required this.orders,
    required this.onOrderTap,
    required this.orderDetails,
    this.onBackButtonTap,
    required this.onRefresh,
    required this.orderOfType,
  });

  @override
  Widget build(BuildContext context) {
    switch (screenStatus) {
      case HomeScreenStatus.orderList:
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
              // controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList.separated(
                    // delegate: SliverChildBuilderDelegate(
                    //   (context, index) {
                    //     final order = orders[index];
                    //     return CustomListTileWidget(
                    //         onTap: () => onOrderTap(order),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.stretch,
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text(
                    //                 LanguageHelper.currentLanguageText(
                    //                     LanguageHelper.orderIdTransKey),
                    //                 style: AppTextStyles.bodyTextStyle),
                    //             AppGaps.hGap8,
                    //             Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(order.order.orderNumber,
                    //                     style: AppTextStyles
                    //                         .bodyLargeSemiboldTextStyle),
                    //                 Text(
                    //                     OrderStatus.toEnumValue(order.status)
                    //                         .viewableText,
                    //                     style: AppTextStyles
                    //                         .bodyLargeSemiboldTextStyle)
                    //               ],
                    //             ),
                    //           ],
                    //         ));
                    //   },
                    //   childCount: orders.length,
                    // ),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return CustomListTileWidget(
                          onTap: () => onOrderTap(order),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      order.orderType == OrderType.productOrder
                                          ? LanguageHelper.currentLanguageText(
                                              LanguageHelper.orderIdTransKey)
                                          : 'Request Id',
                                      style: AppTextStyles.bodyTextStyle),
                                  Text(
                                      order.orderType == OrderType.productOrder
                                          ? OrderType.productOrder.viewableText
                                          : OrderType
                                              .deliveryRequest.viewableText,
                                      style: AppTextStyles.bodyTextStyle)
                                ],
                              ),
                              AppGaps.hGap8,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      order.orderType == OrderType.productOrder
                                          ? order.order.orderNumber
                                          : order
                                              .deliveryRequest.deliveryNumber,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle),
                                  Text(order.statusAsEnum.viewableText,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle)
                                ],
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        AppGaps.hGap10,
                    itemCount: orders.length,
                  ),
                )
              ]),
        );
      case HomeScreenStatus.currentOrderDetails:
        return orderOfType == OrderType.deliveryRequest
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomScaffoldBodyWidget(
                      child: Row(
                        children: [
                          CustomIconButtonWidget(
                              onTap: onBackButtonTap,
                              child: SvgPicture.asset(
                                  AppAssetImages.arrowLeftSVGLogoLine)),
                          const Expanded(
                              child: Text(
                            'Delivery Request',
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                  SliverToBoxAdapter(
                      child: CustomScaffoldBodyWidget(
                          child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.darkColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ))),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                  SliverToBoxAdapter(
                      child: CustomScaffoldBodyWidget(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CachedNetworkImageWidget(
                            imageURL: orderDetails.deliveryRequest.productImages
                                    .firstOrNull ??
                                '',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft:
                                          AppComponents.defaultBorderRadius,
                                      topRight:
                                          AppComponents.defaultBorderRadius,
                                      bottomLeft:
                                          AppComponents.defaultBorderRadius,
                                      bottomRight:
                                          AppComponents.defaultBorderRadius),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        AppGaps.wGap20,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Product Summary :',
                                style: AppTextStyles.bodySemiboldTextStyle
                                    .copyWith(color: AppColors.primaryColor)),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Given Weight :',
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Expanded(
                                  child: Text(
                                    '${orderDetails.deliveryRequest.weight} KG',
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Actual Weight :',
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Expanded(
                                  child: Text(
                                    '${orderDetails.deliveryRequest.deliveryCharge.chargeInfo.packageCharge.packageWeight} KG',
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Length :',
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Expanded(
                                  child: Text(
                                    '${orderDetails.deliveryRequest.dimensions.length} CM',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Height :',
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Expanded(
                                  child: Text(
                                    '${orderDetails.deliveryRequest.dimensions.height} CM',
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Width :',
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Expanded(
                                  child: Text(
                                    '${orderDetails.deliveryRequest.dimensions.width} CM',
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                          ],
                        ))
                      ],
                    ),
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap15),
                  SliverToBoxAdapter(
                      child: CustomScaffoldBodyWidget(
                          child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.darkColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ))),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 6),
                                    color: AppColors.primaryColor
                                        .withOpacity(0.35),
                                    blurRadius: 15)
                              ]),
                          child: SvgPicture.asset(
                              AppAssetImages.locationSVGLogoLine,
                              height: 18,
                              width: 18,
                              color: Colors.white),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                            child: Text(
                          orderDetails.deliveryRequest.receiver.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                        customerMessageCallButton,
                      ],
                    ),
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(left: 40),
                      padding: const EdgeInsets.only(left: 34),
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(color: AppColors.primaryColor))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderDetails.deliveryRequest.receiver.phone,
                              style: const TextStyle(
                                  color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap10,
                            Text(
                              orderDetails.deliveryRequest.receiver.email,
                              style: const TextStyle(
                                  color: AppColors.bodyTextColor),
                            ),
                            // AppGaps.hGap10,
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),

                  /* <---- Order details ----> */
                  SliverToBoxAdapter(
                    child: CustomScaffoldBodyWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Package Charge :',
                              style: AppTextStyles.bodyLargeSemiboldTextStyle
                                  .copyWith(color: AppColors.primaryColor)),
                          AppGaps.hGap20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Weight Charge (per KG) :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    Helper.getCurrencyFormattedAmountText(
                                        orderDetails
                                            .deliveryRequest
                                            .deliveryCharge
                                            .chargeInfo
                                            .packageCharge
                                            .packageWeightPerKg),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Package Weight :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    '${orderDetails.deliveryRequest.deliveryCharge.chargeInfo.packageCharge.packageWeight} KG',
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Package Charge :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    Helper.getCurrencyFormattedAmountText(
                                        orderDetails
                                            .deliveryRequest
                                            .deliveryCharge
                                            .chargeInfo
                                            .packageCharge
                                            .total),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),

                  /* <---- Order details ----> */
                  SliverToBoxAdapter(
                    child: CustomScaffoldBodyWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delivery Charge :',
                              style: AppTextStyles.bodyLargeSemiboldTextStyle
                                  .copyWith(color: AppColors.primaryColor)),
                          AppGaps.hGap20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Delivery Charge (per KM) :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    Helper.getCurrencyFormattedAmountText(
                                        orderDetails
                                            .deliveryRequest
                                            .deliveryCharge
                                            .chargeInfo
                                            .shippingCharge
                                            .deliveryChargePerKm),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Distance :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    '${orderDetails.deliveryRequest.deliveryCharge.chargeInfo.shippingCharge.totalDistanceInKm} KM',
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Delivery Charge :',
                                  style: AppTextStyles.bodyMediumTextStyle),
                              Expanded(
                                child: Text(
                                    Helper.getCurrencyFormattedAmountText(
                                        orderDetails
                                            .deliveryRequest
                                            .deliveryCharge
                                            .chargeInfo
                                            .shippingCharge
                                            .total),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.bodyMediumTextStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap120),
                ],
              )
            : CustomScrollView(controller: scrollController, slivers: [
                /* <---- First product image and name row ----> */
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomIconButtonWidget(
                          onTap: onBackButtonTap,
                          child: SvgPicture.asset(
                              AppAssetImages.arrowLeftSVGLogoLine)),
                      AppGaps.wGap10,
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 24,
                                backgroundImage: CachedNetworkImageProvider(
                                    orderDetails.outerOrder.orders.firstOrNull
                                            ?.products.firstOrNull?.image ??
                                        '')),
                            AppGaps.wGap16,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderDetails.outerOrder.orders.firstOrNull
                                          ?.products.firstOrNull?.name ??
                                      '',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                AppGaps.hGap8,
                                Text(
                                  // '13.4km (20 min)',
                                  orderStatus.viewableText,
                                  style: const TextStyle(
                                      color: AppColors.bodyTextColor),
                                ),
                              ],
                            )),
                            // gpsButtonWidget,
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                const SliverToBoxAdapter(child: AppGaps.hGap32),
                /* <---- Shopkeeper name ----> */
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 34,
                        width: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 6),
                                  color:
                                      AppColors.primaryColor.withOpacity(0.35),
                                  blurRadius: 15)
                            ]),
                        child: SvgPicture.asset(
                            AppAssetImages.locationSVGLogoLine,
                            height: 18,
                            width: 18,
                            color: Colors.white),
                      ),
                      AppGaps.wGap16,
                      Expanded(
                          child: Text(
                        '${orderDetails.outerOrder.user.firstName} ${orderDetails.outerOrder.user.lastName}',
                        style: Theme.of(context).textTheme.labelLarge,
                      )),
                      customerMessageCallButton,
                    ],
                  ),
                )),
                /* <---- Shopkeeper address ----> */
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 40),
                    padding: const EdgeInsets.only(left: 34),
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: AppColors.primaryColor))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderDetails.outerOrder.user.email,
                            style:
                                const TextStyle(color: AppColors.bodyTextColor),
                          ),
                          AppGaps.hGap10,
                          Text(
                            orderDetails.outerOrder.user.phone,
                            style:
                                const TextStyle(color: AppColors.bodyTextColor),
                          ),
                          // AppGaps.hGap10,
                        ],
                      ),
                    ),
                  ),
                ),
                /* <---- Customer name ----> */
/*           SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 34,
                  width: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: AppColors.primaryColor.withOpacity(0.35),
                            blurRadius: 15)
                      ]),
                  child: SvgPicture.asset(AppAssetImages.mapSVGLogoLine,
                      height: 18, width: 18, color: Colors.white),
                ),
                AppGaps.wGap16,
                Expanded(
                    child: Text(
                  'Jessica Herry',
                  style: Theme.of(context).textTheme.labelLarge,
                ))
              ],
            ),
          )),
          /* <---- Customer address ----> */
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 74),
              child: Text(
                'Dumbo Street, New York, USA',
                style: TextStyle(color: AppColors.bodyTextColor),
              ),
            ),
          ), */
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                /* <---- Horizontal dashed line ----> */
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: CustomHorizontalDashedLineWidget(
                        color: AppColors.lineShapeColor),
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.orderInfoTransKey),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap16),
                /* <---- Delivering product list ----> */
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  /// Single product
                  final product = (orderDetails.outerOrder.orders.firstOrNull ??
                          StoreWiseOrder.empty())
                      .products[index];
                  return DeliveryProductListTile(
                    productImageURL: product.image,
                    name: product.name,
                    itemCount: product.quantity,
                    price: product.subtotal,
                  );
                },
                        childCount:
                            (orderDetails.outerOrder.orders.firstOrNull ??
                                    StoreWiseOrder.empty())
                                .products
                                .length)),
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                SliverToBoxAdapter(
                    child: CustomScaffoldBodyWidget(
                        child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation
                          .paymentMethodTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                    AppGaps.hGap10,
                    Text(
                      orderDetails.outerOrder.paymentMethodStatus.viewableText,
                      style: AppTextStyles.bodyLargeMediumTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ))),
                const SliverToBoxAdapter(child: AppGaps.hGap16),
                SliverToBoxAdapter(
                    child: CustomScaffoldBodyWidget(
                        child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation
                          .paymentStatusTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                    AppGaps.hGap10,
                    Text(
                      orderDetails.outerOrder.paymentStatus,
                      style: AppTextStyles.bodyLargeMediumTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ))),
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                /* <---- 'Cash on delivery' and price text row ----> */
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: orderDetails.outerOrder.paymentStatus == 'pending'
                      ? Column(
                          children: [
                            OrderPriceAmountRowWidget(
                                amountName: LanguageHelper.currentLanguageText(
                                    LanguageHelper.subTotalTransKey),
                                amount: orderDetails.outerOrder.subtotal),
                            AppGaps.hGap15,
                            OrderPriceAmountRowWidget(
                                amountName: LanguageHelper.currentLanguageText(
                                    LanguageHelper.vatTransKey),
                                amount: orderDetails.outerOrder.vat),
                            AppGaps.hGap15,
                            OrderPriceAmountRowWidget(
                                amountName: LanguageHelper.currentLanguageText(
                                    LanguageHelper.pickedStationChargeTransKey),
                                amount: orderDetails.destination.charge),
                            AppGaps.hGap15,
                            OrderPriceAmountRowWidget(
                                amountName: LanguageHelper.currentLanguageText(
                                    LanguageHelper.deliveryChargeTransKey),
                                amount: orderDetails
                                    .outerOrder.delivery.address.totalCost),
                            AppGaps.hGap15,
                            OrderPriceAmountRowWidget(
                                amountName: LanguageHelper.currentLanguageText(
                                    LanguageHelper.totalTransKey),
                                amount: orderDetails.outerOrder.total),
                          ],
                        )
                      : Center(
                          child: Text(AppLanguageTranslation
                              .paymentPaidTransKey.toCurrentLanguage),
                        ),
                )),
                // Bottom spaces (24 for extra spaces)
                const SliverToBoxAdapter(child: SizedBox(height: 150 + 24)),
              ]);
      default:
        return AppGaps.emptyGap;
    }
  }
}
