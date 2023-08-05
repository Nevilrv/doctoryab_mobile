import 'package:get/get.dart';

import '../controllers/tab_main_controller.dart';

class TabMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabMainController>(
      () => TabMainController(),
    );
  }
}
