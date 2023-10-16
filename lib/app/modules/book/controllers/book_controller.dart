import 'dart:developer';

import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/schedule_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class BookController extends GetxController {
  var doctor = BookingController.to.selectedDoctor;
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
  // RxInt selectedIndex = 0.obs;
  RxString selectedDate = RxString(null);
  RxString selectedTime = RxString(null);
  RxList<Widget> dateChilds = <Widget>[].obs;
  RxList<DateTime> amTimes = <DateTime>[].obs;
  RxList<DateTime> pmTimes = <DateTime>[].obs;
  RxBool hasError = false.obs;
  @override
  void onInit() {
    // assert(Get.arguments != null && Get.arguments is Doctor);
    // pagingController.addPageRequestListener((pageKey) {
    //   _fetchDoctorTimeTable(pageKey);
    // });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    doctor.value = null;
    BookingController.to.selectedDate.value = null;
    pagingController.dispose();

    selectedDate.value = null;
    selectedTime.value = null;
    dateChilds.clear();
    amTimes.clear();
    pmTimes.clear();

    super.onClose();
  }

  void _fetchDoctorTimeTable(int pageKey) {
    if (hasError.value) hasError(false);
    log("hhhhhhhhhhhhhhhhh ${hasError.value}");
    DoctorsRepository()
        .fetchDoctorsTimeTable(pageKey, doctor(), category())
        .then((data) {
      var newItems = Schedule.fromJson(data.data).data;
      pagingController.appendLastPage(newItems);
      // if (newItems != null && newItems.length > 0)
      changeSlectedDate(newItems[0].date);
    }).catchError((e, s) {
      Future.delayed(Duration.zero, () {
        hasError(true);
      }).then((value) {
        pagingController.error = e;
      });
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  String dateToIsoStr(DateTime date) {
    return date.toIso8601String();
  }

  void _rebuildChildWidget(DateTime dateTime, [index]) {
    // print(pagingController.itemList == null);
    dateChilds.clear();
    amTimes.clear();
    pmTimes.clear();
    if (pagingController.itemList == null) {
      dateChilds.add(Container());
    } else {
      //* cheack AM OR PM
      pagingController.itemList[index].times.forEach((element) {
        var _localTime = element.toLocal();
        var _formatedTime = DateFormat.jm().format(_localTime);
        print(_formatedTime);
        // if (_formatedTime.contains("am".toUpperCase())) {
        if (_localTime.hour > 11) {
          pmTimes.add(_localTime);
        } else {
          amTimes.add(_localTime);
        }
      });

      //* //end
      _addToChild(amTimes, "AM".tr);
      _addToChild(pmTimes, "PM".tr);
    }
  }

  void changeSlectedDate(DateTime date, [index = 0]) {
    selectedTime("");
    selectedDate(date.toIso8601String());
    _rebuildChildWidget(date, index);
    print(date.toIso8601String());
  }

  void _addToChild(RxList<DateTime> dates, String title) {
    if (dates.length > 0) {
      var _colChild = <Widget>[];
      dateChilds.add(
        Text(
          title,
          style: AppTextTheme.b(18).copyWith(color: AppColors.black2),
        ).paddingOnly(bottom: 12),
      );
      _colChild.addAll(
        dates.map(
          (element) => Obx(
            () => Container(
              child: Text(
                DateFormat('h:mm a').format(element.toLocal()).toUpperCase(),
                // .replaceAll(RegExp(r'(\s[AP]M)'), "")
                style: AppTextTheme.b(19).copyWith(color: Colors.white),
              ),
            )
                .paddingSymmetric(horizontal: 15, vertical: 7)
                .bgColor(selectedTime() == element.toUtc().toIso8601String()
                    ? Get.theme.primaryColor
                    : Get.theme.primaryColor.withOpacity(0.15))
                .radiusAll(12)
                .onTap(() {
              selectedTime(
                element.toUtc().toIso8601String(),
              );
              print(selectedTime());
            }),
          ),
        ),
      );
      dateChilds.add(
        Wrap(spacing: 8.0, runSpacing: 4.0, children: _colChild)
            .paddingOnly(bottom: 20),
      );
    } else {
      //TODO urgent show empty error
      dateChilds.add(Center(child: Text("")));
    }
  }

  bool isTimePicked() {
    return !(selectedTime() == null || selectedTime() == "");
  }
}
