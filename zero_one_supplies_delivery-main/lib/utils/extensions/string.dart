import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';

extension LanguageTranslation on String {
  String get toCurrentLanguage => LanguageHelper.currentLanguageText(this);
}
