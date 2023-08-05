import 'package:get/get.dart';

import '../controllers/blood_donors_results_controller.dart';

class BloodDonorsResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodDonorsResultsController>(
      () => BloodDonorsResultsController(),
    );
  }
}
