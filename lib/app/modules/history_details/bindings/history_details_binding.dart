import 'package:get/get.dart';

import '../controllers/history_details_controller.dart';

class HistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryDetailsController>(
      () => HistoryDetailsController(),
    );
  }
}
