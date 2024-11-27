import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_text_styles.dart';
import 'package:ecomikdeliveryapp/utils/helpers/helpers.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

/// Custom padded body widget for scaffold
class CustomScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
      child: child,
    );
  }
}

class EmptyScreenWidget extends StatelessWidget {
  final String image;
  final String title;
  final String shortTitle;
  const EmptyScreenWidget({
    super.key,
    required this.image,
    required this.title,
    required this.shortTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 130,
          //  width: 254,
          child: Image.asset(image),
        ),
        AppGaps.hGap10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap10,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle
                      .copyWith(color: AppColors.bodyTextColor)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom padded bottom bar widget for scaffold
class CustomScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const CustomScaffoldBottomBarWidget(
      {super.key,
      required this.child,
      this.backgroundColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppGaps.bottomNavBarPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

//=====Added by tonmay============

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretcheOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretcheOutlinedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black12),
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius)),
              ),
              child: child),
        ),
      ],
    );
  }
}

// /// Custom TextButton stretches the width of the screen with small elevation
// /// shadow
// class CustomStretchedTextButtonWidget extends StatelessWidget {
//   final String buttonText;
//   final void Function()? onTap;
//   const CustomStretchedTextButtonWidget({
//     Key? key,
//     this.onTap,
//     required this.buttonText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 // color: AppColors.primaryColor.withOpacity(0.5),
//                 gradient: onTap == null
//                     ? LinearGradient(colors: [
//                         AppColors.primaryColor.withOpacity(0.5),
//                         AppColors.primaryColor.withOpacity(0.5)
//                       ])
//                     : LinearGradient(colors: [
//                         AppColors.primaryColor,
//                         AppColors.primaryColor.withOpacity(0.4),
//                       ])),
//             child: TextButton(
//                 onPressed: onTap,
//                 style: TextButton.styleFrom(
//                     elevation: onTap == null ? 0 : 10,
//                     // shadowColor: AppColors.primaryColor.withOpacity(0.25),
//                     primary: Colors.white,
//                     backgroundColor: onTap == null
//                         ? AppColors.primaryColor.withOpacity(0.15)
//                         : AppColors.primaryColor,
//                     minimumSize: const Size(30, 62),
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                             AppComponents.defaultBorderRadius))),
//                 child: Text(buttonText,
//                     style: onTap == null
//                         ? const TextStyle(color: Colors.white)
//                         : null)),
//           ),
//         ),
//       ],
//     );
//   }
// }

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow
class CustomStretchedTextButtonWidget extends StatelessWidget {
  final bool isLoading;
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedTextButtonWidget({
    super.key,
    this.isLoading = false,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
          child:
              StretchedTextButtonWidget(onTap: onTap, buttonText: buttonText));
    }
    return StretchedTextButtonWidget(onTap: onTap, buttonText: buttonText);
  }
}

class StretchedTextButtonWidget extends StatelessWidget {
  const StretchedTextButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  final void Function()? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: onTap == null
                    ? LinearGradient(colors: [
                        Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                            AppColors.primaryColor.withOpacity(0.5),
                        Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                            AppColors.primaryColor.withOpacity(0.5)
                      ])
                    : LinearGradient(colors: [
                        AppColors.primaryColor,
                        Color.lerp(AppColors.primaryColor, Colors.white, 0.4) ??
                            AppColors.primaryColor.withOpacity(0.4),
                      ])),
            child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    elevation: onTap == null ? 0 : 10,
                    shadowColor: AppColors.primaryColor.withOpacity(0.25),
                    // backgroundColor: onTap == null
                    //     ? AppColors.primaryColor.withOpacity(0.15)
                    //     : AppColors.primaryColor.withOpacity(0.0),
                    minimumSize: const Size(30, 62),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            AppComponents.defaultBorderRadius))),
                child: Text(buttonText,
                    textAlign: TextAlign.center,
                    style: onTap == null
                        ? const TextStyle(color: Colors.white)
                        : null)),
          ),
        ),
      ],
    );
  }
}

/// Custom TextButton with small elevation shadow
class CustomTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: onTap == null
              ? LinearGradient(colors: [
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5),
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5)
                ])
              : LinearGradient(colors: [
                  AppColors.primaryColor,
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.4) ??
                      AppColors.primaryColor.withOpacity(0.4),
                ])),
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              elevation: onTap == null ? 0 : 10,
              shadowColor: AppColors.primaryColor.withOpacity(0.25),
              // backgroundColor: onTap == null
              //     ? AppColors.primaryColor.withOpacity(0.15)
              //     : AppColors.primaryColor.withOpacity(0.0),
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(AppComponents.defaultBorderRadius))),
          child: Text(buttonText,
              textAlign: TextAlign.center,
              style:
                  onTap == null ? const TextStyle(color: Colors.white) : null)),
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shadowColor: AppColors.primaryColor.withOpacity(0.25),
                  backgroundColor: onTap == null
                      ? AppColors.bodyTextColor
                      : AppColors.primaryColor,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: child),
        ),
      ],
    );
  }
}

