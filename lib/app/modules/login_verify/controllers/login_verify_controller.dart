import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/user_model.dart';
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

  // eyJhbGciOiJSUzI1NiIsImtpZCI6IjBkMGU4NmJkNjQ3NDBjYWQyNDc1NjI4ZGEyZWM0OTZkZjUyYWRiNWQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcGx1Y2t5LWNhc2NhZGUtMzAzNzA3IiwiYXVkIjoicGx1Y2t5LWNhc2NhZGUtMzAzNzA3IiwiYXV0aF90aW1lIjoxNjk4ODM2Mzc5LCJ1c2VyX2lkIjoiNFdua0pkTkpYN1VPamNHTXNRN2FPejNJcXB6MSIsInN1YiI6IjRXbmtKZE5KWDdVT2pjR01zUTdhT3ozSXFwejEiLCJpYXQiOjE2OTg4MzYzNzksImV4cCI6MTY5ODgzOTk3OSwicGhvbmVfbnVtYmVyIjoiKzkzNzQ0MDAwMDAwIiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrOTM3NDQwMDAwMDAiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwaG9uZSJ9fQ.RA11Mqffdu0ovhsJquE47_ws91LVWH3OnBsYcFfG97hgfgJucrwZEhOqVfIp8D8ZLXUfG-tm5ljt3gHKj7A1NqxEZh4AUFGGi4TxgL4Q_IZ6PD90xa1SOC8EGfT3IOMt6u1rRYP3KBvJsFbEW3GHUf_ih4HMgY1zGgCmtb4S540UFb5lTSYq4NoHSP9CVxu64Jsim5PPgFORh4jXqzZ9IW4KGew7QsT1SMNK32l3Ltt_FQWT_sGZiPzTSU0ZrXVpiEbmsmxVo7T8g5r2D4-IbyuiLL2P7C8vOdKgcE6sMxplqRmLN1vUva1iaTMObBr1y34NHfe-5o1We3Wec53iGg
  @override
  void onClose() {}

  void verfyUser() {
    // Utils.whereShouldIGo();
    AuthRepository().signin().then((response) async {
      var reponseData = response.data;
      // print(reponseData);
      SettingsController.userToken = reponseData["jwtoken"];
      SettingsController.userProfileComplete = reponseData["profile_completed"];
      SettingsController.userId = reponseData['user']['_id'];
      try {
        SettingsController.savedUserProfile =
            User.fromJson(reponseData['user']);
        log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.id}");
      } catch (e) {
        log("e--------------> ${e}");
      }
      log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.userId}");

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
