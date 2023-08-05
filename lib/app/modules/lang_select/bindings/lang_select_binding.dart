import 'package:get/get.dart';

import '../controllers/lang_select_controller.dart';

class LangSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LangSelectController>(
      () => LangSelectController(),
    );
  }
}
