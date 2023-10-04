import 'dart:developer';

import 'package:doctor_yab/app/modules/profile_update/controllers/profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/settings_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedIndex = 0.obs;
  TabController pageController;
  var dropdownValue = ''.obs;
  WebViewController webViewController;
  @override
  void onInit() {
    pageController = TabController(length: 5, vsync: this);
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