/// Custom toggle button of tab widget
class TabToggleButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  const TabToggleButtonWidget(
      {super.key, required this.isSelected, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Material(
        animationDuration: Duration.zero,
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        elevation: isSelected ? 10 : 0,
        shadowColor:
            isSelected ? AppColors.primaryColor.withOpacity(0.25) : null,
        shape: StadiumBorder(side: BorderSide(color: AppColors.primaryColor)),
        // borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLargeSemiboldTextStyle
                  .copyWith(color: isSelected ? Colors.white : null),
            ),
          ),
        ),
      ),
    );
  }
}

/// Minus, counter, plus buttons row for product cart counter.
class PlusMinusCounterRow extends StatelessWidget {
  final void Function()? onRemoveTap;
  final String counterText;
  final void Function()? onAddTap;
  const PlusMinusCounterRow({
    super.key,
    required this.onRemoveTap,
    required this.counterText,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButtonWidget(
              backgroundColor: AppColors.shadeColor1,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onRemoveTap,
              child: SvgPicture.asset(
                AppAssetImages.minusSVGLogoSolid,
                color: AppColors.bodyTextColor,
                height: 12,
                width: 12,
              )),
          AppGaps.wGap10,
          Expanded(
            child: Center(
              child: Text(
                counterText,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, color: AppColors.darkColor),
              ),
            ),
          ),
          AppGaps.wGap10,
          CustomIconButtonWidget(
              backgroundColor: AppColors.primaryColor,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onAddTap,
              child: SvgPicture.asset(
                AppAssetImages.plusSVGLogoSolid,
                color: Colors.white,
                height: 12,
                width: 12,
              )),
        ],
      ),
    );
  }
}

/// Custom TextFormField configured with Theme.
class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  });

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 62,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/// Radio widget without additional padding
class CustomRadioWidget extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final Function(Object?) onChanged;
  const CustomRadioWidget(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Radio<Object>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/// Custom IconButton widget various attributes
class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const CustomIconButtonWidget(
      {super.key,
      this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(14),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
          border: border),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// Custom large text button widget
class CustomLargeTextButtonWidget extends StatelessWidget {
  final bool isSmallScreen;
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const CustomLargeTextButtonWidget({
    super.key,
    this.onTap,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: textColor,
            fixedSize:
                isSmallScreen ? const Size(140, 55) : const Size(175, 65),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius))),
        child: Text(text));
  }
}

/// Raw list tile does not have a background color
class CustomRawListTileWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Radius? borderRadiusRadiusValue;
  const CustomRawListTileWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadiusRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadiusRadiusValue != null
          ? BorderRadius.all(borderRadiusRadiusValue!)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusRadiusValue != null
            ? BorderRadius.all(borderRadiusRadiusValue!)
            : null,
        child: child,
      ),
    );
  }
}

