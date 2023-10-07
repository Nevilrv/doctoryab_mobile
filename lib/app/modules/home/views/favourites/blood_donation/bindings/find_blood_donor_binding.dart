import 'package:doctor_yab/app/modules/home/views/favourites/blood_donation/controller/find_blood_donor_controller.dart';
import 'package:get/get.dart';

class FindBloodDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindBloodDonorController>(
      () => FindBloodDonorController(),
    );
  }
}
