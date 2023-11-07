import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctor_feedback_res_model.dart';
import 'package:doctor_yab/app/data/models/doctor_full_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_feedbaxk_res_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/models/pharmacy_feedback_res_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final args = Get.arguments;
  // var doctorsLoded = false.obs;

  Doctor doctor;
  DrugStore drugStore;
  Labs labsData;
  var cancelToken = CancelToken();
  var tabIndex = 0.obs;
  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  var appBarTitle = "".obs;
  TextEditingController comment = TextEditingController();
  var feedbackData = <FeedbackData>[];
  var pharmacyFeedback = <PharmacyFeedback>[];
  var labsFeedback = <LabsFeedback>[];
  var loading = false.obs;
  @override
  void onInit() {
    if (args[0] == "Doctor_Review") {
      doctor = args[1];
      appBarTitle.value = "doctor_reviews";
      getDocFeedback(url: '${ApiConsts.getDoctorFeedback}${doctor.datumId}');
    } else if (args[0] == "Pharmacy_Review") {
      drugStore = args[1];
      log("drugStore.id--------------> ${drugStore.id}");
      appBarTitle.value = "pharmacy_reviews";
      getDocFeedback(url: '${ApiConsts.getPharmacyFeedback}${drugStore.id}');
    } else if (args[0] == "Laboratory_Review") {
      labsData = args[1];
      log("drugStore.id--------------> ${labsData.datumId}");
      appBarTitle.value = "laboratories_reviews";
      getDocFeedback(url: '${ApiConsts.getLabFeedback}${labsData.datumId}');
    }

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

  void addDocFeedback({
    BuildContext context,
  }) async {
    try {
      var data = {
        "comment": comment.text,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        args[0] == "Doctor_Review"
            ? "doctorId"
            : args[0] == "Pharmacy_Review"
                ? "pharmacyId"
                : "labId": args[0] == "Doctor_Review"
            ? doctor.datumId
            : args[0] == "Pharmacy_Review"
                ? drugStore.id
                : labsData.datumId
      };
      await DoctorsRepository()
          .postDoctorFeedback(
              body: data,
              cancelToken: cancelToken,
              url: args[0] == "Doctor_Review"
                  ? "${ApiConsts.postDoctorFeedback}"
                  : args[0] == "Pharmacy_Review"
                      ? "${ApiConsts.postPharmacyFeedback}"
                      : "${ApiConsts.postLabFeedback}")
          .then((value) {
        if (value != null) {
          if (args[0] == "Doctor_Review") {
            getDocFeedback(
                url: '${ApiConsts.getDoctorFeedback}${doctor.datumId}');
          } else if (args[0] == "Pharmacy_Review") {
            log("drugStore.id-----fs---------> ${drugStore.id}");
            getDocFeedback(
                url: '${ApiConsts.getPharmacyFeedback}${drugStore.id}');
          } else {
            getDocFeedback(
                url: '${ApiConsts.getLabFeedback}${labsData.datumId}');
          }
        }
        Get.back();
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        log("value--------------> ${value}");
        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) addDocFeedback(context: context);
      // throw e;
      print(e);
    }
  }

  void getDocFeedback({
    String url,
  }) async {
    loading.value = true;
    try {
      var _response = await DoctorsRepository()
          .getDoctorFeedback(cancelToken: cancelToken, url: url)
          .then((value) {
        if (args[0] == "Doctor_Review") {
          feedbackData.clear();
          log("value--------------> ${value.data}");
          if (value.data['data'] != null) {
            value.data['data'].forEach((element) {
              feedbackData.add(FeedbackData.fromJson(element));
            });
          } else {
            feedbackData = [];
          }
        } else if (args[0] == "Pharmacy_Review") {
          log("drugStore.id-----fs--s-------> ${drugStore.id}");
          pharmacyFeedback.clear();
          log("value--------------> ${value.data}");
          if (value.data['data'] != null) {
            value.data['data'].forEach((element) {
              pharmacyFeedback.add(PharmacyFeedback.fromJson(element));
            });
          } else {
            pharmacyFeedback = [];
          }
        } else {
          labsFeedback.clear();
          log("value--------------> ${value.data}");
          if (value.data['data'] != null) {
            value.data['data'].forEach((element) {
              labsFeedback.add(LabsFeedback.fromJson(element));
            });
          } else {
            labsFeedback = [];
          }
        }

        loading.value = false;

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
