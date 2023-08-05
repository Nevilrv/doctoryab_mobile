import 'package:get/get.dart';

import '../controllers/login_verify_controller.dart';

class LoginVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      LoginVerifyController(),
    );
  }
}
