import 'package:ecomikdeliveryapp/models/enums.dart';

class OTPScreenParameter {
  final String userInput;
  final String type;
  final FromScreenName fromScreenName;

  OTPScreenParameter(
      {this.userInput = '',
      this.type = '',
      this.fromScreenName = FromScreenName.resetOrForgetPassScreen});
}
