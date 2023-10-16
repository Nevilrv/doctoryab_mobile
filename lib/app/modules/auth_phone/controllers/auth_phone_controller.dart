import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/FirebaseAuthExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AuthPhoneController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  TextEditingController teName = TextEditingController();
  var phoneValid = false.obs;
  var phoneValidationError = "".obs;
  var locations = [
    'Kâbil',
    'Herat',
    'Kandehar',
    'Mezar-ı Şerif',
    'Celalabad',
    'Kunduz',
    'Puli Humri',
  ];
  var selectedLocation = "Kâbil".obs;
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  @override
  void onInit() {
    ever(phoneValid, (_) {
      //
      if (phoneValid()) Get.focusScope.unfocus();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void verfyPhoneNumber(String number) {
    try {
      number = number.toEnglishDigit();
    } catch (e) {}
    PhoneValidatorUtils phoneValidatorUtils =
        PhoneValidatorUtils(number: number);
    phoneValid(phoneValidatorUtils.isValid());
    phoneValidationError(phoneValidatorUtils.errorMessage);
    phoneValidatorUtils = null;
  }

  signInWithPhone() {
    Get.focusScope.unfocus();
    // SettingsController.setAppLanguage(
    //     controller.selectedLang());
    var _phoneNum =
        Utils.changeAfgNumberToIntlFormat(textEditingController.text);
    if (GetPlatform.isWeb) {
      EasyLoading.show(status: "please_wait".tr);
      AuthController.to.signInWithPhoneWeb(
          phoneNum: _phoneNum,
          successCallBack: () {
            EasyLoading.dismiss();
            Get.toNamed(
              Routes.AUTH_OTP,
              arguments: textEditingController.text,
            );
          },
          errorCallBackWeb: (e) {
            EasyLoading.dismiss();
          });
    } else {
      EasyLoading.show(status: "please_wait".tr);
      AuthController.to.registerWithPhoneNumber(
        verfiedCallBack: (_) {
          EasyLoading.dismiss();
          // Get.reset(
          //   clearFactory: false,
          //   clearRouteBindings: false,
          // );
          Utils.whereShouldIGo();
        },
        phoneNumber: _phoneNum,
        smsSentCallBack: (_, __) {
          EasyLoading.dismiss();
          Get.toNamed(
            Routes.AUTH_OTP,
            arguments: textEditingController.text,
          );
        },
        // verificationFaildCallBck: (_) => AppGetDialog.show(
        //   middleText: "failed_to_send_otp".tr,
        // ),
        verificationFaildCallBck: (e) => FirebaseAuthExceptionHandler.handle(e),
      );
    }
  }
}
