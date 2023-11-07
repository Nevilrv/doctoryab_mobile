import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctor_feedback_res_model.dart';
import 'package:doctor_yab/app/data/models/doctor_full_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  final args = Get.arguments;
  // var doctorsLoded = false.obs;
  Rxn<DoctorFullModel> doctorFullData = Rxn();
  Doctor doctor;
  var cancelToken = CancelToken();
  var tabIndex = 0.obs;
  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  TextEditingController comment = TextEditingController();
  @override
  void onInit() {
    doctor = args;
    log("doctor.datumId--------------> ${doctor.datumId}");

    getDocFeedback(doctorId: doctor.datumId);
    // if (!(args is List && args.length > 0 && args[0] is Doctor)) {
    //   Get.back();
    // } else {
    //   doctor = args[0];
    // }
    // _fetchDoctorFullData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cancelToken.cancel();
  }

  void _fetchDoctorFullData() async {
    try {
      var _response =
          await DoctorsRepository().fetchDoctorFullData(doctor.id.toString());
      var _data = _response.data;
      doctorFullData.value = DoctorFullModel.fromJson(_data);
      doctorFullData.refresh();
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) _fetchDoctorFullData();
      // throw e;
      print(e);
    }
  }

  void addDocFeedback({
    String doctorId,
    BuildContext context,
  }) async {
    try {
      var data = {
        "comment": comment,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "doctorId": doctorId
      };
      var _response = await DoctorsRepository()
          .postDoctorFeedback(
              cancelToken: cancelToken,
              body: data,
              url: "${ApiConsts.postDoctorFeedback}")
          .then((value) {
        Get.back();
        getDocFeedback(doctorId: doctor.datumId);
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        log("value--------------> ${value}");
        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) addDocFeedback(doctorId: doctorId);
      // throw e;
      print(e);
    }
  }

  var feedbackData = <FeedbackData>[];
  var loading = false.obs;
  void getDocFeedback({
    String doctorId,
  }) async {
    loading.value = true;
    try {
      var _response = await DoctorsRepository()
          .getDoctorFeedback(
              cancelToken: cancelToken,
              url: '${ApiConsts.getDoctorFeedback}${doctorId}')
          .then((value) {
        feedbackData.clear();
        log("value--------------> ${value.data}");
        if (value.data['data'] != null) {
          value.data['data'].forEach((element) {
            feedbackData.add(FeedbackData.fromJson(element));
          });
        } else {
          feedbackData = [];
        }
        loading.value = false;
        log("feedbackData--------------> ${feedbackData}");

        // Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      loading.value = false;
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled)
        // throw e;
        print(e);
    }
  }
}
