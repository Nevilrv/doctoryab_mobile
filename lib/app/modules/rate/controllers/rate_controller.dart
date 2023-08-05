import 'dart:convert';
import 'dart:developer';

import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_meeting_time_controller.dart';
import 'package:doctor_yab/app/modules/rate/views/rate_item_view.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RateController extends GetxController {
  Doctor doctor;
  String patId;
  var args = Get.arguments;
  var blaBla = ["doc_manner".tr, "doc_skill".tr, "doc_cleanness".tr];
  var bla2 = <double>[].obs;
  var isButtonDeactive = false.obs;
  var pages = <Widget>[];
  var done = false.obs;
  var pageController = PageController();

  @override
  void onInit() {
    isButtonDeactive.value = true;
    bla2.clear();
    for (int i = 0; i < blaBla.length; i++) {
      bla2.add(0.0);
      pages.add(
        Obx(() => RateItemView(
              title: blaBla[i],
              initStars: bla2[i],
              onRate: (d) {
                // print(d);
                bla2[i] = d;
              },
            )),
      );
    }
    blaBla.forEach((element) {});

    try {
      var _json = jsonDecode(args);
      // log(_json);
      doctor = _json['doctor'].runtimeType == String
          ? Doctor.fromJson(jsonDecode(_json['doctor']))
          : Doctor.fromJson(_json['doctor']);
      patId = _json["pid"];
      print("success_notification_decode");
    } catch (e, s) {
      Get.back();
      // Get.back();
      Utils.showSnackBar(Get.context, "invalid_notification_sent".tr);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void rate(BuildContext context) {
    EasyLoading.show(status: "please_wait".tr);
    DoctorsRepository.rateDoctorByPatId(patId, bla2[2], bla2[1], bla2[0])
        .then((value) {
      Get.back(
          result:
              bla2.reduce((previousValue, element) => previousValue + element) /
                  bla2.length);
      Utils.showSnackBar(context, 'rate_suc'.tr);
      EasyLoading.dismiss();
      var tmpController = Get.find<TabMeetingTimeController>();
      if (tmpController != null) {
        tmpController.pagingController.refresh();
      }
    }).catchError((e) {
      DioExceptionHandler.handleException(
          exception: e, retryCallBak: () => rate(context));
      EasyLoading.dismiss();
    });
  }

  @override
  void onClose() {}
}
