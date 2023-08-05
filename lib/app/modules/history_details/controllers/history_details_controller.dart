import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:get/get.dart';

class HistoryDetailsController extends GetxController {
  final History item = Get.arguments;
  final RxDouble currentRate = 0.0.obs;
  @override
  void onInit() {
    // assert(Get.arguments)
    currentRate.value = item?.starsForDoc?.toDouble() ?? 0.0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
