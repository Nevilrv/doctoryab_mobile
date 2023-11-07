import 'package:doctor_yab/app/modules/home/controllers/comp_sugge_controller.dart';
import 'package:get/get.dart';

import '../controllers/profile_update_controller.dart';

class ProfileUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUpdateController>(
      () => ProfileUpdateController(),
    );
    Get.lazyPut<ComplaintSuggestionController>(
      () => ComplaintSuggestionController(),
    );
  }
}
