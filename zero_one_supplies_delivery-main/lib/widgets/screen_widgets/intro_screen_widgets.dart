import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Per intro page content widget
class IntroContentWidget extends StatelessWidget {
  final Size screenSize;
  final String localImageLocation;
  final String slogan;
  final String subtitle;
  const IntroContentWidget({
    super.key,
    required this.localImageLocation,
    required this.slogan,
    required this.subtitle,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(localImageLocation, height: 240),
          AppGaps.hGap20,
          HighlightAndDetailTextWidget(slogan: slogan, subtitle: subtitle),
        ],
      ),
    );
  }
}
