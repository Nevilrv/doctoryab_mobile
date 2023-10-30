import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/data/repository/CheckUpRepository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CheckupPackagesController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String filterSearch = "";
  CancelToken cancelToken = CancelToken();
  final List<String> selectHospitalLabList = [
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü1',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü2',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü3',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü4',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü5',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü6-',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü7'
  ];
  var selectedHospitalLab =
      "Ankara Hastanesi Laboratuvarı Kan Testi Bölümü".obs;

  final List<String> dateList = [
    "27.08.2023",
    "28.08.2023",
    "29.08.2023",
    "30.08.2023",
    "31.08.2023",
  ];
  var selectedDate = "27.08.2023".obs;
  final List<String> timeList = [
    "21:09 AM",
    "22:09 AM",
    "23:09 AM",
    "24:09 AM",
  ];
  var selectedTime = "21:09 AM".obs;
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchCheckUpPackages(pageKey);
    });
    super.onInit();
  }

  search(String s) {
    filterSearch = s;
    update();
  }

  var pagingController = PagingController<int, Package>(firstPageKey: 1);
  void fetchCheckUpPackages(int pageKey) {
    PackageRepository()
        .checkupPackages(pageKey, searchController.text,
            cancelToken: cancelToken)
        .then((data) {
      // cancelToken = new CancelToken();
      // print(10 / 0);
      //TODO handle all in model
      if (data != null) {
        if (data.data["data"] == null) {
          data.data["data"] = [];
        }
        var newItems = CheckupPackagesResModel.fromJson(data.data).data;
        log("newItems--------------> ${newItems}");

        if (newItems == null || newItems.length == 0) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        // values.addAll( City.fromJson(data.data["data"]));
        // print(data.value.success);
      } else {}
    }).catchError((e, s) {
      // cancelToken = new CancelToken();
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
