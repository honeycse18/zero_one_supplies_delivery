import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class PaymentHistoryTileWidget extends StatelessWidget {
  final String orderId;
  final double amount;
  final DateTime date;
  const PaymentHistoryTileWidget({
    super.key,
    required this.orderId,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LanguageHelper.currentLanguageText(
                    LanguageHelper.orderIdTransKey),
                style: AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
              AppGaps.hGap10,
              Text(
                orderId,
                style: AppTextStyles.bodyLargeMediumTextStyle,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Helper.getCurrencyFormattedAmountText(amount),
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
              AppGaps.hGap10,
              Text(
                Helper.ddMMMyyyyFormattedDateTime(date),
                style: AppTextStyles.bodyMediumTextStyle,
              )
            ],
          ),
        )
      ]),
    );
  }
}
