import 'package:ecomikdeliveryapp/controller/delivery_reg_controller.dart';
import 'package:ecomikdeliveryapp/models/api_responses/pick_up_stations_response.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_colors.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_gaps.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_images.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SetupDeliveryManInfoScreen extends StatelessWidget {
  const SetupDeliveryManInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryRegInfoController>(
        init: DeliveryRegInfoController(),
        global: false,
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Empty appbar with back button --------> */
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context, titleWidget: const Text('')),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image.asset(
                                              AppAssetImages.logoAndText)
                                          .image))),
                          AppGaps.hGap10,
                          HighlightAndDetailTextWidget(
                              isSpaceShorter: true,
                              slogan: LanguageHelper.currentLanguageText(
                                  LanguageHelper.deliveryManInfoTransKey),
                              subtitle: ''),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          //==================================
                          CustomTextFormField(
                            controller: controller.locationController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.addressTransKey),
                            hintText: '  Green Street 738, NY, USA',
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.locationSVGLogoLine),
                          ),
                          AppGaps.hGap15,

                          CustomTextFormField(
                            controller: controller.taxNameController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.taxNameTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.yourTaxNameTransKey),
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.profileSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            controller: controller.taxNumberController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.taxNumberTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.taxNumberTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap15,

                          CustomTextFormField(
                            controller: controller.nidNumberController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.nidNumberTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.nidNumberTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap24,
                          CustomTextFormField(
                            controller: controller.countryController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.countryTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.countryTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap24,
                          CustomTextFormField(
                            controller: controller.stateController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.stateTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.stateTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap24,
                          CustomTextFormField(
                            controller: controller.cityController,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.cityTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.cityTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap24,
                          CustomTextFormField(
                            controller: controller.zipController,
                            textInputType: TextInputType.number,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.zipCodeTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.zipCodeTransKey),
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                          ),
                          AppGaps.hGap24,
                          /* <---- Pickup Station field ----> */
                          DropdownButtonFormFieldWidget<
                              PickUpStationDocResponse>(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.pickUpStationTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.pickUpStationTransKey),
                            value: controller.selectedPickUpStation,
                            prefixIcon: SvgPicture.asset(AppAssetImages.task),
                            items: controller.pickUpStations,
                            getItemText: (value) => value.name,
                            onChanged: (value) {
                              controller.selectedPickUpStation = value!;
                              controller.update();
                            },
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.nationalIdTransKey),
                                style: const TextStyle(
                                    color: AppColors.darkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Container(
                            height: 126,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18))),
                            child: Builder(
                                builder: (context) => controller
                                        .deliveryManDetails
                                        .deliveryMan
                                        .nidImage
                                        .isEmpty
                                    ? SelectImageButton(
                                        onTap:
                                            controller.onNIDCardImageButtonTap)
                                    : SelectedNetworkImageWidget(
                                        imageURL: controller.deliveryManDetails
                                            .deliveryMan.nidImage,
                                        onEditButtonTap:
                                            controller.onNIDCardImageButtonTap,
                                      )),
                          ),
                          AppGaps.hGap24,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.profileImageTransKey),
                                style: const TextStyle(
                                    color: AppColors.darkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Container(
                            height: 126,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18))),
                            child: Builder(
                                builder: (context) => controller
                                        .deliveryManDetails
                                        .deliveryMan
                                        .image
                                        .isEmpty
                                    ? SelectImageButton(
                                        onTap:
                                            controller.onProfileImageButtonTap)
                                    : SelectedNetworkImageWidget(
                                        imageURL: controller.deliveryManDetails
                                            .deliveryMan.image,
                                        onEditButtonTap:
                                            controller.onProfileImageButtonTap,
                                      )),
                          ),
                          AppGaps.hGap24,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.addressProofTransKey),
                                style: const TextStyle(
                                    color: AppColors.darkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          AppGaps.hGap10,
                          Container(
                            height: 126,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18))),
                            child: Builder(
                                builder: (context) => controller
                                        .deliveryManDetails
                                        .deliveryMan
                                        .addressProof
                                        .isEmpty
                                    ? SelectImageButton(
                                        onTap: controller
                                            .onAddressProofImageButtonTap)
                                    : SelectedNetworkImageWidget(
                                        imageURL: controller.deliveryManDetails
                                            .deliveryMan.addressProof,
                                        onEditButtonTap: controller
                                            .onAddressProofImageButtonTap,
                                      )),
                          ),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                ),

                /* <-------- Bottom bar of sign up text --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Sign up text button ----> */
                      CustomStretchedTextButtonWidget(
                          buttonText: LanguageHelper.currentLanguageText(
                              LanguageHelper.applyNowTransKey),
                          onTap: controller.onApplyNowButtonTap)
                    ],
                  ),
                ),
              ),
            ));
  }
}
