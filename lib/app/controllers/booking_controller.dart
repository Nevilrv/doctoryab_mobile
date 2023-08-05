import 'dart:developer';

import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxService {
  static var to = Get.put(BookingController());
  final Rx<DateTime> selectedDate = Rx<DateTime>(null);
  final Rx<Category> selectedCategory = Rx<Category>(null);
  final Rx<Doctor> selectedDoctor = Rx<Doctor>(null);
  @override
  void onInit() {
    super.onInit();
    // ever(selectedDate, (_) {
    //   log("llllll" + selectedDate()?.toUtc()?.toIso8601String());
    // });
    // ever(selectedCategory, (_) {
    //   log("llllll" + selectedCategory()?.title);
    // });
    // ever(selectedDoctor, (_) {
    //   log("llllll" + selectedDoctor()?.name);
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
