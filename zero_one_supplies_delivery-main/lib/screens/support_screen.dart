import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: Image.asset(AppAssetImages.backgroundFullPng).image,
              fit: BoxFit.fill)),
      child: Scaffold(
        // ----------------appbar--------
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleWidget: Text(AppLanguageTranslation
                .supportTicketTransKey.toCurrentLanguage)),
        // / <-------- Content --------> /
        body: SafeArea(
            // top: true,
            child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 356,
                  child: Column(
                    children: [
                      // / <---- Illustration image ----> /
                      Image.asset(AppAssetImages.ticket, height: 240),
                      AppGaps.hGap20,
                      // / <---- Highlighter text and subtitle text ----> /
                      HighlightAndDetailTextWidget(
                          slogan: AppLanguageTranslation
                              .noTicketFoundTransKey.toCurrentLanguage,
                          subtitle: AppLanguageTranslation
                              .youHaveNoSupportTicketTransKey
                              .toCurrentLanguage),
                    ],
                  ),
                ),
              ]),
        )),
        // / <-------- Bottom bar --------> /

        bottomNavigationBar: CustomScaffoldBottomBarWidget(
          child: Row(
            children: [
              Expanded(
                child: CustomStretchedTextButtonWidget(
                    buttonText: AppLanguageTranslation
                        .createNewSupportTicketTransKey.toCurrentLanguage,
                    onTap: () {
                      // Go to delivery info screen
                      Get.toNamed(AppPageNames.supportTicketScreen);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
