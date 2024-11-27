import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/pick_up_stations_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/setup_delivery_man_info_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/single_image_upload_response.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_repo.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';

class DeliveryRegInfoController extends GetxController {
  DeliveryManDataResponse deliveryManDetails = DeliveryManDataResponse.empty();
  TextEditingController deliveryManNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController nidNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  List<PickUpStationDocResponse> pickUpStations = [];
  PickUpStationDocResponse selectedPickUpStation =
      PickUpStationDocResponse.empty();
  ScrollController storeLogoImagesScrollController = ScrollController();
  String token = '';

  void onSuccessUploadStoreLogoImage(SingleImageUploadResponse response) async {
    deliveryManDetails.deliveryMan.image = response.data;
    update();
    Helper.showSnackBar(LanguageHelper.currentLanguageText(
        LanguageHelper.successfullyUpdatedTransKey));
  }

/*   void pickStoreLogoImages() async {
    final List<image_picker.XFile>? pickedImages =
        await ImagePickerHelper.getPhoneImages();
    if (pickedImages == null) {
      return;
    }
    processStoreLogoImages(pickedImages);
    AppDialogs.showImageProcessingDialog();
  } */

  void onProfileImageButtonTap() {
    Helper.pickImage(
        onSuccessUploadSingleImage: onProfileImageSuccess, token: token);
  }

  void onProfileImageSuccess(
      SingleImageUploadResponse response, Map<String, dynamic> additionalData) {
    deliveryManDetails.deliveryMan.image = response.data;
    update();
    Helper.showSnackBar(LanguageHelper.currentLanguageText(
        LanguageHelper.successUploadingNIDTransKey));
  }

  void onNIDCardImageButtonTap() {
    Helper.pickImage(
        onSuccessUploadSingleImage: onUploadNIDCardImageSuccess, token: token);
  }

  void onUploadNIDCardImageSuccess(
      SingleImageUploadResponse response, Map<String, dynamic> additionalData) {
    deliveryManDetails.deliveryMan.nidImage = response.data;
    update();
    Helper.showSnackBar(LanguageHelper.currentLanguageText(
        LanguageHelper.successUploadingNIDTransKey));
  }

  void onAddressProofImageButtonTap() {
    Helper.pickImage(
        onSuccessUploadSingleImage: onSuccessUploadAddressProofImage,
        token: token);
  }

  void onSuccessUploadAddressProofImage(SingleImageUploadResponse response,
      Map<String, dynamic> additionalData) async {
    deliveryManDetails.deliveryMan.addressProof = response.data;
    update();
    Helper.showSnackBar(LanguageHelper.currentLanguageText(
        LanguageHelper.successUploadingAddressProofImageTransKey));
  }

/*
  Future<void> getStoreCategories() async {
    StoreCategoriesResponse? response = await APIRepo.getStoreCategories();
    if (response == null) {
      onErrorGetStoreCategories(response);
      return;
    } else if (response.error) {
      onFailureGetStoreCategories(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetStoreCategories(response);
  }

  void onErrorGetStoreCategories(StoreCategoriesResponse? response) {}

  void onFailureGetStoreCategories(StoreCategoriesResponse response) {}

  void onSuccessGetStoreCategories(StoreCategoriesResponse response) {
    storeCategories = response.data;
    update();
  }
*/
  void onApplyNowButtonTap() {
    // Get.toNamed(AppPageNames.addCardScreen);
    setDeliveryManDetails();
  }

/*
  void onStoreCategoryChanged(StoreCategory? value) {
    selectedStoreCategory = value;
  }
  */

  void setDeliveryManDetailsInitially() {
    deliveryManDetails = Helper.getUser();
    locationController.text = deliveryManDetails.deliveryMan.address;
    taxNameController.text = deliveryManDetails.deliveryMan.taxName;
    taxNumberController.text = deliveryManDetails.deliveryMan.taxNumber;
    nidNumberController.text = deliveryManDetails.deliveryMan.nidNumber;
    countryController.text = deliveryManDetails.deliveryMan.country;
    stateController.text = deliveryManDetails.deliveryMan.state;
    cityController.text = deliveryManDetails.deliveryMan.city;
    zipController.text = deliveryManDetails.deliveryMan.zipcode;
    update();
  }

