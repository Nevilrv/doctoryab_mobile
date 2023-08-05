import 'package:get/get.dart';

import '../controllers/app_story_controller.dart';

class AppStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppStoryController>(
      () => AppStoryController(),
    );
  }
}
