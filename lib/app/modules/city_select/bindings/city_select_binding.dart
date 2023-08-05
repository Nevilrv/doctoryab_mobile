import 'package:get/get.dart';

import '../controllers/city_select_controller.dart';

class CitySelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CitySelectController>(
      () => CitySelectController(),
    );
  }
}
