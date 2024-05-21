import 'package:get/get.dart';

import '../../../data/models/post.dart';

class BlogFullPageController extends GetxController {
  //TODO: Implement BlogFullPageController

  final count = 0.obs;
  Post? post;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Post) {
      post = Get.arguments;
    } else {
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
