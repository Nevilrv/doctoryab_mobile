import 'package:doctor_yab/app/modules/home/controllers/my_doctors_controller.dart';
import 'package:get/get.dart';

import '../controllers/doctors_controller.dart';

class DoctorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsController>(
      () => DoctorsController(),
    );
    Get.put<MyDoctorsController>(MyDoctorsController());
  }
}
