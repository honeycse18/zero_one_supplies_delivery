import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This file contains various components for the app
class AppComponents {
  static const defaultBorderRadius = Radius.circular(18);
  static const defaultBorder =
      BorderRadius.all(Radius.circular(Constants.defaultBorderRadiusValue));
  static NumberFormat defaultNumberFormat =
      NumberFormat.currency(locale: 'fn_FN');
  static const BorderRadius bottomSheetBorderRadius = BorderRadius.vertical(
      top: Radius.circular(Constants.bottomSheetBorderRadiusValue));
  static const BorderRadius dialogBorderRadius =
      BorderRadius.all(Radius.circular(Constants.dialogBorderRadiusValue));
  static final DateTime defaultUnsetDateTime =
      DateTime(Constants.defaultUnsetDateTimeYear);
  static final apiDateTimeFormat = DateFormat(Constants.apiDateTimeFormatValue);

  static const BorderRadius smallBorderRadius =
      BorderRadius.all(Radius.circular(Constants.smallBorderRadiusValue));
  static const EdgeInsets dialogTitlePadding = EdgeInsets.fromLTRB(
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogVerticalSpaceValue,
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogVerticalSpaceValue);
  static const EdgeInsets dialogContentPadding = EdgeInsets.fromLTRB(
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogHalfVerticalSpaceValue,
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogVerticalSpaceValue);
  static const EdgeInsets dialogActionPadding = EdgeInsets.fromLTRB(
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogVerticalSpaceValue,
      Constants.dialogHorizontalSpaceValue,
      Constants.dialogVerticalSpaceValue);
}
