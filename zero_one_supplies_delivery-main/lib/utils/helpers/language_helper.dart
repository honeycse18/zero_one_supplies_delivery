import 'package:ecomikdeliveryapp/utils/app_singleton.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';

class LanguageHelper {
  static const String welcome01SuppliesTransKey = 'welcome to 01 supplies';
  static const String helloThereTransKey = 'hello there, sign in to continue';
  static const String addAccountTransKey = 'add account';
  static const String yourOrdersTransKey = 'product';
  static const String settingTransKey = 'settings';
  static const String signOutTransKey = 'sign out';
  static const String signUpTransKey = 'sign up';
  static const String dontHaveAnAccountTransKey = 'dont\'t have an account?';
  static const String emailAddressTransKey = 'email address';
  static const String signInTransKey = 'sign in';
  static const String logInTransKey = 'login';
  static const String passwordTransKey = 'password';
  static const String registrarTransKey = 'register';
  static const String forgetPassTransKey = 'forgot password?';
  static const String startDeliveryJobTransKey =
      'start your delivery job with us';
  static const String rememberMeTransKey = 'remember me';
  static const String sendCodeTransKey = 'send code';
  static const String orSignInWithSocialAccountTransKey =
      'or sign in with social account';
  static const String loremIpsumIsSimpleDummyTextTransKey =
      'discover the easiest way to shop from a wide range of products across various';
  static const String yourDoneTransKey = 'you\'re done!';
  static const String pleaseConfirmTransKey =
      'please confirm your country code and enter phone number';
  static const String yourOfflineTransKey = 'you\'re offline';
  static const String yourOnlineTransKey = 'you\'re online';
  static const String yourOrderDetailsTransKey = 'your order details';
  static const String updateDeliveryManRegistrationTransKey =
      'update delivery man registration';
  static const String myWalletTransKey = 'my wallet';
  static const String paymentHistoryTransKey = 'payment history';
  static const String termsConditionTransKey = 'terms and conditions';
  static const String itemTransKey = 'items';
  static const String declineDeliveryTransKey = 'decline delivery';
  static const String acceptDeliveryTransKey = 'accept delivery';
  static const String markAsPickedTransKey = 'mark as picked';
  static const String deliveryRejectedTransKey = 'delivery rejected';
  static const String markAsOnWayTransKey = 'mark as on the way';
  static const String markAsDeliveredTransKey = 'mark as delivered';
  static const String orderIsDeliveredTransKey = 'order is delivered';
  static const String orderIdTransKey = 'order id';
  static const String requestIdTransKey = 'request id';
  static const String orderInfoTransKey = 'order info';
  static const String subTotalTransKey = 'subtotal';
  static const String vatTransKey = 'vat';
  static const String pickedStationChargeTransKey = 'pickup station charge';
  static const String deliveryChargeTransKey = 'delivery charge';
  static const String totalTransKey = 'total';
  static const String addCardTransKey = 'add card';
  static const String withdrawTransKey = 'withdraw';
  static const String enterAmountTransferTransKey = 'enter amount to transfer';
  static const String exampleTransKey = 'eg';
  static const String bankInfoTransKey = 'bank info';
  static const String addBankTransKey = 'add bank';
  static const String accountHolderNameTransKey = 'account holder name';
  static const String bankNameTransKey = 'bank name';
  static const String branchCodeTransKey = 'branch code';
  static const String accountNumberTransKey = 'account number';
  static const String addBankAccountTransKey = 'add bank account';
  static const String cardInfoTransKey = 'card info';
  static const String nameOnCardTransKey = 'name On card';
  static const String cardNumberTransKey = 'card number';
  static const String expirationTransKey = 'expiration';
  static const String cvcTransKey = 'cvc';
  static const String addTransKey = 'add';
  static const String postalCodeTransKey = 'postal code';
  static const String callingTransKey = 'calling';
  static const String congratulationTransKey = 'congratulations';
  static const String goToHomeTransKey = 'go to home';
  static const String chatWithCustomerTransKey = 'chat with customer';
  static const String contactUsTransKey = 'contact us';
  static const String addressTransKey = 'address';
  static const String phoneTransKey = 'phone';
  static const String getInTouchTransKey = 'get in touch';
  static const String writeMessageTransKey = 'write message';
  static const String yourNameTransKey = 'your name';
  static const String messageTransKey = 'message';
  static const String youDrivedTransKey = 'you drived';
  static const String viewOrderInfoTransKey = 'view order info';
  static const String yourEarningTransKey = 'your earning';
  static const String viewEarningTransKey = 'view earnings';
  static const String backToHomeTransKey = 'back to home';
  static const String deliveredSuccessfullyTransKey = 'delivered successfully!';
  static const String deliveryManInfoTransKey = 'delivery man information';
  static const String taxNameTransKey = 'tax name';
  static const String taxNumberTransKey = 'tax number';
  static const String nidNumberTransKey = 'nid number';
  static const String pickUpStationTransKey = ' pick up station';
  static const String yourTaxNameTransKey = 'your tax name';
  static const String nationalIdTransKey = 'national identity card';
  static const String addressProofTransKey = 'address proof';
  static const String applyNowTransKey = 'apply now';
  static const String languageTransKey = 'language';
  static const String walletTransKey = 'wallet';
  static const String balanceTransKey = 'balance';
  static const String addNewTransKey = 'add new';
  static const String notificationTransKey = 'notification';
  static const String passChangedTransKey = 'great! password changed';
  static const String recentTransactionTransKey = 'recent transactions';
  static const String noTransactionTransKey = 'no transaction found';
  static const String sendToBankTransKey = 'send to bank';
  static const String nameTransKey = 'name';
  static const String savedWithdrawMethodTransKey = 'saved withdraw methods';
  static const String preferenceTransKey = 'preference';
  static const String gettingStartedTransKey = 'getting started';
  static const String firstNameTransKey = 'first name';
  static const String yourFirstNameTransKey = 'your first name';
  static const String lastNameTransKey = 'last name';
  static const String bySigningUpIAgreeToTheTransKey =
      'by signing up, I agree to the';
  static const String termsOfServiceTransKey = 'terms of service';
  static const String andTransKey = 'and';
  static const String privacyPolicyTransKey = 'privacy policy';
  static const String alreadyHaveAnAccountTransKey = 'already have an account';
  static const String confirmPasswordTransKey = 'confirm password';
  static const String pageNotFoundTransKey = 'page not found';
  static const String yourLastNameTransKey = 'your last name';
  static const String selectLanguageTransKey = 'select language';
  static const String keepMeLoginTransKey = 'keep me logged in';
  static const String dontWorryTransKey =
      'don\'t worry! We\'ll let you know if there is any problem with your account';
  static const String youMustSelectAMethodTransKey =
      'you must select a method first!';
  static const String userDoesNotExistTransKey = 'user does not exist';
  static const String yourAccountNotVerifiedTransKey =
      'your account is not verified yet!';
  static const String verifyNowTransKey = 'verify now';
  static const String canNotBeEmptyTransKey = 'can not be empty';
  static const String minimumLength3TransKey = 'minimum length 3';
  static const String mustMatchConfirmPassTransKey =
      'must match with confirm password';
  static const String mustMatchPassTransKey = 'must match with password';
  static const String invalidEmailFormatTransKey = 'invalid email format';
  static const String invalidPhoneFormatTransKey =
      'invalid phone number format';
  static const String youMustProvideInfoTransKey =
      'you must provide information first to proceed.';
  static const String addingYourInfoTransKey = 'adding your information.';
  static const String noResponseFoundTransKey =
      'no response found for this operation!';
  static const String successfullyUpdatedTransKey =
      'successfully uploaded store logo image';
  static const String errorOccurredProcessingImageTransKey =
      'error occurred while processing image';
  static const String areYouSureSetThisImageTransKey =
      'are you sure to set this image as store logo?';
  static const String successUploadingNIDTransKey =
      'successfully uploaded national card image';
  static const String areYouSureSetNIDTransKey =
      'are you sure to set this image as national id card?';
  static const String successUploadingAddressProofImageTransKey =
      'successfully uploaded address proof image';
  static const String somethingWrongTransKey = 'something wrong happened!';
  static const String mustEnterAmountTransKey = 'must enter amount';
  static const String noNotificationFoundTransKey = 'no notification found!';
  static const String yourOrderTransKey = 'your order';
  static const String isArrivedTransKey = 'is arrived ';
  static const String byTransKey = 'by';
  static const String emptyPassTransKey = 'empty password';
  static const String errorOccurredTransKey = 'error occurred';
  static const String weakTransKey = 'weak';
  static const String normalTransKey = 'normal';
  static const String strongTransKey = 'strong';
  static const String veryStrongTransKey = 'very strong';
  static const String uploadImageHereTransKey = 'upload image here';
  static const String successTransKey = 'success';
  static const String okTransKey = 'ok';
  static const String sorryTransKey = 'sorry';
  static const String confirmTransKey = 'confirm';
  static const String yesTransKey = 'yes';
  static const String noTransKey = 'no';
  static const String imageIsProcessingTransKey = 'image is processing';
  static const String pleaseWaitTransKey = 'please wait';
  static const String profileImageTransKey = 'profile image';
  static const String successUploadingProfileImageTransKey =
      'successfully uploaded profile image';
  static const String countryTransKey = 'country';
  static const String stateTransKey = 'state';
  static const String cityTransKey = 'city';
  static const String zipCodeTransKey = 'zip code';
  static const String localeCodeTransKey = Constants.languageTranslationKeyCode;

