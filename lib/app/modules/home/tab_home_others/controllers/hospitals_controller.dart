import 'dart:developer';

import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/labs_model.dart';

class HospitalsController extends TabHomeOthersController {
  @override
  var pageController = PagingController<int, Hospital>(firstPageKey: 1);

  @override
  void onInit() {
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
    super.onInit();
  }

  TextEditingController search = TextEditingController();
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  List<String> filterList = [
    'most_rated'.tr,
    'suggested'.tr,
    'nearest'.tr,
    'sponsored'.tr,
    'A-Z'
  ];
  String sort = "";
  String selectedSort = "";
  void changeSort(String v) {
    // if (i == selectedSort) {
    //   // Get.back();
    //   return;
    // }
    selectedSort = v;
    //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
    if (v == 'most_rated'.tr) {
      sort = "stars";
      // _refreshPage();
    } else if (v == 'suggested'.tr) {
      sort = "";
      // _refreshPage();
    } else if (v == 'nearest'.tr) {
      sort = "close";
      // if (latLang.value == null)
      //   _handlePermission();
      // else {
      //   _refreshPage();
      // }
    } else if (v == 'A-Z') {
      sort = "name";
      // _refreshPage();
    } else {
      sort = "";
      // _refreshPage();
    }
    // switch (v) {
    //   case 'most_rated'.tr:
    //     {
    //       sort = "stars";
    //       _refreshPage();
    //       break;
    //     }
    //   case 1:
    //     {
    //       sort = "";
    //       _refreshPage();
    //       break;
    //     }
    //   case 2:
    //     {
    //       sort = "close";
    //       if (latLang.value == null)
    //         _handlePermission();
    //       else {
    //         _refreshPage();
    //       }
    //       break;
    //     }
    //   case 3:
    //     {
    //       sort = "name";
    //       _refreshPage();
    //       break;
    //     }
    //   default:
    //     {
    //       sort = "";
    //       _refreshPage();
    //     }
    // }
  }

  var light1 = true.obs;
  // setEmergencyMode(bool value) {
  //   light1 = value;
  //   update();
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var isEmergencySelect = false;
  void emergencyData() {
    if (isEmergencySelect == true) {
      List<Hospital> hoursList = [];
      pageController.itemList.forEach((element) {
        if (element.isEmergency == true) {
          hoursList.add(element);
        }
      });
      pageController.itemList.clear();

      update();
      pageController.appendLastPage(hoursList);
    } else {
      pageController.itemList.clear();
      // pageController.addPageRequestListener((pageKey) {
      loadData(pageController.firstPageKey);
      // });
      update();
    }
  }

  void loadData(int page) async {
    HospitalRepository.fetchHospitals(
      page,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-hospitals",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<Hospital>(
        data,
        pageController,
        page,
      );
      log("pageController.itemList--------------> ${pageController.itemList}");

      locationData.clear();
      locationTitle.clear();
      pageController.itemList.forEach((element) {
        if (element.geometry.coordinates != null) {
          locationData.add(element.geometry);
          locationTitle.add(element.name);
        }
      });
      log("locationData--------------> ${locationData}");
    });
  }

  void searchData(int page) {
    HospitalRepository.searchHospitals(
      page,
      name: search.text,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-hospitals",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<Hospital>(
        data,
        pageController,
        page,
      );
      log("pageController.itemList--------------> ${pageController.itemList}");

      locationData.clear();
      locationTitle.clear();
      pageController.itemList.forEach((element) {
        if (element.geometry.coordinates != null) {
          locationData.add(element.geometry);
          locationTitle.add(element.name);
        }
      });
      log("locationData--------------> ${locationData}");
    });
  }
}
