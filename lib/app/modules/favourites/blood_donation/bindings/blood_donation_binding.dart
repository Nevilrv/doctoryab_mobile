import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/blood_donation_controller.dart';
import 'package:get/get.dart';

class BloodDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodDonationController>(
      () => BloodDonationController(),
    );
  }
}
