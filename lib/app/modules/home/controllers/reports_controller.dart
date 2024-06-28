import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/data/repository/ReportsRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ReportsController extends GetxController {
  REPORT_TYPE? reportType;

  var pagingController = PagingController<int, Report>(firstPageKey: 1);

  CancelToken cancelToken = CancelToken();
  RxInt tabIndex = 0.obs;

  int? index;

  RxBool isTap = true.obs;

  @override
  void onInit() {
    tabIndex.value = 0;

    pagingController.addPageRequestListener((pageKey) {
      fetchReportsDoctor(pageKey);
    });

    super.onInit();


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchReportsLab(int pageKey) {
    isTap.value = false;

    ReportsRepository.fetchLabReports(
      pageKey,
      cancelToken: cancelToken,
      onError: (e) {
        if (!(e is DioError && CancelToken.isCancel(e))) {
          pagingController.error = e;
          isTap.value = true;
        }
      },
    ).then((value) {
      Utils.addResponseToPagingController<Report>(
        value,
        pagingController,
        pageKey,
      );
      isTap.value = true;
    });
  }

  void fetchReportsDoctor(int pageKey) {
    isTap.value = false;

    ReportsRepository.fetchDoctorReports(pageKey, cancelToken: cancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
        isTap.value = true;
      }
    }).then((value) {
      Utils.addResponseToPagingController<Report>(
        value,
        pagingController,
        pageKey,
      );

      isTap.value = true;
    });
  }
}
