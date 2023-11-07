import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/repository/DrugStoreRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../data/models/labs_model.dart';

class DrugStoreController extends TabHomeOthersController {
  TextEditingController search = TextEditingController();
  @override
  var pageController = PagingController<int, DrugStore>(firstPageKey: 1);
  var tabIndex = 0.obs;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  @override
  void onInit() {
    print('===onInit===');
    // loadData(pageController.firstPageKey);
    pageController.addPageRequestListener((pageKey) {
      print('===LISTNER===');
      loadData(pageKey);
    });
    super.onInit();
  }

  var light1 = true.obs;
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void show24HoursData() {
    List<DrugStore> hoursList = [];
    pageController.itemList.forEach((element) {
      if (element.the24Hours.contains(DateTime.now().weekday)) {
        hoursList.add(element);
      }
    });
    pageController.itemList.clear();

    update();
    pageController.appendLastPage(hoursList);
  }

  void getDrugDetails(String id) {
    DrugStoreRepository()
        .getDrugDetails(id: id, cancelToken: cancelToken)
        .then((value) {
      log("value--------------> ${value}");
    });
  }

  void searchData(int page) {
    DrugStoreRepository()
        .searchDrugStores(name: search.text, cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model
      log("data.data[data]--------------> ${data.data["data"]}");

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }

        var newItems = <DrugStore>[];
        data.data["data"].forEach((item) {
          newItems.add(DrugStore.fromJson(item));
        });
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==newItems===>${newItems.length}');
        // if (newItems == null || newItems.length == 0) {
        //   pageController.appendLastPage(newItems);
        // } else {
        pageController.appendPage(newItems, page + 1);
        locationData.clear();
        locationTitle.clear();
        pageController.itemList.forEach((element) {
          if (element.geometry.coordinates != null) {
            locationData.add(element.geometry);
            locationTitle.add(element.name);
          }
        });
        // }
      } else {}
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void loadData(int page) {
    DrugStoreRepository()
        .fetchDrugStores(page, the24HourState, cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }

        var newItems = <DrugStore>[];
        data.data["data"].forEach((item) {
          newItems.add(DrugStore.fromJson(item));
        });
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==newItems===>${newItems.length}');
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
          log("locationData--------------> ${locationData}");
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
}
