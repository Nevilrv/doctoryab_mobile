import 'package:doctor_yab/app/modules/review/controller/review_controller.dart';

import 'package:get/get.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReviewController());
  }
}
