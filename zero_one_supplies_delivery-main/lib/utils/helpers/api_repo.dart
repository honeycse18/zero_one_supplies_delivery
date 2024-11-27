import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ecomikdeliveryapp/models/api_responses/chat_recipients.dart';
import 'package:ecomikdeliveryapp/models/api_responses/confirmed_delivery_requests_api_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/confirmed_orders_api_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/delivery_man_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/language_translations_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/languages_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/otp_verify_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/payment_history_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/pick_up_stations_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/reset_password_create_new_password_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/reset_password_otp_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/send_otp_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/setup_delivery_man_info_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/sign_in_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/signup_otp_verification_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/single_image_upload_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/site_settings_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/add_withdraw_method_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/term_condition_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_active_status_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/updated_order_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/user_notification_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/user_sign_up_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/wallet_details_response.dart';
import 'package:ecomikdeliveryapp/models/api_responses/wallet_histories_response.dart';
import 'package:ecomikdeliveryapp/models/core_api_responses/raw_api_response.dart';
import 'package:ecomikdeliveryapp/models/socket_responses/confirmed_order.dart';
import 'package:ecomikdeliveryapp/utils/api_client.dart';
import 'package:ecomikdeliveryapp/utils/helpers/api_helper.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class APIRepo {
  static Future<SignInResponse?> login(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response =
          await apiHttpClient.post('api/user/login', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SignInResponse responseModel =
          SignInResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserSignUpResponse?> signUp(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient
          .post('api/user/delivery/signup', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserSignUpResponse responseModel =
          UserSignUpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DeliveryManDetailsResponse?> getUserDetails() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/user/deliver-man/verify',
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DeliveryManDetailsResponse responseModel =
          DeliveryManDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserNotificationResponse?> getUserNotifications(
      int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/notification/user/list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserNotificationResponse responseModel =
          UserNotificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PaymentHistoryResponse?> getPaymentHistory(
      int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/delivery/earning-history',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PaymentHistoryResponse responseModel =
          PaymentHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<TermsConditionResponse?> getTermsCondition(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/about-us/get-one',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final TermsConditionResponse responseModel =
          TermsConditionResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AddWithdrawMethodResponse?> addWithdrawMethod(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/delivery/withdraw-method',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AddWithdrawMethodResponse responseModel =
          AddWithdrawMethodResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*static Future<AuctionsResponse?> getAuctions(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/auction/all',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AuctionsResponse responseModel =
          AuctionsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DashBoardResponse?> getDashBoardResponse() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      // final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/frontend/dashboard-app',
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DashBoardResponse responseModel =
          DashBoardResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }*/

  static Future<ResetPasswordOtpResponse?> sendResetOtp(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/send-reset-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ResetPasswordOtpResponse responseModel =
          ResetPasswordOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpVerifyResponse?> verifyOtpForResetPass(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/verify-reset-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpVerifyResponse responseModel =
          OtpVerifyResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SendOtpResponse?> sendVerifyUserOTP(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/signup-resend-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SendOtpResponse responseModel =
          SendOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SignUpOtpVerificationResponse?> signUpOtpVerification(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/delivery/signup-otp-verify', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SignUpOtpVerificationResponse responseModel =
          SignUpOtpVerificationResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*static Future<SendOtpResponse?> sendVerifyVendorOTP(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/signup-resend-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SendOtpResponse responseModel =
          SendOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<BidDetailsResponse?> fetchAuctionDetails(String bidID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': bidID};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/auction/details',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final BidDetailsResponse responseModel =
          BidDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  } */

  static Future<ResetPasswordCreateNewPasswordResponse?> resetPassCreateNewPass(
      String requestJsonString, String authToken) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient.post(
          'api/user/password-reset-by-otp',
          body: requestJsonString,
          headers: {'Authorization': 'Bearer $authToken'});

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ResetPasswordCreateNewPasswordResponse responseModel =
          ResetPasswordCreateNewPasswordResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SetupDeliveryManInfoResponse?> setDeliveryManInfo(
      String requestJsonString,
      {String token = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient.post(
          'api/delivery/info/setup',
          body: requestJsonString,
          headers: token.isNotEmpty
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SetupDeliveryManInfoResponse responseModel =
          SetupDeliveryManInfoResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PickUpStationsResponse?> getPickUpStations(int pageSize) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'size': '$pageSize'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.get('api/pickup-station', query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PickUpStationsResponse responseModel =
          PickUpStationsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleImageUploadResponse?> uploadImage(File imageFile,
      {String imageFileName = '', String id = '', String token = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final String fileName;
      final formDataMap = <String, dynamic>{};
      if (imageFileName.isNotEmpty) {
        formDataMap['image_name'] =
            path.basenameWithoutExtension(imageFileName);
        fileName = imageFileName;
      } else {
        fileName = path.basename(imageFile.path);
      }
      if (id.isNotEmpty) {
        formDataMap['_id'] = id;
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      FormData formData = FormData({
        ...formDataMap,
        'image': MultipartFile(imageFile, filename: fileName),
      });
      final Response response = await apiHttpClient.post(
          'api/file/single-image-aws',
          body: formData,
          headers: token.isNotEmpty
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleImageUploadResponse responseModel =
          SingleImageUploadResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ActiveStatusUpdatedResponse?> updateActiveStatus(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/delivery/update-active-status',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      log(jsonEncode(response.body));
      final ActiveStatusUpdatedResponse responseModel =
          ActiveStatusUpdatedResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UpdatedOrderDetailsResponse?> getOrderDetails(
      String orderID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'_id': orderID};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/delivery/details-by-deliveryman',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      log(jsonEncode(response.body));
      final UpdatedOrderDetailsResponse responseModel =
          UpdatedOrderDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateOrderStatus(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/delivery/status-change',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WalletDetailsResponse?> fetchWalletDetails() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final Map<String, String> queries = {'_id': orderID};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/delivery/wallet',
          // query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final WalletDetailsResponse responseModel =
          WalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WalletHistoriesResponse?> fetchWalletHistories() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final Map<String, String> queries = {'_id': orderID};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.get('api/delivery/wallet-withdraw-history',
              // query: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final WalletHistoriesResponse responseModel =
          WalletHistoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> makeWithdraw(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/delivery/withdraw-request',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SiteSettingsResponse?> getSiteSettings() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/settings/site');

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SiteSettingsResponse responseModel =
          SiteSettingsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguageTranslationsResponse?>
      fetchLanguageTranslations() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/settings/language/translations',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguageTranslationsResponse responseModel =
          LanguageTranslationsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/settings/all-languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ConfirmedOrdersAPIResponse?> fetchConfirmedOrders(
      int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/order/deliveryman-confirm-order-list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ConfirmedOrdersAPIResponse responseModel =
          ConfirmedOrdersAPIResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ConfirmedDeliveryRequestsResponse?>
      fetchConfirmedDeliveryRequests(int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/order/approved/delivery-request-list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ConfirmedDeliveryRequestsResponse responseModel =
          ConfirmedDeliveryRequestsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatRecipients?> getChatList({String vendorID = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      Map<String, String>? queries;
      if (vendorID.isNotEmpty) {
        queries = {'vendor': vendorID};
      }
      final Response response = await apiHttpClient.get(
        'api/delivery/chat-list',
        query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatRecipients responseModel =
          ChatRecipients.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> logout(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient.post('api/user/logout',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> uploadChatImage(String requestBodyJson) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
        'api/user/message/attach-file-send',
        headers: APIHelper.getAuthHeaderMap(),
        body: requestBodyJson,
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse objectResponse =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      return objectResponse;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
}
