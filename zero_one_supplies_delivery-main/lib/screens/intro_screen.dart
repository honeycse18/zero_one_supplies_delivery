import 'package:ecomikdeliveryapp/controller/intro_screen_controller.dart';
import 'package:ecomikdeliveryapp/models/fake_data.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/intro_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<IntroScreenController>(
        init: IntroScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Content --------> */
                body: SafeArea(
                  top: true,
                  bottom: true,
                  left: true,
                  right: true,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: FakeData.fakeIntroContents.length,
                            itemBuilder: (context, index) {
                              /// Single intro screen data
                              final fakeIntroContent =
                                  FakeData.fakeIntroContents[index];
                              /* <---- Single Intro screen widget ----> */
                              return Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        context.mediaQueryViewPadding.top + 90),
                                child: IntroContentWidget(
                                    screenSize: screenSize,
                                    localImageLocation:
                                        fakeIntroContent.localSVGImageLocation,
                                    slogan: fakeIntroContent.slogan,
                                    subtitle: fakeIntroContent.content),
                              );
                            },
                          ),
                        ),
                        AppGaps.hGap10,
                        if (FakeData.fakeIntroContents.length > 1)
                          SmoothPageIndicator(
                            controller: controller.pageController,
                            count: FakeData.fakeIntroContents.length,
                            axisDirection: Axis.horizontal,
                            effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 2,
                                expansionFactor: 3,
                                activeDotColor: AppColors.primaryColor,
                                dotColor: AppColors.darkColor.withOpacity(0.2)),
                          ),
                        AppGaps.hGap50,
                      ]),
                ),
                /* <-------- Bottom bar --------> */
                // bottomNavigationBar: CustomScaffoldBottomBarWidget(
                //   child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         /* <---- Next button ----> */
                //         CustomStretchedTextButtonWidget(
                //             buttonText: 'Register',
                //             onTap: () {
                //               // _gotoNextIntroSection(context);
                //             }),
                //         /* <---- Skip button ----> */
                //         TextButton(
                //             onPressed: () {
                //               // Goto sign in screen.
                //               // Get.toNamed(context, AppPageNames.signInScreen);
                //             },
                //             child: const Text('Login'))
                //       ]),
                // ),

                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: CustomStretchedTextButtonWidget(
                              buttonText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.registrarTransKey),
                              onTap: () {
                                // Go to delivery info screen
                                // Goto sign up screen.
                                Get.toNamed(AppPageNames.signUpScreen);
                              }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: CustomStretcheOutlinedButtonWidget(
                              child: Text(LanguageHelper.currentLanguageText(
                                  LanguageHelper.logInTransKey)),
                              onTap: () {
                                Get.toNamed(AppPageNames.signInScreen);
                              }),
                        ),
                      ),
                      // AppGaps.hGap19,
                    ],
                  ),
                ),
              ),
            ));
  }
}
