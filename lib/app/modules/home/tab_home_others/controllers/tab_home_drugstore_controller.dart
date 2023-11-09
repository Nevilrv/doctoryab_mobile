import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_feedbaxk_res_model.dart';
import 'package:doctor_yab/app/data/models/pharmacy_feedback_res_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/data/repository/DrugStoreRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/labs_model.dart';

class DrugStoreController extends TabHomeOthersController {
  TextEditingController search = TextEditingController();
  @override
  var pageController = PagingController<int, DrugStore>(firstPageKey: 1);
  var tabIndex = 0.obs;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  var pharmacyId = "".obs;

  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  TextEditingController comment = TextEditingController();

  @override
  void onInit() {
    print('===onInit===');
    // loadData(pageController.firstPageKey);

    pageController.addPageRequestListener((pageKey) {
      print('===LISTNER===');
      loadData(pageKey);
    });

    _fetchAds();
    super.onInit();
  }

  void addDocFeedback({
    String pharmacyId,
    BuildContext context,
  }) async {
    try {
      var data = {
        "comment": comment.text,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "pharmacyId": pharmacyId
      };
      var _response = await DoctorsRepository()
          .postDoctorFeedback(
              cancelToken: cancelToken,
              body: data,
              url: "${ApiConsts.postPharmacyFeedback}")
          .then((value) {
        Get.back();
        getDocFeedback(pharmacyId: pharmacyId);
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        log("value--------------> ${value}");
        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) addDocFeedback(pharmacyId: pharmacyId);
      // throw e;
      print(e);
    }
  }

  var feedbackData = <PharmacyFeedback>[];
  var loading = false.obs;
  void getDocFeedback({
    String pharmacyId,
  }) async {
    loading.value = true;
    try {
      var _response = await DoctorsRepository()
          .getDoctorFeedback(
              cancelToken: cancelToken,
              url: '${ApiConsts.getPharmacyFeedback}${pharmacyId}')
          .then((value) {
        feedbackData.clear();
        log("value--------------> ${value.data}");
        if (value.data['data'] != null) {
          value.data['data'].forEach((element) {
            feedbackData.add(PharmacyFeedback.fromJson(element));
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
      log("e--------------> ${e}");
    }
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

  bool is24HourSelected = false;
  void show24HoursData() {
    if (is24HourSelected == true) {
      List<DrugStore> hoursList = [];
      pageController.itemList.forEach((element) {
        if (element.the24Hours.contains(DateTime.now().weekday)) {
          hoursList.add(element);
        }
      });
      pageController.itemList.clear();

      update();
      pageController.appendLastPage(hoursList);
    } else {
      pageController.itemList.clear();

      loadData(pageController.firstPageKey);
      update();
    }
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

  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();
      log("v.data--------------> ${v.data}");

      if (v.data != null) {
        v.data.forEach((element) {
          adList.add(element);
          update();
          log("adList--------------> ${adList.length}");
        });
      }
    }).catchError((e, s) {
      log("e--------------> ${e}");

      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) _fetchAds();
      });
    });
  }
}

class DrugStoreLabController extends TabHomeOthersController {
  TextEditingController search = TextEditingController();
  @override
  var pageController = PagingController<int, DrugStore>(firstPageKey: 1);
  var tabIndex = 0.obs;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  var pharmacyId = "".obs;

  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  TextEditingController comment = TextEditingController();

  @override
  void onInit() {
    print('===onInit===');
    // loadData(pageController.firstPageKey);

    pageController.addPageRequestListener((pageKey) {
      print('===LISTNER===');
      loadData(pageKey);
    });

    _fetchAds();
    super.onInit();
  }

  void addDocFeedback({
    String labId,
    BuildContext context,
  }) async {
    try {
      var data = {
        "comment": comment.text,
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "labId": labId
      };
      var _response = await DoctorsRepository()
          .postDoctorFeedback(
              cancelToken: cancelToken,
              body: data,
              url: "${ApiConsts.postLabFeedback}")
          .then((value) {
        Get.back();
        getDocFeedback(labId: labId);
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        log("value--------------> ${value}");
        Utils.commonSnackbar(context: context, text: "review_successfully".tr);
      });
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) addDocFeedback(labId: labId);
      // throw e;
      print(e);
    }
  }

  var feedbackData = <LabsFeedback>[];
  var loading = false.obs;
  void getDocFeedback({
    String labId,
  }) async {
    loading.value = true;
    try {
      var _response = await DoctorsRepository()
          .getDoctorFeedback(
              cancelToken: cancelToken,
              url: '${ApiConsts.getLabFeedback}${labId}')
          .then((value) {
        feedbackData.clear();
        log("value--------------> ${value.data}");
        if (value.data['data'] != null) {
          value.data['data'].forEach((element) {
            feedbackData.add(LabsFeedback.fromJson(element));
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
      log("e--------------> ${e}");
    }
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

  bool is24HourSelected = false;
  void show24HoursData() {
    if (is24HourSelected == true) {
      List<DrugStore> hoursList = [];
      pageController.itemList.forEach((element) {
        if (element.the24Hours.contains(DateTime.now().weekday)) {
          hoursList.add(element);
        }
      });
      pageController.itemList.clear();

      update();
      pageController.appendLastPage(hoursList);
    } else {
      pageController.itemList.clear();

      loadData(pageController.firstPageKey);
      update();
    }
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

  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();
      log("v.data--------------> ${v.data}");

      if (v.data != null) {
        v.data.forEach((element) {
          adList.add(element);
          update();
          log("adList--------------> ${adList.length}");
        });
      }
    }).catchError((e, s) {
      log("e--------------> ${e}");

      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) _fetchAds();
      });
    });
  }
}
