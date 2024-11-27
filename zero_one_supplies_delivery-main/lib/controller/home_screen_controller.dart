import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:ecomikdeliveryapp/controller/bottom_sheets/confirmed_order_bottom_sheet_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/active_status_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/order_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/order_list_web_socket_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_active_status_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_confirm_order_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_order_details_response.dart';
import 'package:ecomikdeliveryapp/models/core_api_responses/raw_api_response.dart';
import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order_notify_response.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_orders_response.dart';
import 'package:ecomikdeliveryapp/screens/bottom_sheets/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends GetxController {
  final PanelController panelController = PanelController();
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  final String riderMarkerID = 'riderID';
  final String pickupMarkerID = 'pick_up_marker_id';
  final String dropMarkerID = 'drop_marker_id';
  final String markerID = 'markerID';
  bool isLocationSelected = false;
  ActiveStatusUpdated activeOrderStatusData = ActiveStatusUpdated.empty();
  OrderStatus orderStatus = OrderStatus.pending;
  UpdatedOrderDetails orderDetails = UpdatedOrderDetails.empty();
  DeliveryManDataResponse deliveryManDetails = Helper.getUser();
  DateTime currentBackPressTime = AppComponents.defaultUnsetDateTime;

  /// Global of home scaffold key for opening drawer
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? googleMapController;

  /// Current status
  HomeScreenStatus homeScreenStatus = HomeScreenStatus.offline;
  // final Completer<GoogleMapController> googleMapControllerCompleter = Completer<GoogleMapController>();
  Timer timer = Timer(
    const Duration(seconds: 1),
    () {},
  );
  IO.Socket socket = IO.io(
      Constants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(APIHelper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  dynamic onConfirmOrders(dynamic data) {
    final ConfirmOrderUpdatedResponse confirmOrders =
        ConfirmOrderUpdatedResponse.getAPIResponseObjectSafeValue(data);
    if (Get.isBottomSheetOpen ?? false) {
      final confirmedOrderBottomSheetController =
          Get.find<ConfirmedOrderBottomSheetController>();
      if (!confirmedOrderBottomSheetController.isClosed) {
        confirmedOrderBottomSheetController.confirmedOrdersPagingController
            .refresh();
      }
    } else {
      onConfirmedOrdersDrawerMenuTap();
    }
    log(confirmOrders.toJson().toString());
    update();
  }

  dynamic onNewDeliveryOrder(dynamic data) {
    final OrderListWebSocketResponse newOrder =
        OrderListWebSocketResponse.getAPIResponseObjectSafeValue(data);
    if (newOrder.data.reload) {
      setStatusOnline();
      update();
    }
  }

  ({String message, String title}) notificationTitleMessage(
      ConfirmedOrderNotifyResponse notificationDetails) {
    switch (notificationDetails.notificationType) {
      case ConfirmedOrderNotificationType.confirmOrder:
        return ((
          title:
              'New order - ${notificationDetails.order.notificationData.orderNumber} is confirmed',
          message: AppLanguageTranslation
              .pickupYourOrderedPackageNowTransKey.toCurrentLanguage
        ));
      case ConfirmedOrderNotificationType.unknown:
        return ((title: '', message: ''));
    }
  }

/*   dynamic onConfirmOrderNotify(dynamic data) {
    final confirmedOrderNotificationDetails =
        ConfirmedOrderNotifyResponse.getAPIResponseObjectSafeValue(data);
    log(confirmedOrderNotificationDetails.toJson().toString());
    final notificationDetails =
        notificationTitleMessage(confirmedOrderNotificationDetails);
    Helper.showNotification(
        title: notificationDetails.title, message: notificationDetails.message);
    update();
  } */

  void _initializeSocketIO() {
    socket.on('new_delivery_order_notify', onNewDeliveryOrder);
    socket.on('confirm_orders', onConfirmOrders);
    // socket.on('confirm_order_notify', onConfirmOrderNotify);
    socket.onConnect((data) {
      log('data');
    });
    socket.onConnectError((data) {
      log('data'.toString());
    });
    socket.onConnecting((data) {
      log('data'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data');
    });
    socket.onReconnectAttempt((data) {
      log('data');
    });
    socket.onReconnect((data) {
      log('data');
    });
    socket.onReconnectFailed((data) {
      log('data');
    });
    socket.onReconnectError((data) {
      log('data');
    });
    socket.onError((data) {
      log('data');
    });
    socket.onDisconnect((data) {
      log('data');
    });
    socket.onPing((data) {
      log('data');
    });
    socket.onPong((data) {
      log('data');
    });
  }

  void onBackButtonTap() {
    setStatusOnline();
    homeScreenStatus = HomeScreenStatus.orderList;
    orderStatus = OrderStatus.pending;
    orderDetails = UpdatedOrderDetails.empty();
    _removePickupMapLocationMarker();
    _removeDropMapLocationMarker();
    update();
  }

  void onBottomButtonTap() {
/*     switch (homeScreenStatus) {
      case HomeScreenStatus.online:
        homeScreenStatus = HomeScreenStatus.newTask;
        update();
        break;
      case HomeScreenStatus.newTask:
        homeScreenStatus = HomeScreenStatus.pickedTask;
        update();
        break;
      case HomeScreenStatus.pickedTask:
        Get.toNamed(AppPageNames.deliveredSuccessScreen);
        break;
      default:
        homeScreenStatus = HomeScreenStatus.newTask;
        update();
    } */
    switch (orderStatus) {
      case OrderStatus.pending:
        AppDialogs.showConfirmDialog(
          messageText: AppLanguageTranslation
              .areYouSureToAcceptThisOrderTransKey.toCurrentLanguage,
          onYesTap: () => setAcceptDeclineOrder(
              orderID: orderDetails.id,
              orderStatus: OrderStatus.accepted.stringValue,
              type: orderDetails.orderType.stringValue),
        );
        return;
      case OrderStatus.accepted:
        AppDialogs.showConfirmDialog(
            messageText: AppLanguageTranslation
                .areYouSureToPickThisProductTransKey.toCurrentLanguage,
            onYesTap: () => updateOrderStatus(
                orderID: orderDetails.id,
                orderStatus: OrderStatus.picked.stringValue,
                type: orderDetails.orderType.stringValue));
        return;
      case OrderStatus.picked:
        AppDialogs.showConfirmDialog(
            messageText: AppLanguageTranslation
                .areYouSureToBeOnTheWayToDeliverThisProductTransKey
                .toCurrentLanguage,
            onYesTap: () => updateOrderStatus(
                orderID: orderDetails.id,
                orderStatus: OrderStatus.onWay.stringValue,
                type: orderDetails.orderType.stringValue));
        return;
      case OrderStatus.onWay:
        AppDialogs.showConfirmDialog(
            messageText: AppLanguageTranslation
                .areYouSureToDeliverThisProductTransKey.toCurrentLanguage,
            onYesTap: () => updateOrderStatus(
                orderID: orderDetails.id,
                orderStatus: OrderStatus.delivered.stringValue,
                type: orderDetails.orderType.stringValue));
        return;
      case OrderStatus.delivered:
        updateOrderStatus(
            orderID: orderDetails.id,
            orderStatus: OrderStatus.delivered.stringValue,
            type: orderDetails.orderType.stringValue);
        return;
      default:
        return;
    }
  }

  void onConfirmedOrdersDrawerMenuTap() {
    if (homeScaffoldKey.currentState != null &&
        homeScaffoldKey.currentState!.isDrawerOpen) {
      homeScaffoldKey.currentState?.closeDrawer();
    }
    Get.bottomSheet(const ConfirmedOrderBottomSheet(),
        isScrollControlled: true, persistent: true, enableDrag: true);
  }

  void onOrderTap(ActiveStatusDeliveryItem order) {
    getCurrentOrderDetails(order.id);
  }

  void onBottomCancelButtonTap() {
    AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .areYouSureToDeclineThisProductTransKey.toCurrentLanguage,
        onYesTap: () => setAcceptDeclineOrder(
            orderID: orderDetails.id,
            orderStatus: OrderStatus.rejected.stringValue,
            type: orderDetails.orderType.stringValue));
  }

  void onStatusToggle(bool value) {
    switch (homeScreenStatus) {
      case HomeScreenStatus.offline:
        setStatusOnline();
        break;
      case HomeScreenStatus.currentOrderDetails:
      case HomeScreenStatus.orderList:
        _setStatusOffline();
        break;
      default:
    }
  }

  Future<void> _setStatusOffline() async {
    await panelController.hide();
    homeScreenStatus = HomeScreenStatus.offline;
    update();
    final Position? currentGPSPosition = await Helper.getGPSLocationData();
    if (currentGPSPosition == null) {
      // _setStatusOffline();
      return;
    }
    updateActiveStatus(
        latitude: currentGPSPosition.latitude,
        longitude: currentGPSPosition.longitude,
        isActive: false);
  }

  Future<void> setStatusOnline() async {
    // await panelController.show();
    homeScreenStatus = HomeScreenStatus.online;
    update();
    final Position? currentGPSPosition = await Helper.getGPSLocationData();
    if (currentGPSPosition == null) {
      // _setStatusOffline();
      return;
    }
    updateActiveStatus(
        latitude: currentGPSPosition.latitude,
        longitude: currentGPSPosition.longitude,
        isActive: true);
  }

  /// Get screen appbar title
  String getScreenTitle() {
    switch (homeScreenStatus) {
      case HomeScreenStatus.offline:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.yourOfflineTransKey);
      case HomeScreenStatus.online:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.yourOnlineTransKey);
      case HomeScreenStatus.orderList:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.yourOrdersTransKey);
      case HomeScreenStatus.currentOrderDetails:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.yourOrderDetailsTransKey);
      default:
        return '';
    }
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
  }

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addRiderMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    // _setAddress(latLng);
    update();
  }

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    // panelController.open();
  }

  void _setAddress(LatLng latLng) async {
    final selectedAddress =
        await Helper.getAddressDetails(latLng.latitude, latLng.longitude);
    if (selectedAddress == null) {
      return;
    }
    isLocationSelected = true;
    // final locationAddressText = Helper.getAddressDetailsText(selectedAddress);
    update();
  }

  Future<void> _addRiderMarker(LatLng latLng) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.riderGPSImage);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(riderMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
  }

