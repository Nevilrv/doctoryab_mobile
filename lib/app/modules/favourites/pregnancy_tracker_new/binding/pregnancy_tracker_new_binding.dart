import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:get/get.dart';

class PregnancyTrackerNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PregnancyTrackerNewController>(
      () => PregnancyTrackerNewController(),
    );
  }
}
