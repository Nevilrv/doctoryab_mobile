import 'package:doctor_yab/app/modules/home/views/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:get/get.dart';

class CheckupPackagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckupPackagesController>(
      () => CheckupPackagesController(),
    );
  }
}
