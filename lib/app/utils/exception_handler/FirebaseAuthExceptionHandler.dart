import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FirebaseAuthExceptionHandler {
  static handle(FirebaseAuthException e) {
    EasyLoading.dismiss();
    switch (e.code) {
      case "invalid-verification-code":
        {
          AppGetDialog.show(middleText: "invalid_otp_code".tr);
          break;
        }
      case "too-many-requests":
        {
          AppGetDialog.show(middleText: "too_manay_sms_auth_request".tr);
          break;
        }
      case "network-request-failed":
        {
          AppGetDialog.show(middleText: "network_request_failed".tr);
          break;
        }
      default:
        {
          AppGetDialog.show(middleText: e.code + ": " + e.message.toString());
        }
    }
  }

  // static handleFacebookAuthException(FacebookAuthException e) {
  //   switch (e.errorCode) {
  //     case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
  //       AppGetDialog.show(
  //           middleText: "You have a previous login operation in progress");
  //       break;
  //     case FacebookAuthErrorCode.CANCELLED:
  //       AppGetDialog.show(middleText: "login cancelled");
  //       break;
  //     case FacebookAuthErrorCode.FAILED:
  //       AppGetDialog.show(middleText: "login failed");
  //       break;
  //     default:
  //       AppGetDialog.show(middleText: e.errorCode + ": " + e.message);
  //   }
  // }
}