  static final Map<String, String> fallBackEnglishTranslation = {
    welcome01SuppliesTransKey: 'Welcome to 01 Supplies',
    helloThereTransKey: 'Hello there, sign in to continue',
    addAccountTransKey: 'Add Account',
    yourOrdersTransKey: 'Your orders',
    settingTransKey: 'Settings',
    dontHaveAnAccountTransKey: 'Don\'t have and account?',
    orSignInWithSocialAccountTransKey: 'Or sign in with social account',
    signOutTransKey: 'Sign out',
    addressProofTransKey: 'Address Proof',
    signUpTransKey: 'Sign Up',
    signInTransKey: 'Sign In',
    emailAddressTransKey: 'Email address',
    logInTransKey: 'Login',
    requestIdTransKey: 'Request id',
    passwordTransKey: 'Password',
    registrarTransKey: 'Register',
    rememberMeTransKey: 'Remember me',
    forgetPassTransKey: 'Forgot password',
    startDeliveryJobTransKey: 'Start Your Delivery Job With Us',
    yourDoneTransKey: 'You\'re done!',
    sendCodeTransKey: 'Send Code',
    pleaseConfirmTransKey:
        'Please confirm your country code and enter phone number',
    loremIpsumIsSimpleDummyTextTransKey:
        'Discover the easiest way to shop from a wide range of products across various',
    yourOfflineTransKey: 'You\'re Offline',
    yourOnlineTransKey: 'You\'re Online',
    yourOrderDetailsTransKey: 'Your Order Details',
    updateDeliveryManRegistrationTransKey: 'Update delivery man registration',
    myWalletTransKey: 'My Wallet',
    paymentHistoryTransKey: 'Payment History',
    termsConditionTransKey: 'Terms and Conditions',
    itemTransKey: 'Items',
    declineDeliveryTransKey: 'Decline Delivery',
    acceptDeliveryTransKey: 'Accept Delivery',
    markAsPickedTransKey: 'Mark as Picked',
    deliveryRejectedTransKey: 'Delivery rejected',
    markAsOnWayTransKey: 'Mark as on the way',
    markAsDeliveredTransKey: 'Mark as delivered',
    orderIsDeliveredTransKey: 'Order is Delivered',
    orderIdTransKey: 'Order Id',
    orderInfoTransKey: 'Order Info',
    subTotalTransKey: 'Subtotal',
    pickUpStationTransKey: 'Pick up Station',
    nameTransKey: 'Name',
    keepMeLoginTransKey: 'Keep Me Logged In',
    sendToBankTransKey: 'Send to Bank',
    confirmPasswordTransKey: 'Confirm password',
    vatTransKey: 'Vat',
    bySigningUpIAgreeToTheTransKey: 'By signing up, I agree to the',
    termsOfServiceTransKey: 'Terms of service',
    andTransKey: 'and',
    privacyPolicyTransKey: 'Privacy policy',
    alreadyHaveAnAccountTransKey: 'Already have an account?',
    firstNameTransKey: 'First name',
    pageNotFoundTransKey: 'Page not found',
    yourFirstNameTransKey: 'Your first name',
    lastNameTransKey: 'Last name',
    yourLastNameTransKey: 'Your last name',
    preferenceTransKey: 'Preference',
    gettingStartedTransKey: 'Getting Started',
    pickedStationChargeTransKey: 'Pickup station charge',
    deliveryChargeTransKey: 'Delivery charge',
    totalTransKey: 'Total',
    addCardTransKey: 'Add Card',
    withdrawTransKey: 'Withdraw',
    enterAmountTransferTransKey: 'Enter amount to transfer',
    exampleTransKey: 'Eg',
    bankInfoTransKey: 'Bank info',
    addBankTransKey: 'Add bank',
    accountHolderNameTransKey: 'Account holder name',
    bankNameTransKey: 'Bank name',
    branchCodeTransKey: 'Branch code',
    accountNumberTransKey: 'Account number',
    addBankAccountTransKey: 'Add bank account',
    cardInfoTransKey: 'Card info',
    nameOnCardTransKey: 'Name on card',
    cardNumberTransKey: 'Card number',
    expirationTransKey: 'Expiration',
    cvcTransKey: 'Cvc',
    postalCodeTransKey: 'Postal code',
    addTransKey: 'Add',
    callingTransKey: 'Calling',
    congratulationTransKey: 'Congratulations',
    goToHomeTransKey: 'Go to home',
    writeMessageTransKey: 'Write message',
    chatWithCustomerTransKey: 'Chat with customer',
    dontWorryTransKey:
        'Don\'t Worry! We\'ll let you know if there is any problem with your account',
    contactUsTransKey: 'Contact us',
    addressTransKey: 'Address',
    phoneTransKey: 'Phone',
    yourNameTransKey: 'Your name',
    yourEarningTransKey: 'your earning',
    youDrivedTransKey: 'You Drived',
    viewOrderInfoTransKey: 'View order info',
    backToHomeTransKey: 'Back to home',
    deliveredSuccessfullyTransKey: 'Delivered successfully!',
    messageTransKey: 'Message',
    getInTouchTransKey: 'Get in touch',
    deliveryManInfoTransKey: 'Delivery man information',
    taxNameTransKey: 'Tax name',
    taxNumberTransKey: 'Tax number',
    nidNumberTransKey: 'Nid number',
    yourTaxNameTransKey: 'Your tax name',
    applyNowTransKey: 'Apply now',
    languageTransKey: 'Language',
    selectLanguageTransKey: 'Select language',
    nationalIdTransKey: 'National identity card',
    balanceTransKey: 'Balance',
    addNewTransKey: 'Add new',
    recentTransactionTransKey: 'Recent transactions',
    noTransactionTransKey: 'No transaction found',
    notificationTransKey: 'Notification',
    passChangedTransKey: 'Great! Password changed',
    savedWithdrawMethodTransKey: 'Saved withdraw methods',
    youMustSelectAMethodTransKey: 'You must select a method first!',
    userDoesNotExistTransKey: 'User does not exist',
    yourAccountNotVerifiedTransKey: 'Your Account is not verified Yet!',
    verifyNowTransKey: 'Verify Now',
    canNotBeEmptyTransKey: 'Can not be empty',
    minimumLength3TransKey: 'Minimum length 3',
    mustMatchConfirmPassTransKey: 'Must match with confirm password',
    mustMatchPassTransKey: 'Must match with password',
    invalidEmailFormatTransKey: 'Invalid email format',
    invalidPhoneFormatTransKey: 'Invalid phone number format',
    youMustProvideInfoTransKey:
        'You must provide information first to proceed.',
    addingYourInfoTransKey: 'Adding your information.',
    noResponseFoundTransKey: 'No response found for this operation!',
    successfullyUpdatedTransKey: 'Successfully uploaded store logo image',
    errorOccurredProcessingImageTransKey:
        'Error occurred while processing image',
    areYouSureSetThisImageTransKey:
        'Are you sure to set this image as store logo?',
    successUploadingNIDTransKey: 'Successfully uploaded national card image',
    areYouSureSetNIDTransKey:
        'Are you sure to set this image as National ID Card?',
    successUploadingAddressProofImageTransKey:
        'Successfully uploaded address proof image',
    somethingWrongTransKey: 'Something Wrong Happened!',
    mustEnterAmountTransKey: 'Must enter amount',
    noNotificationFoundTransKey: 'No Notification Found!',
    yourOrderTransKey: 'Your order',
    isArrivedTransKey: 'is arrived',
    byTransKey: 'by',
    emptyPassTransKey: 'Empty password',
    errorOccurredTransKey: 'Error Occurred',
    weakTransKey: 'Weak',
    normalTransKey: 'Normal',
    strongTransKey: 'Strong',
    veryStrongTransKey: 'Very strong',
    uploadImageHereTransKey: 'Upload image here',
    successTransKey: 'Success',
    okTransKey: 'OK',
    sorryTransKey: 'Sorry',
    confirmTransKey: 'Confirm',
    yesTransKey: 'Yes',
    noTransKey: 'No',
    imageIsProcessingTransKey: 'Image is processing',
    pleaseWaitTransKey: 'Please wait',
    profileImageTransKey: 'Profile image',
    successUploadingProfileImageTransKey: 'Successfully uploaded profile image',
    countryTransKey: 'Country',
    stateTransKey: 'State',
    cityTransKey: 'City',
    zipCodeTransKey: 'Zip code',
    localeCodeTransKey: 'en_US',
  };

  static String currentLanguageText(String translationKey) {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    if (currentLanguageName is! String) {
      return fallbackText(translationKey);
    }
    final dynamic currentLanguageTranslations =
        AppSingleton.instance.localBox.get(currentLanguageName);
    if (currentLanguageTranslations is! Map<String, String>) {
      return fallbackText(translationKey);
    }
    final String? translatedText = currentLanguageTranslations[translationKey];
    if (translatedText == null) {
      return fallbackText(translationKey);
    }
    return translatedText;
  }

  static String fallbackText(String translationKey) =>
      AppLanguageTranslation.fallBackEnglishTranslation[translationKey] ?? '';
}
