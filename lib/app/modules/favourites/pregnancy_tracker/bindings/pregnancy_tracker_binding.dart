import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/controllers/pregnancy_tracker_controller.dart';
import 'package:get/get.dart';

class PregnancyTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PregnancyTrackerController>(
      () => PregnancyTrackerController(),
    );
  }
}
