import 'dart:developer';

import 'package:doctor_yab/app/modules/notification/controllers/notification_controller.dart';
import 'package:doctor_yab/app/modules/profile_update/controllers/profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/settings_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedIndex = Get.arguments == null ? 0 : Get.arguments['id'];
  TabController pageController;
  var dropdownValue = ''.obs;
  WebViewController webViewController;
  NotificationController notificationController =
      Get.put(NotificationController());
  setIndex(int index) {
    if (Get.arguments == null) {
      log("index--------------> $index");
    } else {
      log(" Get.arguments['id']--------------> ${Get.arguments}");
    }

    selectedIndex = Get.arguments == null ? index : Get.arguments['id'];
    update();
  }

  @override
  void onInit() {
    pageController = TabController(length: 5, vsync: this);
    pageController.animateTo(Get.arguments == null ? 0 : Get.arguments['id']);
    super.onInit();
    Get.put(ProfileUpdateController());
    notificationController.changeLanguage();
    // SettingsController.userToken
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getPermission();
    });
    log("jwt: ${SettingsController.userToken}");
  }

  SpeechRecognition speech;
  Future _getPermission() async {
    speech = SpeechRecognition();
    speech.setAvailabilityHandler(
      (result) {},
    );
    speech.setRecognitionStartedHandler(
      () {},
    );
    speech.setRecognitionResultHandler(
      (text) {},
    );
    speech.setRecognitionCompleteHandler(
      (text) {},
    );
    speech.setErrorHandler(
      () {},
    );
    speech.activate('en_US').then((res) {
      log("speechRecognitionAvailable--------------->$res");
    });
  }

  @override
  void onReady() {
    super.onReady();
    checkForUpdate();
  }

  @override
  void onClose() {}
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      log("------------------------- is_update_available: $info");
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) async {
          log("-----------------------------> performImmediateUpdate_failed ${e.toString()}");
          try {
            await InAppUpdate.startFlexibleUpdate();
          } catch (e) {
            log("-----------------------------> startFlexibleUpdate_failed ${e.toString()}");
          }
          return AppUpdateResult.inAppUpdateFailed;
        });
      }
    }).catchError((e) {
      throw e;
    });
  }
}
