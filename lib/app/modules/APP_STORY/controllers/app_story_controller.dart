import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';

import '../../../data/models/ads_model.dart';

class AppStoryController extends GetxController {
  StoryController storyC;
  AdsModel stories = Get.arguments[1] as AdsModel;
  int selectedStory = Get.arguments[0] as int;

  @override
  void onInit() {
    storyC = StoryController();
    super.onInit();
  }

  @override
  void onReady() {
    for (var i = 0; i < selectedStory; i++) {
      storyC.next();
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    if (storyC != null) {
      storyC.dispose();
    }
    super.dispose();
  }
}