/// Custom list tile widget of white background color
class CustomListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomListTileWidget(
      {super.key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Horizontal dashed line.
class CustomHorizontalDashedLineWidget extends StatelessWidget {
  const CustomHorizontalDashedLineWidget({
    super.key,
    this.height = 1,
    this.color = Colors.black,
  });
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Vertical dashed line
class CustomVerticalDashedLineWidget extends StatelessWidget {
  const CustomVerticalDashedLineWidget({
    super.key,
    this.width = 1,
    this.color = Colors.black,
  });
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainWidth();
        const dashHeight = 4.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Credit card widget with 3 shadows towards bottom
class PaymentCardWidget extends StatelessWidget {
  final Widget child;
  const PaymentCardWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: Container(alignment: Alignment.topCenter)),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 32, right: 32, top: 24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.paymentCardAbstractShape,
                            cacheHeight: 163,
                            cacheWidth: 163,
                            height: 163,
                            width: 163)
                        .image,
                    alignment: Alignment.topRight)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// Slogan and subtitle text
class HighlightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  const HighlightAndDetailTextWidget({
    super.key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(slogan,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Text(subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.bodyTextColor, overflow: TextOverflow.clip)),
      ],
    );
  }
}

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final List<T>? items;
  final String Function(T)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T)? getItemChild;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;
  const DropdownButtonFormFieldWidget(
      {super.key,
      this.value,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 48, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.getItemChild,
      this.isDense = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.labelTextStyle,
          ),
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return DropdownButtonFormField<T>(
            isExpanded: true,
            isDense: isDense,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: value,
            borderRadius: AppComponents.defaultBorder,
            hint: Text(hintText),
            disabledHint: Text(hintText,
                style: AppTextStyles.labelTextStyle
                    .copyWith(color: AppColors.bodyTextColor.withOpacity(0.5))),
            icon: LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                color: isDisabled()
                    ? AppColors.bodyTextColor.withOpacity(0.5)
                    : AppColors.bodyTextColor),
            // iconEnabledColor: AppColors.bodyTextColor,
            // iconDisabledColor: AppColors.lineShapeColor,
            decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
            items: items
                ?.map((e) =>
                    DropdownMenuItem(value: e, child: _getItemChildWidget(e)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(getItemText!(element));
    }
    return AppGaps.emptyGap;
  }

  bool isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class DropdownButtonFormFieldLoadingWidget extends StatelessWidget {
  const DropdownButtonFormFieldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppComponents.defaultBorder,
            border: Border.all(width: 2)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 120, child: LoadingTextWidget()),
              Spacer(),
              LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                  color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingTextWidget extends StatelessWidget {
  final bool isSmall;
  const LoadingTextWidget({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 20,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

/// Wishlist screen grid item button widget
class WishlistItemButtonWidget extends StatelessWidget {
  final bool isWishlisted;
  final void Function()? onTap;
  const WishlistItemButtonWidget({
    super.key,
    required this.isWishlisted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      icon: SvgPicture.asset(
        AppAssetImages.heartSVGLogoSolid,
        color: isWishlisted
            ? AppColors.primaryColor
            : AppColors.darkColor.withOpacity(0.15),
      ),
    );
  }
}

/// Custom TextButton widget which is very tight to child text
class CustomTightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const CustomTightTextButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

/// Custom grid item widget
class CustomGridSingleItemWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final void Function()? onTap;
  const CustomGridSingleItemWidget({
    super.key,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(7.5),
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

/// This class contains functions that return a widget
class CoreWidgets1 {
  /// Custom app bar widget
  static AppBar appBarWidget(
      {required BuildContext screenContext,
      Widget? titleWidget,
      Widget? leading,
      List<Widget>? actions,
      bool hasBackButton = true}) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Center(
              child: CustomIconButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  hasShadow: true,
                  child: SvgPicture.asset(
                    AppAssetImages.arrowLeftSVGLogoLine,
                    color: AppColors.darkColor,
                    height: 18,
                    width: 18,
                  )),
            )
          : leading,
      title: titleWidget,
      actions: actions,
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const AlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomDialogButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomDialogButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor,
            minimumSize: const Size(128, 33),
            shape: const StadiumBorder()),
        child: child);
  }
}

class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final void Function()? onTap;
  const CustomStretchedOutlinedTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                // primary: AppColors.secondaryColor,
                backgroundColor: backgroundColor,
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black12),
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius)),
              ),
              child: Text(buttonText, textAlign: TextAlign.center)),
        ),
      ],
    );
  }
}

class NotificationDotWidget extends StatelessWidget {
  final bool isRead;
  const NotificationDotWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isRead
              ? AppColors.darkColor.withOpacity(0.2)
              : AppColors.primaryColor,
          shape: BoxShape.circle),
    );
  }
}

/// This class contains functions that return a widget
class CoreWidgets {
  /// Custom app bar widget
  static AppBar appBarWidget(
      {required BuildContext screenContext,
      Widget? titleWidget,
      List<Widget>? actions,
      bool hasBackButton = true}) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Center(
              child: CustomIconButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  hasShadow: true,
                  child: SvgPicture.asset(
                    AppAssetImages.arrowLeftSVGLogoLine,
                    color: AppColors.darkColor,
                    height: 18,
                    width: 18,
                  )),
            )
          : null,
      title: titleWidget,
      actions: actions,
    );
  }

  static PagedChildBuilderDelegate<ItemType>
      pagedChildBuilderDelegate<ItemType>({
    required Widget Function(BuildContext, ItemType, int) itemBuilder,
    Widget Function(BuildContext)? errorIndicatorBuilder,
    Widget Function(BuildContext)? noItemFoundIndicatorBuilder,
    Widget Function(BuildContext)? firstPageLoadingIndicatorBuilder,
    Widget Function(BuildContext)? newPageLoadingIndicatorBuilder,
  }) {
    final firstPageProgressIndicatorBuilder =
        firstPageLoadingIndicatorBuilder ??
            (context) => const Center(child: CircularProgressIndicator());
    final newPageProgressIndicatorBuilder = newPageLoadingIndicatorBuilder ??
        (context) => const Center(child: CircularProgressIndicator());
    final pageErrorIndicatorBuilder =
        errorIndicatorBuilder ?? (context) => const ErrorPaginationWidget();
    final noItemsFoundIndicatorBuilder = noItemFoundIndicatorBuilder ??
        (context) => const ErrorPaginationWidget();
    return PagedChildBuilderDelegate<ItemType>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
        newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 200));
  }
}

class ErrorPaginationWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorPaginationWidget({
    super.key,
    this.errorMessage = 'Error occurred while loading',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorLoadedIconWidget(isLargeIcon: true),
            AppGaps.hGap5,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMediumTextStyle,
            ),
          ],
        ));
  }
}

class ErrorLoadedIconWidget extends StatelessWidget {
  final bool isLargeIcon;
  const ErrorLoadedIconWidget({
    super.key,
    this.isLargeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error_outline,
            size: isLargeIcon ? 40 : null, color: AppColors.alertColor));
  }
}

/// Raw button widget
class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  const RawButtonWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadiusValue != null
          ? BorderRadius.all(Radius.circular(borderRadiusValue!))
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusValue != null
            ? BorderRadius.all(Radius.circular(borderRadiusValue!))
            : null,
        child: child,
      ),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  const SelectImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: Constants.uploadImageButtonBorderRadiusValue,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  Constants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(AppAssetImages.uploadSVGLogoLine,
                  color: AppColors.primaryColor, height: 40),
              AppGaps.hGap2,
              Text(
                  LanguageHelper.currentLanguageText(
                      LanguageHelper.uploadImageHereTransKey),
                  style: AppTextStyles.bodySemiboldTextStyle,
                  textAlign: TextAlign.center),
            ]),
          ),
        ));
  }
}

class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: Constants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: TightIconButtonWidget(
                  icon: SvgPicture.asset(
                      AppAssetImages.editPurpleBorderedSVGLogoSolid,
                      height: 24),
                  onTap: onEditButtonTap),
            )
          ],
        ),
      ),
    );
  }
}

class SelectedLocalImageWidget extends StatelessWidget {
  final Uint8List imageBytes;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;

  const SelectedLocalImageWidget({
    super.key,
    required this.imageBytes,
    this.onTap,
    this.onEditButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: Constants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: AppComponents.defaultBorder,
                    image: DecorationImage(
                        image: Image.memory(imageBytes).image,
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: TightIconButtonWidget(
                  icon: SvgPicture.asset(
                      AppAssetImages.editPurpleBorderedSVGLogoSolid,
                      height: 24),
                  onTap: onEditButtonTap),
            )
          ],
        ),
      ),
    );
  }
}

class LocalAssetSVGIcon extends StatelessWidget {
  final String iconLocalAssetLocation;
  final Color color;
  final double height;
  final double? width;
  const LocalAssetSVGIcon(this.iconLocalAssetLocation,
      {super.key, required, required this.color, this.height = 24, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconLocalAssetLocation,
        height: height,
        width: width ?? height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}

/// This icon button does not have any padding, margin around it
class TightIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const TightIconButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CachedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
            fit: BoxFit.contain)
        : CachedNetworkImage(
            imageUrl: imageURL,
            placeholder: (context, url) =>
                const LoadingImagePlaceholderWidget(),
            errorWidget: (context, url, error) => const ErrorLoadedIconWidget(),
            imageBuilder: imageBuilder,
            memCacheHeight: cacheHeight,
            memCacheWidth: cacheWidth,
            fit: boxFit,
            cacheManager: CacheManager(Config(
                'zero_one_supplies_delivery_cache',
                stalePeriod: const Duration(days: 2))));
  }
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingImagePlaceholderWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(AppAssetImages.imagePlaceholderIconImage)),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  const LoadingPlaceholderWidget({
    super.key,
    required this.child,
    this.baseColor = AppColors.shimmerBaseColor,
    this.highlightColor = AppColors.shimmerHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}

class NoImageAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const NoImageAvatarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Text(
        Helper.avatar2LetterUsername(firstName, lastName),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

/// Custom padded body widget for scaffold
class BottomModalBodyWidget extends StatelessWidget {
  final Widget child;
  const BottomModalBodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Constants.screenPaddingValue,
          Constants.bottomSheetTopPaddingValue,
          Constants.screenPaddingValue,
          0),
      child: child,
    );
  }
}
