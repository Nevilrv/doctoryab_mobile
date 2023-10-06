import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:get/get.dart';

class DiseaseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiseaseTreatmentController>(
      () => DiseaseTreatmentController(),
    );
  }
}
