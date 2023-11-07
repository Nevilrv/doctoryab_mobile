import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/blood_donor_search_model.dart';
import 'package:doctor_yab/app/data/repository/BloodDonorRepository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/blood_donors.dart';
import '../../../utils/utils.dart';

class BloodDonorsResultsController extends GetxController {
  var pagingController = PagingController<int, BloodDonor>(firstPageKey: 1);
  //*Dio
  CancelToken cancelToken = CancelToken();
  BloodDonorSearchModel bloodDonorSearchModel;
  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchDonors(pageKey);
    });
    if (Get.arguments is BloodDonorSearchModel) {
      bloodDonorSearchModel = Get.arguments;
      log("bloodDonorSearchModel--------------> ${jsonEncode(bloodDonorSearchModel)}");
    }
  }

  @override
  void onReady() {
    if (Get.arguments is BloodDonorSearchModel) {
      bloodDonorSearchModel = Get.arguments;
    } else {
      cancelToken.cancel();
      cancelToken = new CancelToken();
      Get.back();
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchDonors(
    int pageKey,
  ) {
    BloodDonorRepository.search(pageKey, bloodDonorSearchModel,
        cancelToken: cancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      log("value--------------> ${value}");

      Utils.addResponseToPagingController<BloodDonor>(
        value,
        pagingController,
        pageKey,
      );
    });
  }
}
