import 'package:ecomikdeliveryapp/models/enums.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:flutter/material.dart';

/// Password strong level widget with text
class PasswordStrongLevelWidget extends StatelessWidget {
  final PasswordStrongLevel currentPasswordStrongLevel;
  const PasswordStrongLevelWidget(
      {super.key, required this.currentPasswordStrongLevel});

  String _getPasswordStrongLevelText() {
    switch (currentPasswordStrongLevel) {
      case PasswordStrongLevel.none:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.emptyPassTransKey);
      case PasswordStrongLevel.error:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.errorOccurredTransKey);
      case PasswordStrongLevel.weak:
        return LanguageHelper.currentLanguageText(LanguageHelper.weakTransKey);
      case PasswordStrongLevel.normal:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.normalTransKey);
      case PasswordStrongLevel.strong:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.strongTransKey);
      case PasswordStrongLevel.veryStrong:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.veryStrongTransKey);
      default:
        return LanguageHelper.currentLanguageText(
            LanguageHelper.emptyPassTransKey);
    }
  }

  Color _setWeakPasswordStrongLevelBar(
      PasswordStrongLevel currentPasswordStrongLevel) {
    if (currentPasswordStrongLevel == PasswordStrongLevel.weak ||
        currentPasswordStrongLevel == PasswordStrongLevel.normal ||
        currentPasswordStrongLevel == PasswordStrongLevel.strong ||
        currentPasswordStrongLevel == PasswordStrongLevel.veryStrong) {
      if (currentPasswordStrongLevel == PasswordStrongLevel.weak) {
        return AppColors.secondaryColor;
      }
      return AppColors.successColor;
    } else {
      if (currentPasswordStrongLevel == PasswordStrongLevel.error) {
        return AppColors.alertColor;
      }
      return AppColors.darkColor.withOpacity(0.1);
    }
  }

  Color _setNormalPasswordStrongLevelBar(
      PasswordStrongLevel currentPasswordStrongLevel) {
    if (currentPasswordStrongLevel == PasswordStrongLevel.normal ||
        currentPasswordStrongLevel == PasswordStrongLevel.strong ||
        currentPasswordStrongLevel == PasswordStrongLevel.veryStrong) {
      return AppColors.successColor;
    } else {
      if (currentPasswordStrongLevel == PasswordStrongLevel.error) {
        return AppColors.alertColor;
      }
      return AppColors.darkColor.withOpacity(0.1);
    }
  }

  Color _setStrongPasswordStrongLevelBar(
      PasswordStrongLevel currentPasswordStrongLevel) {
    if (currentPasswordStrongLevel == PasswordStrongLevel.strong ||
        currentPasswordStrongLevel == PasswordStrongLevel.veryStrong) {
      return AppColors.successColor;
    } else {
      if (currentPasswordStrongLevel == PasswordStrongLevel.error) {
        return AppColors.alertColor;
      }
      return AppColors.darkColor.withOpacity(0.1);
    }
  }

  Color _setVeryStrongPasswordStrongLevelBar(
      PasswordStrongLevel currentPasswordStrongLevel) {
    if (currentPasswordStrongLevel == PasswordStrongLevel.veryStrong) {
      return AppColors.successColor;
    } else {
      if (currentPasswordStrongLevel == PasswordStrongLevel.error) {
        return AppColors.alertColor;
      }
      return AppColors.darkColor.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 10,
      children: [
        PasswordStrongLevelSingleBarWidget(
            statusColor:
                _setWeakPasswordStrongLevelBar(currentPasswordStrongLevel)),
        AppGaps.wGap5,
        PasswordStrongLevelSingleBarWidget(
            statusColor:
                _setNormalPasswordStrongLevelBar(currentPasswordStrongLevel)),
        AppGaps.wGap5,
        PasswordStrongLevelSingleBarWidget(
            statusColor:
                _setStrongPasswordStrongLevelBar(currentPasswordStrongLevel)),
        AppGaps.wGap5,
        PasswordStrongLevelSingleBarWidget(
            statusColor: _setVeryStrongPasswordStrongLevelBar(
                currentPasswordStrongLevel)),
        AppGaps.wGap10,
        Text(
          _getPasswordStrongLevelText(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

/// Password strong level single colored bar widget
class PasswordStrongLevelSingleBarWidget extends StatelessWidget {
  final Color statusColor;
  const PasswordStrongLevelSingleBarWidget({
    super.key,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 45,
      decoration: BoxDecoration(
          color: statusColor,
          borderRadius:
              const BorderRadius.all(AppComponents.defaultBorderRadius)),
    );
  }
}
