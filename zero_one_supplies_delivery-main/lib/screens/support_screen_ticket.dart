import 'package:ecomikdeliveryapp/controller/support_ticket_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SupportTicketScreen extends StatelessWidget {
  const SupportTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<SupportTicketScreenController>(
        init: SupportTicketScreenController(),
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
                    titleWidget: Text(AppLanguageTranslation
                        .addNewTicketTransKey.toCurrentLanguage)),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .nameTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .yourNameTransKey.toCurrentLanguage,
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.profileSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .emailAddressTransKey.toCurrentLanguage,
                            hintText: '  contact@gmail.com',
                            prefixIcon: Image.asset(AppAssetImages.email),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .subjectTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .writeYourSubjectTransKey.toCurrentLanguage,
                            // prefixIcon: Image.asset(AppAssetImages.smsedit),
                          ),
                          /* <---- Department text field ----> */
                          AppGaps.hGap15,
                          Text(
                            AppLanguageTranslation
                                .departmentTransKey.toCurrentLanguage,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppGaps.hGap5,
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                // labelText: '',
                                // hintText: 'Select Option',
                                border: OutlineInputBorder(),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.dropdownValue,
                                  onChanged: (String? newValue) {
                                    controller.dropdownValue = newValue!;
                                    controller.update();
                                  },
                                  items: <String>[
                                    'Select Option',
                                    'One',
                                    'Two',
                                    'Three',
                                    'Four'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),

                          /* <---- Categories text field ----> */
                          AppGaps.hGap15,
                          Text(
                            AppLanguageTranslation
                                .categoriesTransKey.toCurrentLanguage,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppGaps.hGap5,
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                // labelText: '',
                                // hintText: 'Select Option',
                                border: OutlineInputBorder(),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.dropdownValue,
                                  onChanged: (String? newValue) {
                                    controller.dropdownValue = newValue!;
                                    controller.update();
                                  },
                                  items: <String>[
                                    'Select Option',
                                    'One',
                                    'Two',
                                    'Three',
                                    'Four'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),

                          /* <---- Types text field ----> */
                          AppGaps.hGap15,
                          Text(
                            AppLanguageTranslation
                                .typesTransKey.toCurrentLanguage,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppGaps.hGap5,
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                // labelText: '',
                                // hintText: 'Select Option',
                                border: OutlineInputBorder(),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.dropdownValue,
                                  onChanged: (String? newValue) {
                                    controller.dropdownValue = newValue!;
                                    controller.update();
                                  },
                                  items: <String>[
                                    'Select Option',
                                    'One',
                                    'Two',
                                    'Three',
                                    'Four'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          /* <---- Types text field ----> */
                          AppGaps.hGap15,
                          Text(
                            AppLanguageTranslation
                                .prioritiesTransKey.toCurrentLanguage,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AppGaps.hGap5,
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                // labelText: '',
                                // hintText: 'Select Option',
                                border: OutlineInputBorder(),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.dropdownValue,
                                  onChanged: (String? newValue) {
                                    controller.dropdownValue = newValue!;
                                  },
                                  items: <String>[
                                    'Select Option',
                                    'One',
                                    'Two',
                                    'Three',
                                    'Four'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          AppGaps.hGap15,
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .writeMessageTransKey.toCurrentLanguage,
                            // hintText: '  Your Name',
                            // prefixIcon:
                            //     SvgPicture.asset(AppAssetImages.profileSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          Container(
                            height: 175,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(15),
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          image: DecorationImage(
                                              image: Image.asset(
                                                      AppAssetImages.upload)
                                                  .image,
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      // margin: const EdgeInsets.all(15),
                                      // height: 24,
                                      // width: 24,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLanguageTranslation
                                              .browseAndChooseToUploadTransKey
                                              .toCurrentLanguage,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(15),
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          image: DecorationImage(
                                              image: Image.asset(
                                                      AppAssetImages.plus)
                                                  .image,
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
                          buttonText: AppLanguageTranslation
                              .submitTransKey.toCurrentLanguage,
                          onTap: () {
                            Get.toNamed(AppPageNames.chatSupportScreen);
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
