import 'package:doctor_yab/app/modules/favourites/drug_database/controller/drugs_controller.dart';
import 'package:get/get.dart';

class DrugsDatabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrugsController>(
      () => DrugsController(),
    );
  }
}
