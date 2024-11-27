import 'package:ecomikdeliveryapp/controller/add_method_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddWithdrawMethodScreen extends StatelessWidget {
  const AddWithdrawMethodScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<AddMethodScreenController>(
        global: false,
        init: AddMethodScreenController(),
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
                    screenContext: context,
                    titleWidget: Text(controller.targetMethod.name)),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppGaps.screenPaddingValue),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGaps.hGap15,
                        /* <---- User full name text field ----> */
                        CustomTextFormField(
                          controller: controller.accountHolderNameController,
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.accountHolderNameTransKey),
                          hintText:
                              '  ${controller.deliveryManDetails.firstName} ${controller.deliveryManDetails.lastName}',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.profileSVGLogoLine),
                        ),
                        AppGaps.hGap15,
                        /* <---- User full name text field ----> */
                        CustomTextFormField(
                          controller: controller.accountHolderEmailController,
                          labelText: LanguageHelper.currentLanguageText(
                              LanguageHelper.emailAddressTransKey),
                          hintText: ' ${controller.deliveryManDetails.email}',
                          prefixIcon: Image.asset(AppAssetImages.email),
                        ),

                        /* <---- Email text field ----> */

                        /* <---- Password text field ----> */
                      ],
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
                          buttonText:
                              '${LanguageHelper.currentLanguageText(LanguageHelper.addTransKey)}  ${controller.targetMethod.name}',
                          onTap: controller.onAddButtonTap)
                    ],
                  ),
                ),
              ),
            ));
  }
}
