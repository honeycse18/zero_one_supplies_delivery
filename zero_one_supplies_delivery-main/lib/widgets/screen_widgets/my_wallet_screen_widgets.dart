import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Single recent transaction list tile widget
class RecentTransactionWidget extends StatelessWidget {
  final String title;
  final String imageURL;
  final double amount;
  final DateTime dateTime;
  final String status;
  const RecentTransactionWidget({
    super.key,
    // required this.recentTransaction,
    required this.amount,
    required this.dateTime,
    required this.title,
    required this.status,
    required this.imageURL,
  });

  // final FakeRecentTransaction recentTransaction;

  String _getTransactionTypeText() {
/*     switch (recentTransaction.transactionType) {
      case 'send-to-bank':
        return 'Send to bank';
      default:
        return 'Earnings';
    } */
    return 'Earnings';
  }

  String _getAmountText() {
/*     switch (recentTransaction.transactionType) {
      case 'send-to-bank':
        return '-\$${recentTransaction.amountText}';
      default:
        return '\$${recentTransaction.amountText}';
    } */
    return Helper.getCurrencyFormattedAmountText(amount);
  }

  SvgPicture _getTransactionIcon() {
/*     switch (recentTransaction.transactionType) {
      case 'earning-up':
        return SvgPicture.asset(AppAssetImages.arrowUpSVGLogoSolid,
            color: AppColors.secondaryColor);
      case 'earning-down':
        return SvgPicture.asset(AppAssetImages.arrowDownSVGLogoSolid,
            color: AppColors.tertiaryColor);
      case 'send-to-bank':
        return SvgPicture.asset(AppAssetImages.bankSVGLogoSolid,
            color: AppColors.primaryColor);
      default:
        return SvgPicture.asset(AppAssetImages.arrowUpSVGLogoSolid,
            color: AppColors.secondaryColor);
    } */
    return SvgPicture.asset(AppAssetImages.arrowUpSVGLogoSolid,
        color: AppColors.secondaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomRawListTileWidget(
          child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* <---- Transaction image ----> */
          CustomIconButtonWidget(
              borderRadiusRadiusValue: const Radius.circular(12),
              // child: _getTransactionIcon()),
              child: CachedNetworkImageWidget(imageURL: imageURL)),
          AppGaps.wGap8,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* <---- Transaction title ----> */
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              AppGaps.hGap8,
              /* <---- Transaction item count, date and time ----> */
              Text(
                // '${recentTransaction.itemCount} items |'
                ' $dateText |'
                ' $timeText',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.bodyTextColor),
              ),
            ],
          )),
          AppGaps.wGap16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /* <---- Transaction amount ----> */
              Text(
                _getAmountText(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              AppGaps.hGap8,
              /* <---- Transaction type ----> */
              Text(
                // _getTransactionTypeText(),
                status,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.bodyTextColor),
              )
            ],
          )
        ],
      )),
    );
  }

  String get dateText {
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }

  String get timeText {
    return DateFormat('hh:mm A').format(dateTime);
  }
}
