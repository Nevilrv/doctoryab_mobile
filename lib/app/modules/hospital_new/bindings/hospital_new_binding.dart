import 'package:get/get.dart';

import '../controllers/hospital_new_controller.dart';

class HospitalNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalNewController>(
      () => HospitalNewController(),
    );
  }
}
