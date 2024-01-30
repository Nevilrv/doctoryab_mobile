import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/blood_donor_controller.dart';
import 'package:get/get.dart';

class BloodDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodDonorController>(
      () => BloodDonorController(),
    );
  }
}
