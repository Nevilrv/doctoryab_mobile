import 'package:get/get.dart';

import '../controllers/find_blood_donor_controller.dart';

class FindBloodDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindBloodDonorController>(
      () => FindBloodDonorController(),
    );
  }
}
