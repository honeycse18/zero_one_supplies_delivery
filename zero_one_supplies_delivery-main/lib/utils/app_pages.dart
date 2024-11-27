import 'package:ecomikdeliveryapp/screens/add_bank_screen.dart';
import 'package:ecomikdeliveryapp/screens/add_card_screen.dart';
import 'package:ecomikdeliveryapp/screens/add_method_screen.dart';
import 'package:ecomikdeliveryapp/screens/call_screen.dart';
import 'package:ecomikdeliveryapp/screens/card_add_congrats.dart';
import 'package:ecomikdeliveryapp/screens/chat_deliveryman_screen.dart';
import 'package:ecomikdeliveryapp/screens/chat_recipients_screen.dart';
import 'package:ecomikdeliveryapp/screens/chat_screen.dart';
import 'package:ecomikdeliveryapp/screens/congratulation_screen.dart';
import 'package:ecomikdeliveryapp/screens/contact_us.dart';
import 'package:ecomikdeliveryapp/screens/country_screen.dart';
import 'package:ecomikdeliveryapp/screens/currency_screen.dart';
import 'package:ecomikdeliveryapp/screens/delivered_success_screen.dart';
import 'package:ecomikdeliveryapp/screens/delivery_man_reg_screen.dart';
import 'package:ecomikdeliveryapp/screens/home_screen.dart';
import 'package:ecomikdeliveryapp/screens/image_zoom.dart';
import 'package:ecomikdeliveryapp/screens/insight_screen.dart';
import 'package:ecomikdeliveryapp/screens/intro_screen.dart';
import 'package:ecomikdeliveryapp/screens/langauge_screen.dart';
import 'package:ecomikdeliveryapp/screens/my_wallet_screen.dart';
import 'package:ecomikdeliveryapp/screens/notifications_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_change_success_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_recovery_screens/password_recovery_create_password_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_recovery_screens/password_recovery_email_prompt_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_recovery_screens/password_recovery_prompt_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_recovery_screens/password_recovery_select_screen.dart';
import 'package:ecomikdeliveryapp/screens/password_recovery_screens/password_recovery_verification_screen.dart';
import 'package:ecomikdeliveryapp/screens/payment_history_screen.dart';
import 'package:ecomikdeliveryapp/screens/privacy_policy.dart';
import 'package:ecomikdeliveryapp/screens/send_to_bank_screen.dart';
import 'package:ecomikdeliveryapp/screens/settings_screen.dart';
import 'package:ecomikdeliveryapp/screens/sign_in_screen.dart';
import 'package:ecomikdeliveryapp/screens/sign_up_screen.dart';
import 'package:ecomikdeliveryapp/screens/sign_up_success_screen.dart';
import 'package:ecomikdeliveryapp/screens/support_chat.dart';
import 'package:ecomikdeliveryapp/screens/support_screen.dart';
import 'package:ecomikdeliveryapp/screens/support_screen_ticket.dart';
import 'package:ecomikdeliveryapp/screens/terms_condition.dart';
import 'package:ecomikdeliveryapp/screens/unknown_screen.dart';
import 'package:ecomikdeliveryapp/screens/wait_for_approval.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
// import 'package:ecomikdeliveryapp/widgets/screen_widgets/support_screen.dart';
import 'package:get/get.dart';

import '../screens/splash_screen.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.signInScreen, page: () => const SignInScreen()),
    GetPage(name: AppPageNames.signUpScreen, page: () => const SignUpScreen()),
    GetPage(
        name: AppPageNames.signUpSuccessScreen,
        page: () => const SignUpSuccessScreen()),
    GetPage(
        name: AppPageNames.passwordChangeSuccessScreen,
        page: () => const PasswordChangSuccessScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryPromptScreen,
        page: () => const PasswordRecoveryPromptScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryEmailPromptScreen,
        page: () => const PasswordRecoveryEmailPromptScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryVerificationScreen,
        page: () => const PasswordRecoveryVerificationScreen()),
    GetPage(
        name: AppPageNames.passwordRecoverySelectScreen,
        page: () => const PasswordRecoverySelectScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryCreateScreen,
        page: () => const PasswordRecoveryCreatePasswordScreen()),
    GetPage(
        name: AppPageNames.notificationsScreen,
        page: () => const NotificationsScreen()),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
        name: AppPageNames.languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: AppPageNames.countryScreen, page: () => const CountryScreen()),
    GetPage(
        name: AppPageNames.currencyScreen, page: () => const CurrencyScreen()),
    GetPage(
        name: AppPageNames.myWalletScreen, page: () => const MyWalletScreen()),
    GetPage(
        name: AppPageNames.chatWithDeliverymanScreen,
        page: () => const ChatDeliverymanScreen()),
    GetPage(
        name: AppPageNames.addCardScreen, page: () => const AddCardScreen()),
    GetPage(
        name: AppPageNames.addWithdrawMethodScreen,
        page: () => const AddWithdrawMethodScreen()),
    GetPage(
        name: AppPageNames.cardPlacedSuccessScreen,
        page: () => const CardPlacedSuccessScreen()),
    GetPage(
        name: AppPageNames.congratulationScreen,
        page: () => const CongratulationScreen()),
    GetPage(
        name: AppPageNames.supportScreen, page: () => const SupportScreen()),
    GetPage(
        name: AppPageNames.contactUsScreen,
        page: () => const ContactUsScreen()),
    GetPage(
        name: AppPageNames.supportTicketScreen,
        page: () => const SupportTicketScreen()),
    GetPage(
        name: AppPageNames.insightScreen, page: () => const InsightScreen()),
    GetPage(
        name: AppPageNames.termsConditionScreen,
        page: () => const TermsConditionScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: AppPageNames.chatSupportScreen,
        page: () => const ChatSupportScreen()),
    GetPage(
        name: AppPageNames.addBankScreen, page: () => const AddBankScreen()),
    GetPage(
        name: AppPageNames.sendToBankScreen,
        page: () => const SendToBankScreen()),
    GetPage(
        name: AppPageNames.paymentHistory, page: () => const PaymentHistory()),
    GetPage(
        name: AppPageNames.deliveredSuccessScreen,
        page: () => const DeliveredSuccessScreen()),
    GetPage(name: AppPageNames.callScreen, page: () => const CallScreen()),
    GetPage(name: AppPageNames.homeScreen, page: () => const HomeScreen()),
    GetPage(
        name: AppPageNames.setupDeliveryManInfoScreen,
        page: () => const SetupDeliveryManInfoScreen()),
    GetPage(
        name: AppPageNames.waitForApprovalScreen,
        page: () => const WaitForApprovalScreen()),
    GetPage(name: AppPageNames.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: AppPageNames.chatRecipientScreen,
        page: () => const ChatRecipientsScreen()),
    GetPage(
        name: AppPageNames.imageScreen, page: () => const ImageZoomScreen()),
  ];

  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
      name: AppPageNames.unknownScreen, page: () => const UnknownScreen());
}
