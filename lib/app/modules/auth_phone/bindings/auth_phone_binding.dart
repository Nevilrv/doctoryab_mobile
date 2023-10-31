import 'package:doctor_yab/app/modules/auth_phone/controllers/personal_detail_add_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_phone_controller.dart';

class AuthPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthPhoneController>(
      () => AuthPhoneController(),
    );
    Get.lazyPut<AddPersonalInfoController>(
      () => AddPersonalInfoController(),
    );
  }
}
