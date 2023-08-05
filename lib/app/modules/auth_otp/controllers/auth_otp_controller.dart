import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthOtpController extends GetxController {
  var otpValidationError = "".obs;
  final otpFormatValid = false.obs;

  var enableSubmitButton = false.obs;
  TextEditingController textEditingController = TextEditingController();
  //countdown
  var countDountController = CountdownController(autoStart: true);
  var countDownFinished = false.obs;
  var waitingForFirebasToResendOtp = false.obs;
  //
  final arg = Get.arguments;
  @override
  void onInit() {
    ever(otpFormatValid, (_) {
      //
      if (otpFormatValid()) Get.focusScope.unfocus();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  verfyOtp() async {
    // waitingForFirebaseotpToVerify(true);
    EasyLoading.show(status: "please_wait".tr);

    if (GetPlatform.isWeb) {
      //TODO handle Error
      UserCredential uc = await AuthController.to.confirmationResult.confirm(
        textEditingController.text,
      );
      if (uc != null) {
        EasyLoading.dismiss();
        Utils.whereShouldIGo();
      }
    } else {
      //TODO handle Error
      await AuthController.to
          .signinToFirebaseWithSmsCode(smsCode: textEditingController.text);
    }
  }

  resendOtp() {
    countDownFinished(false);
    waitingForFirebasToResendOtp(true);

    AuthController.to.resendSms(
      phoneNumber: Utils.changeAfgNumberToIntlFormat(Get.arguments.toString()),
      smsSentCallBack: (String verficationID, int resendToken) {
        waitingForFirebasToResendOtp(false);
        countDountController.restart();
      },
      verificationFaildCallBck: (e) => () {
        waitingForFirebasToResendOtp(false);
        //TODO Handle error
      },
      authExciptionCallBck: (e) => () {
        waitingForFirebasToResendOtp(false);
        //TODO Handle error
      },
    );
    // Future.delayed(Duration(seconds: 3), () {
    //   waitingForFirebasToResendOtp(false);
    //   countDountController.restart();
    // });
  }

  validateOtpFormat(String s) {
    otpFormatValid(s.length == 6);
  }
}