/*   /// Get bottom bar text
  String getBottomButtonText() {
    switch (orderStatus) {
      case OrderStatus.pending:
      case HomeScreenStatus.online:
        return 'Accept delivery';
      case HomeScreenStatus.newTask:
        return 'Mark as picked';
      case HomeScreenStatus.pickedTask:
        return 'Mark as delivered';
      default:
        return 'Accept delivery';
    }
  } */

  /// Get gps up arrow button
  Widget getGPSUpArrowButton() {
    if (homeScreenStatus == HomeScreenStatus.online ||
        homeScreenStatus == HomeScreenStatus.currentOrderDetails) {
      return CustomIconButtonWidget(
        onTap: () {},
        fixedSize: const Size(34, 34),
        backgroundColor: AppColors.primaryColor,
        hasShadow: true,
        isCircleShape: true,
        child: SvgPicture.asset(AppAssetImages.gpsUpArrowSVGLogoLine,
            color: Colors.white),
      );
    } else {
      return AppGaps.emptyGap;
    }
  }

  /// Get customer message and call buttons row
  Widget getCustomerMessageCallButtons() {
    if (homeScreenStatus == HomeScreenStatus.online ||
        homeScreenStatus == HomeScreenStatus.currentOrderDetails) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppGaps.wGap5,
/*           CustomIconButtonWidget(
              fixedSize: const Size(20, 20),
              onTap: () {
                Get.toNamed(AppPageNames.chatWithDeliverymanScreen);
              },
              child: SvgPicture.asset(AppAssetImages.messageSVGLogoLine,
                  color: AppColors.primaryColor)), */
          // AppGaps.wGap24,
          CustomIconButtonWidget(
              fixedSize: const Size(20, 20),
              onTap: () async {
                final Uri phoneUri = Uri.parse(
                    'tel:${orderDetails.type != 'delivery_request' ? orderDetails.outerOrder.user.phone : orderDetails.deliveryRequest.receiver.phone}');
                bool canOpenDialer = await canLaunchUrl(phoneUri);
                if (canOpenDialer) {
                  launchUrl(phoneUri);
                }
              },
              child: SvgPicture.asset(AppAssetImages.callingSVGLogoLine,
                  color: AppColors.primaryColor)),
        ],
      );
    } else {
      return AppGaps.emptyGap;
    }
  }

  void _createRoutePolyline(
    List<LatLng> latLngs,
  ) {
    final key = UniqueKey();
    googleMapPolylines.clear();
    googleMapPolylines.add(Polyline(
        polylineId: PolylineId(key.toString()),
        points: latLngs,
        color: AppColors.primaryColor,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        width: 3));
  }

  Future<void> updateActiveStatus(
      {required double latitude,
      required double longitude,
      required bool isActive}) async {
    final Map<String, dynamic> requestBody = {
      'delivery_man': Helper.getUser().id,
      'location': <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude
      },
      'delivery_service': isActive
    };
    final String requestBodyJson = jsonEncode(requestBody);
    ActiveStatusUpdatedResponse? response =
        await APIRepo.updateActiveStatus(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      _setStatusOffline();
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      _setStatusOffline();
      return;
    }
    log(response.toJson().toString());
    _onSuccessUpdateActiveStatus(response, isActive);
  }

  _onSuccessUpdateActiveStatus(
      ActiveStatusUpdatedResponse response, bool isActive) async {
    activeOrderStatusData = response.data;
    if (isActive) {
      homeScreenStatus = HomeScreenStatus.orderList;
      panelController.show();
    } else {
      panelController.hide();
    }
    // Helper.showSnackBar(response.msg);
    // _createOrderRoutePolyline(response.data.orders);
    update();
  }

  Future<void> setAcceptDeclineOrder(
      {required String orderID,
      required String orderStatus,
      required String type}) async {
    final Map<String, dynamic> requestBody = {
      'delivery_id': orderID,
      'status': orderStatus,
      'type': type,
    };
    final String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.updateOrderStatus(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessSetAcceptDeclineOrder(response);
  }

  _onSuccessSetAcceptDeclineOrder(RawAPIResponse response) async {
    final orderStatusString = response.data['order_status'];
    if (orderStatusString is String) {
      orderStatus = OrderStatus.toEnumValue(orderStatusString);
    }
    update();
  }

  Future<void> updateOrderStatus({
    required String orderID,
    required String orderStatus,
    required type,
  }) async {
    final Map<String, dynamic> requestBody = {
      'delivery_id': orderID,
      'status': orderStatus,
      'type': type,
    };
    final String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.updateOrderStatus(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessUpdateOrderStatus(response);
  }

  _onSuccessUpdateOrderStatus(RawAPIResponse response) async {
    final orderStatusString = response.data['order_status'];
    if (orderStatusString is String) {
      orderStatus = OrderStatus.toEnumValue(orderStatusString);
    }
    update();
  }

  Future<void> getCurrentOrderDetails(String orderID) async {
    final UpdatedOrderDetailsResponse? response =
        await APIRepo.getOrderDetails(orderID);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetCurrentOrderDetails(response);
  }

  _onSuccessGetCurrentOrderDetails(UpdatedOrderDetailsResponse response) async {
    orderDetails = response.data;
    homeScreenStatus = HomeScreenStatus.currentOrderDetails;
    orderStatus = OrderStatus.toEnumValue(orderDetails.status);
    /* switch (orderDetails.orderType) {
      case OrderType.productOrder:
        orderStatus = OrderStatus.toEnumValue(orderDetails.outerOrder.status);
        break;
      case OrderType.deliveryRequest:
        orderStatus =
            OrderStatus.toEnumValue(orderDetails.deliveryRequest.status);
        break;
      default:
    } */

    _addPickupMapLocationMarker(orderDetails.destination.location.latitude,
        orderDetails.destination.location.longitude);
    _addDropMapLocationMarker(
        orderDetails.outerOrder.delivery.address.position.latitude,
        orderDetails.outerOrder.delivery.address.position.longitude);
    update();
  }

  Future<void> _addPickupMapLocationMarker(
      double latitude, double longitude) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config =
          createLocalImageConfiguration(context, size: const Size(24, 24));
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.pickupMapLocation);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(latitude, longitude),
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  Future<void> _removePickupMapLocationMarker() async {
    googleMapMarkers
        .removeWhere((element) => element.markerId.value == pickupMarkerID);
  }

  Future<void> _removeDropMapLocationMarker() async {
    googleMapMarkers
        .removeWhere((element) => element.markerId.value == dropMarkerID);
  }

  Future<void> _addDropMapLocationMarker(
      double latitude, double longitude) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config =
          createLocalImageConfiguration(context, size: const Size(24, 24));
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.dropMapLocation);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(latitude, longitude),
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  void _createOrderRoutePolyline(List<ActiveOrder> orders) async {
/*     for (ActiveOrder order in orders) {
      PolylinePoints polylinePoints = PolylinePoints();
      const String googleAPIKey = Constants.googleAPIKey;
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPIKey,
          PointLatLng(
              order.pickupLocation.latitude, order.pickupLocation.longitude),
          PointLatLng(
              order.dropLocation.latitude, order.dropLocation.longitude));
      final pointLatLngs = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      _createRoutePolyline(pointLatLngs);
    } */
    update();
  }

  /* <-------- Initial state --------> */

  void _doPeriodically(Timer timer) async {
    switch (homeScreenStatus) {
      case HomeScreenStatus.offline:
        break;
      case HomeScreenStatus.currentOrderDetails:
        final Position? currentGPSLocation = await Helper.getGPSLocationData();
        if (currentGPSLocation != null) {
          _focusLocation(
              latitude: currentGPSLocation.latitude,
              longitude: currentGPSLocation.longitude,
              showRiderLocation: true);
        }
        break;
      default:
    }
  }

  void _checkDeliveryStatus() {
    final DeliveryManDataResponse user = Helper.getUser();
    if (user.deliveryMan.status != 'approved') {
      Get.offNamed(AppPageNames.waitForApprovalScreen);
    }
  }

  Future<bool> onWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime.year == Constants.defaultUnsetDateTimeYear ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helper.showSnackBar(
          AppLanguageTranslation.tapBackAgainToExitTransKey.toCurrentLanguage);
      return Future.value(false);
    }
    Helper.exitApp();
    return Future.value(true);
  }

  void gotoSignInScreen() {
    Helper.showSnackBar(AppLanguageTranslation
        .sessionExpiredPleaseLoginTransKey.toCurrentLanguage);
    Get.offAllNamed(AppPageNames.signInScreen, arguments: true);
  }

  Future<void> getLoggedInUserDetails() async {
    DeliveryManDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onErrorGetLoggedInUserDetails(DeliveryManDetailsResponse? response) {
    gotoSignInScreen();
  }

  void onFailureGetLoggedInUserDetails(DeliveryManDetailsResponse response) {
    gotoSignInScreen();
  }

  void onSuccessGetLoggedInUserDetails(
      DeliveryManDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
  }

  Future<void> _checkBatteryOptimizationDisabled() async {
    if (Platform.isAndroid) {
/*       await DisableBatteryOptimization.isAllBatteryOptimizationDisabled;
      await DisableBatteryOptimization.showDisableAllOptimizationsSettings(
          'Enable Auto Start',
          'Follow the steps and enable the auto start of this app',
          'Your device has additional battery optimization',
          'Follow the steps and disable the optimizations to allow smooth functioning of this app'); */
      final bool? isAutoStartEnabled =
          await DisableBatteryOptimization.isAutoStartEnabled;
      if (isAutoStartEnabled == false) {
        await DisableBatteryOptimization.showEnableAutoStartSettings(
            'Enable Auto Start',
            'Follow the steps and enable the auto start of this app');
      }
      final bool? isBatteryOptimizationDisabled =
          await DisableBatteryOptimization.isBatteryOptimizationDisabled;
      if (isBatteryOptimizationDisabled == false) {
        final bool? isEnableAutoStartSettingsShown =
            await DisableBatteryOptimization.showEnableAutoStartSettings(
                'Enable Auto Start',
                'Follow the steps and enable the auto start of this app');
      }
/*       final bool? isManBatteryOptimizationDisabled =
          await DisableBatteryOptimization
              .isManufacturerBatteryOptimizationDisabled;
      final bool? isDisableManufacturerBatteryOptimizationSettingsShown =
          await DisableBatteryOptimization
              .showDisableManufacturerBatteryOptimizationSettings(
                  'Your device has additional battery optimization',
                  'Follow the steps and disable the optimizations to allow smooth functioning of this app'); */
    }
  }

  @override
  void onInit() {
    // Verify token
    getLoggedInUserDetails();
    // _checkDeliveryStatus();
    timer = Timer.periodic(const Duration(seconds: 5), _doPeriodically);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (homeScreenStatus == HomeScreenStatus.offline &&
          panelController.isAttached &&
          panelController.isPanelShown) {
        await panelController.hide();

        /* if (mounted) {
          
        } */
      }
    });
    _initializeSocketIO();
    _checkBatteryOptimizationDisabled();
    super.onInit();
  }

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  @override
  void onReady() {
    _checkDeliveryStatus();
    _setNotificationPermission();
    setStatusOnline();
    super.onReady();
  }

  @override
  void onClose() {
    if (timer.isActive) {
      timer.cancel();
    }
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }
}
