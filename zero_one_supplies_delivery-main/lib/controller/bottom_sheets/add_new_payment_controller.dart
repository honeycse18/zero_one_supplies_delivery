import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/dialogs.dart';
import 'package:get/get.dart';

class AddNewPaymentBottomSheetController extends GetxController {
  SiteSettingsWithdrawMethodResponse selectedAddNewAccountMethod =
      SiteSettingsWithdrawMethodResponse();

  List<SiteSettingsWithdrawMethodResponse> siteSetting =
      AppSingleton.instance.settings.withdrawMethods;

  void onAddAccountMethodTap(SiteSettingsWithdrawMethodResponse value) {
    selectedAddNewAccountMethod = value;
    update();
  }

  void onAddAccountRadioChange(SiteSettingsWithdrawMethodResponse value) {
    onAddAccountMethodTap(value);
  }

  void onAddCardButtonTap() {
    if (selectedAddNewAccountMethod.id.isEmpty) {
      AppDialogs.showErrorDialog(
          messageText: LanguageHelper.currentLanguageText(
              LanguageHelper.youMustSelectAMethodTransKey));
      return;
    }
    Get.back(result: selectedAddNewAccountMethod);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
