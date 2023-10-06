import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
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

  TabController tabController;
  var tabIndex = 0.obs;
  //*Dio
  CancelToken reviewsCancelToken = CancelToken();
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    hospital = Get.arguments;

    reviewsPagingController.addPageRequestListener((pageKey) {
      fetchReviews(pageKey);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchReviews(int pageKey) {
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
      // log("leent ${pagingController.itemList.length}");
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
