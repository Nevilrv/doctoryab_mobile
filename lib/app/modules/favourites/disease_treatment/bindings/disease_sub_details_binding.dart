import 'package:doctor_yab/app/modules/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:get/get.dart';

class DiseaseSubDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiseaseTreatmentController>(
      () => DiseaseTreatmentController(),
    );
  }
}
