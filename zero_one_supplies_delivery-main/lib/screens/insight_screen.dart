import 'package:ecomikdeliveryapp/controller/Insight_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/insight_screen_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Set graph label text style
    final graphLabelTextStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: AppColors.bodyTextColor);
    return GetBuilder<InsightScreenController>(
        init: InsightScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(AppLanguageTranslation
                        .insightTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top extra spaces
                      AppGaps.hGap15,
                      /* <---- 3 colored 3 statistics row ----> */
                      SizedBox(
                        height: 135,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* <---- Orders total data widget ----> */
                                Container(
                                  width: 130,
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          AppComponents.defaultBorderRadius),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomIconButtonWidget(
                                          borderRadiusRadiusValue:
                                              const Radius.circular(8),
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                          child: SvgPicture.asset(
                                            AppAssetImages.cartSVGLogoLine,
                                            color: Colors.white,
                                          )),
                                      AppGaps.hGap16,
                                      Text(
                                        '45',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      AppGaps.hGap4,
                                      Text(
                                        AppLanguageTranslation
                                            .ordersTransKey.toCurrentLanguage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                                AppGaps.wGap16,
                                /* <---- Ride total data widget ----> */
                                Container(
                                  height: 135,
                                  width: 130,
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          AppComponents.defaultBorderRadius),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomIconButtonWidget(
                                          borderRadiusRadiusValue:
                                              const Radius.circular(8),
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: SvgPicture.asset(
                                            AppAssetImages.cartSVGLogoLine,
                                            color: Colors.white,
                                          )),
                                      AppGaps.hGap16,
                                      Text(
                                        '68km',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      AppGaps.hGap4,
                                      Text(
                                        AppLanguageTranslation
                                            .rideTransKey.toCurrentLanguage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                                AppGaps.wGap16,
                                /* <---- Earning total data widget ----> */
                                Container(
                                  height: 135,
                                  width: 130,
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          AppComponents.defaultBorderRadius),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomIconButtonWidget(
                                          borderRadiusRadiusValue:
                                              const Radius.circular(8),
                                          backgroundColor:
                                              AppColors.tertiaryColor,
                                          child: SvgPicture.asset(
                                            AppAssetImages
                                                .walletSVGLogoDualTone,
                                            color: Colors.white,
                                          )),
                                      AppGaps.hGap16,
                                      Text(
                                        '\$238.00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      AppGaps.hGap4,
                                      Text(
                                        AppLanguageTranslation
                                            .earningsTransKey.toCurrentLanguage,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      AppGaps.hGap32,
                      /* <---- 'Earnings' and date select dropdown menu row ----> */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .earningsTransKey.toCurrentLanguage,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          PopupMenuButton<int>(
                              padding: const EdgeInsets.only(right: 5),
                              position: PopupMenuPosition.under,
                              // icon: const Icon(Icons.more_vert_rounded, color: AppColors.darkColor),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .todayTransKey.toCurrentLanguage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor),
                                  ),
                                  AppGaps.wGap2,
                                  SvgPicture.asset(
                                      AppAssetImages.arrowDown2SVGLogoSolid,
                                      height: 12,
                                      width: 12,
                                      color: AppColors.primaryColor),
                                ],
                              ),
                              itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 0,
                                      // padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        AppLanguageTranslation.yesterdayTransKey
                                            .toCurrentLanguage,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ]),
                        ],
                      ),
                      AppGaps.hGap32,
                      /* <---- Linear graph for insight ----> */
                      InsightLineGraphWidget(
                        spots: const [
                          FlSpot(0, 75),
                          FlSpot(10, 50),
                          FlSpot(20, 65),
                          FlSpot(30, 57),
                          FlSpot(40, 70),
                          FlSpot(50, 25),
                          FlSpot(60, 75),
                          FlSpot(70, 70),
                          FlSpot(80, 110),
                          FlSpot(90, 105),
                          FlSpot(100, 150),
                          FlSpot(110, 75),
                          FlSpot(120, 120),
                          FlSpot(130, 125),
                          FlSpot(140, 130),
                          FlSpot(150, 75),
                          FlSpot(160, 50),
                          FlSpot(170, 55),
                          FlSpot(180, 25),
                          FlSpot(190, 75),
                          FlSpot(200, 50),
                          FlSpot(210, 60),
                          FlSpot(220, 50),
                        ],
                        leftTitleWidgets: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '0';
                              break;
                            case 50:
                              text = '50';
                              break;
                            case 100:
                              text = '100';
                              break;
                            case 150:
                              text = '150';
                              break;
                            case 200:
                              text = '200';
                              break;
                            default:
                              return AppGaps.emptyGap;
                          }

                          return Text(text,
                              style: graphLabelTextStyle,
                              textAlign: TextAlign.left);
                        },
                        bottomTitleWidgets: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '10:00';
                              break;
                            case 44:
                              text = '11:00';
                              break;
                            case 88:
                              text = '12:00';
                              break;
                            case 132:
                              text = '13:00';
                              break;
                            case 176:
                              text = '14:00';
                              break;
                            case 220:
                              text = '15:00';
                              break;
                            default:
                              return AppGaps.emptyGap;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: Text(
                              text,
                              style: graphLabelTextStyle,
                            ),
                          );
                        },
                      ),
                      /* <---- 'View all transaction' centered text button ----> */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomTightTextButtonWidget(
                            child: Text(AppLanguageTranslation
                                .viewAllTransactionsTransKey.toCurrentLanguage),
                            onTap: () {},
                          )
                        ],
                      ),
                      AppGaps.hGap32,
                      /* <---- 'Orders' and date dropdown menu row ----> */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .ordersTransKey.toCurrentLanguage,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          PopupMenuButton<int>(
                              padding: const EdgeInsets.only(right: 5),
                              position: PopupMenuPosition.under,
                              // icon: const Icon(Icons.more_vert_rounded, color: AppColors.darkColor),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .todayTransKey.toCurrentLanguage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor),
                                  ),
                                  AppGaps.wGap2,
                                  SvgPicture.asset(
                                      AppAssetImages.arrowDown2SVGLogoSolid,
                                      height: 12,
                                      width: 12,
                                      color: AppColors.primaryColor),
                                ],
                              ),
                              itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 0,
                                      // padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        AppLanguageTranslation.yesterdayTransKey
                                            .toCurrentLanguage,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ]),
                        ],
                      ),
                      AppGaps.hGap32,
                      /* <---- Insight linear graph ----> */
                      InsightLineGraphWidget(
                        spots: const [
                          FlSpot(0, 75),
                          FlSpot(10, 50),
                          FlSpot(20, 65),
                          FlSpot(30, 57),
                          FlSpot(40, 70),
                          FlSpot(50, 25),
                          FlSpot(60, 75),
                          FlSpot(70, 70),
                          FlSpot(80, 110),
                          FlSpot(90, 105),
                          FlSpot(100, 150),
                          FlSpot(110, 75),
                          FlSpot(120, 120),
                          FlSpot(130, 125),
                          FlSpot(140, 130),
                          FlSpot(150, 75),
                          FlSpot(160, 50),
                          FlSpot(170, 55),
                          FlSpot(180, 25),
                          FlSpot(190, 75),
                          FlSpot(200, 50),
                          FlSpot(210, 60),
                          FlSpot(220, 50),
                        ],
                        leftTitleWidgets: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '0';
                              break;
                            case 50:
                              text = '50';
                              break;
                            case 100:
                              text = '100';
                              break;
                            case 150:
                              text = '150';
                              break;
                            case 200:
                              text = '200';
                              break;
                            default:
                              return AppGaps.emptyGap;
                          }

                          return Text(text,
                              style: graphLabelTextStyle,
                              textAlign: TextAlign.left);
                        },
                        bottomTitleWidgets: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '10:00';
                              break;
                            case 44:
                              text = '11:00';
                              break;
                            case 88:
                              text = '12:00';
                              break;
                            case 132:
                              text = '13:00';
                              break;
                            case 176:
                              text = '14:00';
                              break;
                            case 220:
                              text = '15:00';
                              break;
                            default:
                              return AppGaps.emptyGap;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: Text(
                              text,
                              style: graphLabelTextStyle,
                            ),
                          );
                        },
                      ),
                      // Bottom extra spaces
                      AppGaps.hGap30,
                    ],
                  ),
                )),
              ),
            ));
  }
}
