import 'package:doctor_yab/app/modules/home/controllers/appointmtnet_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/messages_list_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/reports_controller.dart';
import 'package:doctor_yab/app/modules/review/controller/review_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
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
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MessagesListController>(
      () => MessagesListController(),
    );
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
    Get.put(TabTabHomeController());
    Get.put(
      TabMeetingTimeController(),
    );
    Get.lazyPut<TabSearchController>(
      () => TabSearchController(),
    );
    Get.put(TabSearchController());
    Get.put(TabHomeMainController());
    Get.put(HomeController());
    //
    Get.lazyPut<HospitalsController>(() => HospitalsController());
    Get.put(HospitalsController());
    Get.lazyPut<DrugStoreController>(() => DrugStoreController());
    Get.lazyPut<DrugStoreLabController>(() => DrugStoreLabController());
    Get.lazyPut<AppointmentHistoryController>(
        () => AppointmentHistoryController());
    Get.put(AppointmentHistoryController());
    Get.put(DrugStoreController());
    Get.put(DrugStoreLabController());
    Get.lazyPut<LabsController>(() => LabsController());
    Get.put(LabsController());
    Get.lazyPut<ReportsController>(() => ReportsController());
    Get.put(ReportsController());
  }
}
