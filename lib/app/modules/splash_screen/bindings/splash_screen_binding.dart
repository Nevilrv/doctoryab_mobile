import 'package:doctor_yab/app/modules/intro/controllers/intro_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.put(
      SplashScreenController(),
    );
    Get.put(IntroController());
    Jiffy.locale(Get.locale.languageCode);
  }
}