  Map<String, dynamic> setDeliveryManDetailsRequestBody() {
    final requestBody = <String, dynamic>{
      'address': locationController.text,
      'tax_name': taxNameController.text,
      'tax_number': taxNumberController.text,
      'nid_number': nidNumberController.text,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'zipcode': zipController.text,
      'pickup_station': selectedPickUpStation.id,
      'nid_image': deliveryManDetails.deliveryMan.nidImage,
      'address_proof': deliveryManDetails.deliveryMan.addressProof,
      'image': deliveryManDetails.deliveryMan.image,
    };
    if (deliveryManDetails.id.isNotEmpty) {
      requestBody['_id'] = deliveryManDetails.id;
    }
    return requestBody;
  }

  Future<void> setDeliveryManDetails() async {
    final Map<String, dynamic> requestBody = setDeliveryManDetailsRequestBody();
    String requestBodyJson = jsonEncode(requestBody);
    SetupDeliveryManInfoResponse? response =
        await APIRepo.setDeliveryManInfo(requestBodyJson, token: token);
    if (response == null) {
      onErrorSetVendorDetails(response);
      return;
    } else if (response.error) {
      onFailureSetVendorDetails(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessSetVendorDetails(response);
  }

  void onErrorSetVendorDetails(SetupDeliveryManInfoResponse? response) {
    AppDialogs.showErrorDialog(
        messageText: response?.msg ??
            LanguageHelper.currentLanguageText(
                LanguageHelper.noResponseFoundTransKey));
  }

  void onFailureSetVendorDetails(SetupDeliveryManInfoResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessSetVendorDetails(SetupDeliveryManInfoResponse response) async {
    await updateDeliveryMan();
    update();
    Helper.showSnackBar(response.msg);
    Get.back();
    Get.back();
    Get.back();
    // getLoggedInVendorDetails();
  }

  Future<void> updateDeliveryMan() async {
    final currentUpdatedDeliveryMan = Helper.getUser();
    currentUpdatedDeliveryMan.deliveryMan.address = locationController.text;
    currentUpdatedDeliveryMan.deliveryMan.taxName = taxNameController.text;
    currentUpdatedDeliveryMan.deliveryMan.taxNumber = taxNumberController.text;
    currentUpdatedDeliveryMan.deliveryMan.nidNumber = nidNumberController.text;
    currentUpdatedDeliveryMan.deliveryMan.pickupStation =
        selectedPickUpStation.id;
    currentUpdatedDeliveryMan.deliveryMan.nidImage =
        deliveryManDetails.deliveryMan.nidImage;
    currentUpdatedDeliveryMan.deliveryMan.addressProof =
        deliveryManDetails.deliveryMan.addressProof;
    await Helper.setLoggedInUserToLocalStorage(currentUpdatedDeliveryMan);
  }

  Future<void> _getPickUpStations() async {
    PickUpStationsResponse? response = await APIRepo.getPickUpStations(1000);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.noResponseFoundTransKey));
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.somethingWrongTransKey));
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPickUpStations(response);
  }

  onSuccessRetrievingPickUpStations(PickUpStationsResponse response) {
    pickUpStations = response.data.docs;
    selectedPickUpStation = pickUpStations[0];
    for (PickUpStationDocResponse singlePickUpStation in pickUpStations) {
      if (singlePickUpStation.id ==
          deliveryManDetails.deliveryMan.pickupStation) {
        selectedPickUpStation = singlePickUpStation;
      }
    }
    update();
  }
/*
  Future<void> getLoggedInVendorDetails() async {
    VendorDetailsResponse? response = await APIRepo.getVendorDetails();
    if (response == null) {
      onErrorGetLoggedInVendorDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInVendorDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInVendorDetails(response);
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void onErrorGetLoggedInVendorDetails(VendorDetailsResponse? response) {}

  void onFailureGetLoggedInVendorDetails(VendorDetailsResponse response) {}

  void onSuccessGetLoggedInVendorDetails(VendorDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
  } */

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      token = argument;
    }
  }

  void _clearForm() {
    pickUpStations = [];
    selectedPickUpStation = PickUpStationDocResponse.empty();
  }

  @override
  void onInit() {
    _clearForm();
    _getScreenParameter();
    _getPickUpStations();
    if (token.isEmpty) {
      setDeliveryManDetailsInitially();
    }
    super.onInit();
  }

  @override
  void onClose() {
    deliveryManNameController.dispose();
    locationController.dispose();
    taxNameController.dispose();
    taxNumberController.dispose();
    nidNumberController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.onClose();
  }
}
