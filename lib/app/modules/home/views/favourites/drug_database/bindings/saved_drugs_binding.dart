import 'package:doctor_yab/app/modules/home/views/favourites/drug_database/controller/drugs_controller.dart';
import 'package:get/get.dart';

class SavedDrugsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrugsController>(
      () => DrugsController(),
    );
  }
}
