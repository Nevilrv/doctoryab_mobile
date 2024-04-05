import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/models/hospital_detail_res_model.dart';
import 'package:doctor_yab/app/data/models/hospital_feedback_res_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/reviews_model.dart';

class HospitalNewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var reviewsCount = 0.obs;
  Hospital hospital;
  var reviewsPagingController = PagingController<int, Review>(firstPageKey: 1);
  HospitalDetailsResModel resModel;
  var doctorList = <Doctor>[].obs;
  var isLoading = false.obs;
  var isLoadingDoctor = false;
  TabController tabController;
  int tabIndex = 0;
  //*Dio
  CancelToken reviewsCancelToken = CancelToken();

  TextEditingController comment = TextEditingController();
  var feedbackData = <HospitalFeedback>[].obs;
  var loading = false.obs;
  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  void getHospitalFeedback({
    String HospitalId,
  }) async {
    loading.value = true;
    try {
      var _response = await DoctorsRepository()
          .getDoctorFeedback(
              cancelToken: reviewsCancelToken,
              url: '${ApiConsts.getHospitalFeedback}${HospitalId}')
          .then((value) {
        feedbackData.clear();

        if (value.data['data'] != null) {
          value.data['data'].forEach((element) {
            feedbackData.add(HospitalFeedback.fromJson(element));
          });
        } else {
          feedbackData.value = [];
        }
        update();
        loading.value = false;

        // Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      loading.value = false;
      await Future.delayed(Duration(seconds: 2), () {});
      if (!reviewsCancelToken.isCancelled)
        // throw e;
        print(e);
    }
  }

  void addDocFeedback({
    String hospitalId,
    BuildContext context,
  }) async {
    try {
      var data = {
        "comment": comment.text,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "hospitalId": hospitalId
      };
      var _response = await DoctorsRepository()
          .postDoctorFeedback(
              cancelToken: reviewsCancelToken,
              body: data,
              url: "${ApiConsts.postHospitalFeedback}")
          .then((value) {
        Get.back();
        getHospitalFeedback(HospitalId: hospitalId);
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;

        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      }).catchError((e, s) {
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        Utils.commonSnackbar(
            context: context, text: "${e.response.data['msg']}");
      });
      ;
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!reviewsCancelToken.isCancelled)
        addDocFeedback(hospitalId: hospitalId);
      // throw e;
      print(e);
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    hospital = Get.arguments;

    fetchHospitalDoctors();
    // reviewsPagingController.addPageRequestListener((pageKey) {
    //   fetchReviews(pageKey);
    // });

    getHospitalFeedback(HospitalId: hospital.id);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void fetchHospitalDetails() {
    isLoading.value = true;
    try {
      HospitalRepository()
          .fetchHospitalDetails(hospitalId: hospital.id)
          .then((value) {
        resModel = HospitalDetailsResModel.fromJson(value);
        isLoading.value = false;
        update();
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  void fetchHospitalDoctors() {
    isLoadingDoctor = true;
    update();
    try {
      HospitalRepository()
          .fetchHospitalDoctors(hospitalId: hospital.id)
          .then((value) {
        isLoadingDoctor = false;
        update();
        value['data'].forEach((element) {
          doctorList.add(Doctor.fromJson(element));
        });
        isLoadingDoctor = false;
        update();
      });
    } catch (e) {
      isLoadingDoctor = false;
      update();
    }
  }

  void fetchReviews(int pageKey) {
    isLoading.value = true;
    HospitalRepository()
        .fetchReviews(
      pageKey,
      hospitalId: hospital.id,
      cancelToken: reviewsCancelToken,
    )
        .then((data) {
      var newItems = ReviewsModel.fromJson(data.data).data;
      if (newItems == null || newItems.length == 0) {
        reviewsPagingController.appendLastPage(newItems);
      } else {
        reviewsPagingController.appendPage(newItems, pageKey + 1);
      }
      reviewsCount(reviewsPagingController.itemList.length);
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        reviewsPagingController.error = e;
      }
      FirebaseCrashlytics.instance.recordError(e, s);
      log(e.toString());
    });
  }

  //* show or hide some tabs
  bool showTab(int i) {
    switch (i) {
      case 0:
        return true;
      case 1:
        return ((hospital.checkUp?.length ?? 0) > 0);
      case 2:
        return true;
      case 3:
        return ((hospital?.description?.trim() ?? "") != "");

      default:
        return false;
    }
  }
}
