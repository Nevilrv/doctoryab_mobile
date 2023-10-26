import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

class LoginVerifyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 1), () {
      verfyUser();
    });
    super.onReady();
  }

  @override
  void onClose() {}

  void verfyUser() {
    // Utils.whereShouldIGo();
    AuthRepository().signin().then((response) async {
      var reponseData = response.data;
      // print(reponseData);
      SettingsController.userToken = reponseData["jwtoken"];
      SettingsController.userProfileComplete = reponseData["profile_completed"];

      Utils.whereShouldIGo();
    }).catchError((e, s) {
      // Utils.whereShouldIGo();
      DioExceptionHandler.handleException(
        exception: e,
        retryCallBak: verfyUser,
      );
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
