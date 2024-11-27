import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Delivered success single statistics card widget
class DeliveredSuccessDetailWidget extends StatelessWidget {
  final String detailTitle;
  final String detailText;
  final void Function()? onTextButtonTap;
  final String buttonText;
  final String iconLocalAssetName;
  const DeliveredSuccessDetailWidget({
    super.key,
    required this.detailTitle,
    required this.detailText,
    this.onTextButtonTap,
    required this.buttonText,
    required this.iconLocalAssetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          border: Border.all(color: AppColors.lineShapeColor),
          borderRadius:
              const BorderRadius.all(AppComponents.defaultBorderRadius)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(iconLocalAssetName,
              height: 32, width: 32, color: AppColors.primaryColor),
          AppGaps.wGap16,
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap3,
              Text(
                detailTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.bodyTextColor),
              ),
              AppGaps.hGap8,
              Text(detailText, style: Theme.of(context).textTheme.labelLarge),
              AppGaps.hGap8,
              CustomTightTextButtonWidget(
                onTap: onTextButtonTap,
                child: Text(buttonText),
              )
            ],
          )),
        ],
      ),
    );
  }
}
