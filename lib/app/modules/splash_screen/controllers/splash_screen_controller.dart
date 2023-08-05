import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Utils.whereShouldIGo();
      Get.delete<SplashScreenController>(force: true);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
