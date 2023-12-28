import 'dart:developer';

import 'package:doctor_yab/app/modules/profile_update/controllers/profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/settings_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedIndex = Get.arguments == null ? 0 : Get.arguments['id'];
  TabController pageController;
  var dropdownValue = ''.obs;
  WebViewController webViewController;

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

    // SettingsController.userToken

    log("jwt: ${SettingsController.userToken}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
