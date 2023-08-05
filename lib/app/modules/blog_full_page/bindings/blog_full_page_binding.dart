import 'package:get/get.dart';

import '../controllers/blog_full_page_controller.dart';

class BlogFullPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogFullPageController>(
      () => BlogFullPageController(),
    );
  }
}
