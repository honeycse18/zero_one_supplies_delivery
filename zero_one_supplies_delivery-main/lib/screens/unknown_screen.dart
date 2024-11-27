import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Center(
            child: Text(LanguageHelper.currentLanguageText(
                LanguageHelper.pageNotFoundTransKey)),
          ),
        ),
      ),
    );
  }
}
