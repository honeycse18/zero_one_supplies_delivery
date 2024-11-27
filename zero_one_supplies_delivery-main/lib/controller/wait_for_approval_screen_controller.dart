import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:get/get.dart';

class WaitForApprovalScreenController extends GetxController {
  void onEditYourDetailsButtonTap() {
    Get.toNamed(AppPageNames.setupDeliveryManInfoScreen);
  }
}
