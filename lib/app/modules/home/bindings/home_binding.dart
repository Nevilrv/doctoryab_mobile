import 'package:doctor_yab/app/modules/home/controllers/messages_list_controller.dart';
import 'package:get/get.dart';

import 'package:doctor_yab/app/modules/home/controllers/tab_blog_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_doctors_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_meeting_time_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_more_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_search_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/hospitals_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_labs_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagesListController>(
      () => MessagesListController(),
    );
    // Get.put(MessagesListController());
    // Get.put(ChatController());
    // Get.lazyPut<TabChatController>(
    //   () => TabChatController(),
    // );
    Get.lazyPut<TabMoreController>(
      () => TabMoreController(),
    );
    Get.lazyPut<TabBlogController>(
      () => TabBlogController(),
    );
    Get.lazyPut<TabHomeMainController>(
      () => TabHomeMainController(),
    );
    Get.lazyPut<TabTabHomeController>(
      () => TabTabHomeController(),
    );
    Get.put(
      TabMeetingTimeController(),
    );
    Get.lazyPut<TabSearchController>(
      () => TabSearchController(),
    );
    Get.put(TabHomeMainController());
    Get.put(HomeController());
    //
    Get.lazyPut<HospitalsController>(() => HospitalsController());
    Get.lazyPut<DrugStoreController>(() => DrugStoreController());
    Get.lazyPut<LabsController>(() => LabsController());
  }
}
