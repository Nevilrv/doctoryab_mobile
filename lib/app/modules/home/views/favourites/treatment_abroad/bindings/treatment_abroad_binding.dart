import 'package:doctor_yab/app/modules/home/views/favourites/treatment_abroad/controllers/treatment_abroad_controller.dart';
import 'package:get/get.dart';

class TreatmentAbroadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TreatmentAbroadController>(
      () => TreatmentAbroadController(),
    );
  }
}
