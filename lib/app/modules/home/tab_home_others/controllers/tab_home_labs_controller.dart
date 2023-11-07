import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/repository/LabsRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class LabsController extends TabHomeOthersController {
  @override
  var pageController = PagingController<int, Labs>(firstPageKey: 1);
  List<String> filterList = [
    'most_rated'.tr,
    'suggested'.tr,
    'nearest'.tr,
    'sponsored'.tr,
    'A-Z'
  ];
  String sort = "";
  String selectedSort = "";
  TextEditingController search = TextEditingController();
  List<Labs> searchDataList = [];
  bool isSearching = false;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  @override
  void onInit() {
    pageController.addPageRequestListener((pageKey) {
      print('===LISTNER===');
      loadData(pageKey);
    });
    super.onInit();
  }

  var light1 = true.obs;
  @override
  void onReady() {
    super.onReady();
  }

  bool isSearch = false;
  void setIsSearch(bool value) {
    isSearch = value;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

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
/*
  void loadData1(int page) async {
    LabsRepository.fetchLabs(
      page,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-Labs",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<Labs>(
        data,
        pageController,
        page,
      );
    });
  }*/

  void loadData(int page) {
    log("loadData--------------->}");
    LabsRepository()
        .fetchLabs(page, the24HourState, cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }
        print('==labItems===>${data.data}');

        var newItems = <Labs>[];
        data.data["data"].forEach((item) {
          newItems.add(Labs.fromJson(item));
        });
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==labItems===>${newItems.length}======${page}');
        if (newItems == null || newItems.length == 0) {
          pageController.appendLastPage(newItems);
          locationData.clear();
          locationTitle.clear();
          pageController.itemList.forEach((element) {
            if (element.geometry.coordinates != null) {
              locationData.add(element.geometry);
              locationTitle.add(element.name);
            }
          });
        } else {
          pageController.appendPage(newItems, page + 1);
          locationData.clear();
          locationTitle.clear();
          pageController.itemList.forEach((element) {
            if (element.geometry.coordinates != null) {
              locationData.add(element.geometry);
              locationTitle.add(element.name);
            }
          });
        }
      } else {}
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void searchData(int page) {
    isSearching = true;
    update();
    LabsRepository()
        .searchLabs(name: search.text, cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model
      log("data.data[data]--------------> ${data.data["data"]}");

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }
        searchDataList.clear();
        data.data["data"].forEach((item) {
          searchDataList.add(Labs.fromJson(item));
        });
        locationData.clear();
        locationTitle.clear();
        searchDataList.forEach((element) {
          if (element.geometry.coordinates != null) {
            locationData.add(element.geometry);
            locationTitle.add(element.name);
          }
        });
        isSearching = false;
        update();
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==newItems===>${searchDataList.length}');
        // if (newItems == null || newItems.length == 0) {
        //   pageController.appendLastPage(newItems);
        // } else {

        // }
      } else {
        searchDataList = [];
      }
    }).catchError((e, s) {
      isSearching = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {
        searchDataList = [];
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void searchData1(int page) {
    LabsRepository()
        .searchLabs(name: search.text, cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }
        print('==labItems===>${data.data}');

        var newItems = <Labs>[];
        data.data["data"].forEach((item) {
          newItems.add(Labs.fromJson(item));
        });
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==labItems===>${newItems.length}======${page}');
        pageController.appendPage(newItems, page + 1);
      } else {}
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
