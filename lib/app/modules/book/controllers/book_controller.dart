import 'dart:developer';

import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/models/schedule_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class BookController extends GetxController {
  Doctor doctor;
  var category = BookingController.to.selectedCategory;

  var selectDate = ["8", "9", "10", "11", "12"].obs;
  var selectMorningTime = [
    "09.00 AM",
    "09.30 AM",
    "10.00 AM",
    "10.30 AM",
    "11.00 AM",
  ].obs;
  var selectEveningTime = [
    "09.00 AM",
    "09.30 AM",
    "10.00 AM",
    "10.30 AM",
    "11.00 AM",
  ].obs;
  var isCheckBox = false.obs;
  var selectedDates = 0.obs;
  var selectedMorningTime = 0.obs;
  var selectedEveningTime = 0.obs;
  TextEditingController teName = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  var pagingController = PagingController<int, ScheduleData>(firstPageKey: 1);

  RxBool hasError = false.obs;
  @override
  void onInit() {
    log("Get.arguments--------------> ${Get.arguments}");
    doctor = Get.arguments;
    log("doctor--------------> ${doctor.datumId}");

    update();
    // assert(Get.arguments != null && Get.arguments is Doctor);
    pagingController.addPageRequestListener((pageKey) {
      fetchDoctorTimeTable(pageKey);
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    doctor = null;
    BookingController.to.selectedDate.value = null;
    pagingController.dispose();

    super.onClose();
  }

  List<ScheduleData> dataList = [];
  List<DateTime> selectedDataList = [];
  String selectedDataTime = "";
  String selectedDate = "";
  bool isLoading = false;
  void fetchDoctorTimeTable(int pageKey) {
    doctor = Get.arguments;
    if (hasError.value) hasError(false);
    log(".--------------> ${doctor}");
    isLoading = true;
    update();
    DoctorsRepository()
        .fetchDoctorsTimeTable(
      pageKey,
      doctor,
    )
        .then((data) {
      log("data--------------> ${data}");

      log("data.data.--------------> ${data.data}");
      data.data['data'].forEach((element) {
        dataList.add(ScheduleData.fromJson(element));
      });
      if (dataList.isNotEmpty) {
        selectedDate = dataList[0].date.toString();
        selectedDataList = dataList[0].times;
        selectedDataTime = dataList[0].times[0].toString();
      }
      isLoading = false;
      update();
      // changeSlectedDate(dataList[0].date);

      // scheduleData.addAll()
      // var newItems = Schedule.fromJson(data.data).data;
      // pagingController.appendLastPage(newItems);
      // // if (newItems != null && newItems.length > 0)
      // changeSlectedDate(newItems[0].date);
    }).catchError((e, s) {
      isLoading = false;
      update();
      Future.delayed(Duration.zero, () {
        hasError(true);
      }).then((value) {
        // pagingController.error = e;
      });
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  Future<void> bookNow() async {
    await DoctorsRepository()
        .bookTime(
            patId: SettingsController.savedUserProfile.patientID,
            doctor: doctor.datumId.toString(),
            age: teAge.text,
            name: teName.text,
            phone: teNewNumber.text,
            time: DateTime.parse(selectedDataTime)
                .toUtc()
                .toIso8601String()
                .toString())
        .then((value) {
      log("value--------------> ${value}");
    }).catchError(
      (e, s) {
        log("e--------------> ${e}");

        DioExceptionHandler.handleException(
          exception: e,
          retryCallBak: bookNow,
        );
        FirebaseCrashlytics.instance.recordError(e, s);
      },
    );
  }

  String dateToIsoStr(DateTime date) {
    return date.toIso8601String();
  }
}
