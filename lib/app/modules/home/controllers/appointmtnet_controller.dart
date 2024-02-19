import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/appointment_history_res_model.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/data/repository/AppointmentRepository.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppointmentHistoryController extends GetxController {
  CancelToken cancelToken = CancelToken();

  @override
  void onInit() {
    fetchAppointmentHistory();
    super.onInit();
  }

  List<History> appointmentList = [];

  bool isLoading = false;
  void fetchAppointmentHistory() {
    isLoading = true;
    update();
    AppointmentRepository.fetchAppointmentHistory(cancelToken: cancelToken)
        .then((v) {
      // AdsModel v = AdsModel();
      appointmentList.clear();
      log("v. ${v.data}");
      if (v.data.isNotEmpty) {
        appointmentList.addAll(v.data);
        update();
      }
      isLoading = false;
      update();
    }).catchError((e, s) {
      log("e--------------> $e");
      isLoading = false;
      update();
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) fetchAppointmentHistory();
      });
    });
  }

  var cRating = 0.0;
  var sRating = 0.0;
  var eRating = 0.0;
  TextEditingController comment = TextEditingController();

  bool isLoading1 = false;
  void addDocFeedback({
    String doctorId,
    BuildContext context,
  }) async {
    isLoading1 = true;
    update();
    try {
      var data = {
        "comment": comment.text,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "doctorId": doctorId
      };
      log(" ${data}");

      var _response = await DoctorsRepository()
          .postDoctorFeedback(
              cancelToken: cancelToken,
              body: data,
              url: "${ApiConsts.postDoctorFeedback}")
          .then((value) {
        Get.back();
        Get.back();
        isLoading1 = false;
        update();
        comment.clear();
        cRating = 0.0;
        eRating = 0.0;
        sRating = 0.0;
        log("value--------------> ${value}");
        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      }).catchError((e, s) {
        comment.clear();
        cRating = 0.0;
        eRating = 0.0;
        sRating = 0.0;
        Utils.commonSnackbar(
            context: context, text: "${e.response.data['msg']}");
        log("e------asd--------> ${e.response.data['msg']}");
        isLoading1 = false;
        update();
      });
    } on DioError catch (e) {
      isLoading1 = false;
      update();
      log("e--------------> ${e.response.data['msg']}");

      await Future.delayed(Duration(seconds: 2), () {});
      // if (!cancelToken.isCancelled) addDocFeedback(doctorId: doctorId);
      // throw e;
      print(e);
    }
  }
}
