import 'package:get/get.dart';

import '../controllers/auth_phone_controller.dart';

class AuthPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthPhoneController>(
      () => AuthPhoneController(),
    );
  }
}
