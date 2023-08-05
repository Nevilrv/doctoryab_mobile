import 'package:get/get.dart';

import '../controllers/blood_donor_controller.dart';

class BloodDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodDonorController>(
      () => BloodDonorController(),
    );
  }
}
