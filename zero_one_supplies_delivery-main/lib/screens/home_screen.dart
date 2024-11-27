import 'package:ecomikdeliveryapp/controller/home_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Bottom slider panel controller

  @override
  Widget build(BuildContext context) {
    const double bottomSlidingUpPanelTotalMargin = 48;
    // final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        global: false,
        builder: (controller) => WillPopScope(
              onWillPop: () async => controller.onWillPop(context),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Scaffold(
                  key: controller.homeScaffoldKey,
                  /* <-------- Appbar --------> */
                  appBar: CoreWidgets1.appBarWidget(
                      screenContext: context,
                      hasBackButton: false,
                      /* <---- Show drawer button ----> */
                      leading: Center(
                        child: Builder(builder: (context) {
                          return CustomIconButtonWidget(
                              onTap: () {
                                // if (controller.homeScaffoldKey.currentState !=
                                //         null &&
                                //     !controller.homeScaffoldKey.currentState!
                                //         .isDrawerOpen) {
                                //   controller.homeScaffoldKey.currentState
                                //       ?.openDrawer();
                                // }
                                Scaffold.of(context).openDrawer();
                              },
                              hasShadow: true,
                              child: SvgPicture.asset(
                                AppAssetImages.menuSVGLogoLine,
                                color: AppColors.darkColor,
                                height: 12,
                                width: 12,
                              ));
                        }),
                      ),
                      titleWidget: Text(controller.getScreenTitle()),
                      /* <---- Offline / online status change toggle button ----> */
                      actions: [
                        Center(
                          child: FlutterSwitch(
                            value: controller.homeScreenStatus !=
                                HomeScreenStatus.offline,
                            width: 35,
                            height: 20,
                            toggleSize: 12,
                            activeColor: AppColors.successColor,
                            inactiveColor: AppColors.alertColor,
                            onToggle: controller.onStatusToggle,
                          ),
                        ),
                        AppGaps.wGap20,
                      ]),
                  /* <-------- Drawer --------> */
                  drawer: Drawer(
                    // backgroundColor: Colors.transparent,
                    child: DrawerList(
                        homeScaffoldKey: controller.homeScaffoldKey,
                        deliveryManDetails: controller.deliveryManDetails,
                        onConfirmedOrdersTap:
                            controller.onConfirmedOrdersDrawerMenuTap,
                        onSettingsTap: () async {
                          await Get.toNamed(AppPageNames.settingsScreen);
                          controller.update();
                        }),
                  ),
                  /* <-------- Content --------> */
                  body: SlidingUpPanel(
                      controller: controller.panelController,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      backdropEnabled: true,
                      backdropColor: AppColors.lineShapeColor,
                      margin: const EdgeInsets.only(left: 24, right: 24),
                      backdropOpacity: 0.8,
                      boxShadow: const [],
                      color: Colors.transparent,
                      minHeight: 200,
                      /* <---- Bottom slider top notch portion ----> */
                      header: SizedBox(
                        width:
                            screenSize.width - bottomSlidingUpPanelTotalMargin,
                        height: 100,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                                top: 12,
                                child: SvgPicture.asset(
                                    AppAssetImages.slideUpPanelNotchSVG,
                                    color: const Color.fromARGB(
                                        234, 240, 240, 240))),
                            Positioned(
                                top: 22,
                                child: SvgPicture.asset(
                                  AppAssetImages.arrowUpSVGLogoLine,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.5),
                                  width: 40,
                                ))
                          ],
                        ),
                      ),
                      /* <---- Bottom slider bottom button portion ----> */
                      footer: controller.homeScreenStatus !=
                              HomeScreenStatus.currentOrderDetails
                          ? null
                          : Container(
                              width: screenSize.width -
                                  bottomSlidingUpPanelTotalMargin,
                              height: 65 + 24,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              alignment: Alignment.topCenter,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30)),
                              ),
                              child: SlidingUpPanelBottomWidget(
                                orderStatus: controller.orderStatus,
                                onPrimaryButtonTap:
                                    controller.onBottomButtonTap,
                                onCancelButtonTap:
                                    controller.onBottomCancelButtonTap,
                              )),
                      /* <---- Bottom slider content ----> */
                      panelBuilder: (sc) => Container(
                            margin: const EdgeInsets.only(top: 24),
                            padding: const EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: Image.asset(
                                          AppAssetImages.backgroundFullPng)
                                      .image,
                                  fit: BoxFit.fill),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: Image.asset(
                                              AppAssetImages.backgroundFullPng)
                                          .image,
                                      fit: BoxFit.fill)),
                              child: PanelBuilderContentWidget(
                                  orderOfType:
                                      controller.orderDetails.orderType,
                                  onRefresh: () async =>
                                      controller.setStatusOnline(),
                                  screenStatus: controller.homeScreenStatus,
                                  orderStatus: controller.orderStatus,
                                  orderDetails: controller.orderDetails,
                                  scrollController: sc,
                                  orders: controller
                                      .activeOrderStatusData.deliveryItems,
                                  gpsButtonWidget:
                                      controller.getGPSUpArrowButton(),
                                  customerMessageCallButton: controller
                                      .getCustomerMessageCallButtons(),
                                  onOrderTap: controller.onOrderTap,
                                  onBackButtonTap: controller.onBackButtonTap),
                            ),
                          ),
                      /* <---- Actual content ----> */
                      body: DecoratedBox(
                        decoration: const BoxDecoration(
                            /* image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: controller.currentHomeScreenStatus ==
                                      HomeScreenStatus.offline
                                  ? Alignment.topCenter
                                  : Alignment.center,
                              /* <---- Demo map location background image ----> */
                              image: Image.asset(
                                      controller.currentHomeScreenStatus ==
                                              HomeScreenStatus.offline
                                          ? AppAssetImages
                                              .offlineMapBackgroundDemoImage
                                          : AppAssetImages
                                              .deliveryInfoBackgroundDemoImage)
                                  .image) */
                            ),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          initialCameraPosition:
                              AppSingleton.instance.defaultCameraPosition,
                          markers: controller.googleMapMarkers,
                          polylines: controller.googleMapPolylines,
                          onMapCreated: controller.onGoogleMapCreated,
                          onTap: controller.onGoogleMapTap,
                        ),
                      )),
                ),
              ),
            ));
  }
}
