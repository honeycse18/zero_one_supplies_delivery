import 'package:get/get.dart';

class CallScreenController extends GetxController {
  /// Toggle value of hide new password
  ///   /// Microphone active toggle
  RxBool isMicrophoneActive = true.obs;

  /// Speaker active toggle
  RxBool isSpeakerActive = false.obs;
}
