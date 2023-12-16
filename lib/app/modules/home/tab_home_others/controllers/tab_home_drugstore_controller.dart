import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_feedbaxk_res_model.dart';
import 'package:doctor_yab/app/data/models/pharmacy_feedback_res_model.dart';
import 'package:doctor_yab/app/data/models/pharmacy_product_res_model.dart';
import 'package:doctor_yab/app/data/models/pharmacy_services_res_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/data/repository/DrugStoreRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/models/labs_model.dart';
import 'dart:math' as math;

enum FetechingGPSDataStatus {
  loading,
  failed,
  success,
  idle,
}

class DrugStoreController extends TabHomeOthersController {
  TextEditingController search = TextEditingController();
  @override
  var pageController = PagingController<int, DrugStore>(firstPageKey: 1);
  var tabIndex = 0.obs;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  var pharmacyId = "".obs;
  var permissionStatus = Rx<PermissionStatus>(null);

  var cRating = 0.0.obs;
  var sRating = 0.0.obs;
  var eRating = 0.0.obs;
  TextEditingController comment = TextEditingController();

  @override
  void onInit() {
    selectedSort = "promoted";
    update();
    print('===onInit===');
    // loadData(pageController.firstPageKey);

    pageController.addPageRequestListener((pageKey) {
      print('===LISTNER===');
      loadData(pageKey);
    });

    _fetchAds();
    super.onInit();
  }

  showFilterDialog() {
    log("currentSelected--------------> ${selectedSort}");
    filterList = [
      "best_rating",
      'recommended',
      'nearest_pharmacy',
      'promoted',
      'a-z'
    ];
    selectedSort = "$selectedSort";

    print('------>>>>>>>SELELELEL$selectedSort');
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Container(
            // height: Get.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      SettingsController.appLanguge != "English"
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Image.asset(
                                AppImages.filter,
                                height: 48,
                                width: 48,
                                color: AppColors.primary,
                              ),
                            )
                          : Image.asset(
                              AppImages.filter,
                              height: 48,
                              width: 48,
                              color: AppColors.primary,
                            ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "filter".tr,
                    style: AppTextStyle.boldBlack13,
                  ),

                  Text(
                    "filter_dialog_description".tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.boldBlack13
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 15),
                  Column(
                      children: filterList.map((l) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          print('-----l-----$l');

                          selectedSort = l;
                          changeSort(l);

                          Get.back();
                          update();
                        },
                        child: Container(
                          width: Get.width * 0.4,
                          decoration: BoxDecoration(
                            color: selectedSort == l
                                ? AppColors.secondary
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: Text(
                                l.tr,
                                style: AppTextStyle.boldWhite14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                  // Column(
                  //     children: LocalizationService.langs.map((l) {
                  //   return Column(
                  //     children: [
                  //       ListTile(
                  //         title: Center(child: Text(l)),
                  //         // leading: Icon(Icons.language),
                  //         onTap: () {
                  //           Get.back();
                  //
                  //           LocalizationService().changeLocale(l);
                  //           // AuthController.to.setAppLanguge(l);
                  //           SettingsController.appLanguge = l;
                  //           if (langChangedCallBack != null) langChangedCallBack(l);
                  //         },
                  //       ),
                  //       Divider(),
                  //     ],
                  //   );
                  // }).toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handlePermission() async {
    try {
      var p = await Permission.location.request();

      switch (p) {
        case PermissionStatus.denied:
          {
            AppGetDialog.show(middleText: "you_denied_request".tr);
            break;
          }
        case PermissionStatus.granted:
          {
            _getDeviceLocation();
            break;
          }
        case PermissionStatus.restricted:
          {
            //TODO urgent must be tested in iphone
            // _getDeviceLocation();
            break;
          }
        case PermissionStatus.limited:
          {
            //TODO urgent must be tested in iphone

            break;
          }
        case PermissionStatus.permanentlyDenied:
          {
            AppGetDialog.show(
                middleText:
                    "you_have_to_allow_location_permission_in_settings".tr,
                actions: <Widget>[
                  TextButton(
                    onPressed: () => openAppSettings(),
                    child: Text("open_settings".tr),
                  ),
                ]);
            break;
          }
        case PermissionStatus.provisional:
          // TODO: Handle this case.
          break;
      }
    } catch (e) {
      AppGetDialog.show(
          middleText:
              e.toString() ?? "Failed to request location permission :-(");
    }
  }

  var fetechingGPSDataStatus = Rx(FetechingGPSDataStatus.idle);
  var latLang = Rx<LocationData>(null);
  void changeSort(String v) {
    // if (i == selectedSort) {
    //   // Get.back();
    //   return;
    // }

    print('---->>>>>V>>>>$v');
    selectedSort = v;
    //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
    if (v == 'best_rating') {
      sort = "stars";

      _refreshPage();
    } else if (v == 'recommended') {
      sort = " ";
      _refreshPage();
    } else if (v == 'nearest_pharmacy') {
      sort = "";
      if (latLang.value == null)
        _handlePermission();
      else {
        _refreshPage();
      }
    } else if (v == 'a-z') {
      sort = "name";
      _refreshPage();
    } else {
      sort = "";
      _refreshPage();
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

  void _refreshPage() {
    cancelToken.cancel();
    cancelToken = CancelToken();
    pageController.itemList.clear();
    loadData(pageController.firstPageKey);
  }

  Future<void> _getDeviceLocation() async {
    fetechingGPSDataStatus(FetechingGPSDataStatus.loading);
    EasyLoading.show(status: "getting_location_from_device".tr);
    try {
      Location location = new Location();
      bool _serviceEnabled = await location.serviceEnabled();
      print("serv-enabled $_serviceEnabled");
      var locationData =
          await location.getLocation().timeout(Duration(seconds: 10));
      print("loc" + locationData.toString());

      // AuthController.to.setLastUserLocation(
      latLang.value = locationData;
      // Utils.whereShouldIGo();
      fetechingGPSDataStatus(FetechingGPSDataStatus.success);
      EasyLoading.dismiss();
      _refreshPage();
    } catch (e) {
      EasyLoading.dismiss();

      fetechingGPSDataStatus(FetechingGPSDataStatus.failed);

      AppGetDialog.show(middleText: "failed_to_get_location_data".tr);
    }
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
      }).catchError((e, s) {
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        Utils.commonSnackbar(
            context: context, text: "${e.response.data['msg']}");
        log("e------asd--------> ${e.response.data['msg']}");
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
  // List<String> filterList = [
  //   'most_rated'.tr,
  //   'suggested'.tr,
  //   'nearest'.tr,
  //   'sponsored'.tr,
  //   'A-Z'
  // ];
  List<String> filterList = [
    "best_rating",
    'recommended',
    'nearest_pharmacy',
    'promoted',
    'a-z'
  ];
  String sort = "";
  String selectedSort = "promoted";

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
      log("value--------------> $value");
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
        .fetchDrugStores(
      page: page,
      sort: sort,
      the24Hours: the24HourState,
      cancelToken: cancelToken,
      lat: latLang()?.latitude,
      lon: latLang()?.longitude,
      filterName: selectedSort,
      limitPerPage: 50,
    )
        .then((data) {
      //TODO handle all in model
      print('------->>>>$sort');
      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }

        var newItems = <DrugStore>[];

        if (selectedSort == 'promoted') {
          data.data["data"].forEach((item) {
            if (item['active'] == true) {
              newItems.add(DrugStore.fromJson(item));
            }
          });
        } else {
          data.data["data"].forEach((item) {
            newItems.add(DrugStore.fromJson(item));
          });
        }

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

  var serviceList = <Services>[].obs;
  var productList = <ProductData>[].obs;
  void serviceData(String id) {
    DrugStoreRepository()
        .fetchPharmacyService(id: id, cancelToken: cancelToken)
        .then((data) {
      serviceList.clear();
      update();
      PharmacyServicesResModel resModel =
          PharmacyServicesResModel.fromJson(data.data);
      if (resModel.data.isNotEmpty) {
        serviceList.addAll(resModel.data);
        log("serviceList--------------> ${serviceList.length}");

        update();
      } else {
        serviceList.value = [];
        update();
      }
      //TODO handle all in model

      log("data---data-----data------> ${data}");
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void productData(String id) {
    DrugStoreRepository()
        .fetchPharmacyProduct(id: id, cancelToken: cancelToken)
        .then((data) {
      productList.clear();
      update();
      PharmacyProductResModel resModel =
          PharmacyProductResModel.fromJson(data.data);
      if (resModel.data.isNotEmpty) {
        productList.addAll(resModel.data);
        log("serviceList--------------> ${productList.length}");

        update();
      } else {
        productList.value = [];
        update();
      }
      //TODO handle all in model

      log("data---data-----data------> ${data}");
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
        // "rating": sRating.toString(),
        "cleaningRating": cRating.toString(),
        "satifyRating": sRating.toString(),
        "expertiseRating": eRating.toString(),
        "labId": labId
      };
      log("data--------------> ${data}");

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
      }).catchError((e, s) {
        comment.clear();
        cRating.value = 0.0;
        eRating.value = 0.0;
        sRating.value = 0.0;
        Get.back();
        Utils.commonSnackbar(
            context: context, text: "${e.response.data['msg']}");
        log("e------asd--------> ${e.response.data['msg']}");
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

  // void _handlePermission() async {
  //   try {
  //     var p = await Permission.location.request();
  //
  //     switch (p) {
  //       case PermissionStatus.denied:
  //         {
  //           AppGetDialog.show(middleText: "you_denied_request".tr);
  //           break;
  //         }
  //       case PermissionStatus.granted:
  //         {
  //           _getDeviceLocation();
  //           break;
  //         }
  //       case PermissionStatus.restricted:
  //         {
  //           //TODO urgent must be tested in iphone
  //           // _getDeviceLocation();
  //           break;
  //         }
  //       case PermissionStatus.limited:
  //         {
  //           //TODO urgent must be tested in iphone
  //
  //           break;
  //         }
  //       case PermissionStatus.permanentlyDenied:
  //         {
  //           AppGetDialog.show(
  //               middleText:
  //                   "you_have_to_allow_location_permission_in_settings".tr,
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () => openAppSettings(),
  //                   child: Text("open_settings".tr),
  //                 ),
  //               ]);
  //           break;
  //         }
  //       case PermissionStatus.provisional:
  //         // TODO: Handle this case.
  //         break;
  //     }
  //   } catch (e) {
  //     AppGetDialog.show(
  //         middleText:
  //             e.toString() ?? "Failed to request location permission :-(");
  //   }
  // }
  //
  // var fetechingGPSDataStatus = Rx(FetechingGPSDataStatus.idle);
  // var latLang = Rx<LocationData>(null);
  // void changeSort(String v) {
  //   // if (i == selectedSort) {
  //   //   // Get.back();
  //   //   return;
  //   // }
  //
  //   print('---->>>selectedSort>>>>>$selectedSort');
  //   selectedSort = v;
  //   //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
  //   if (v == 'most_rated'.tr) {
  //     sort = "stars";
  //     _refreshPage();
  //   } else if (v == 'suggested'.tr) {
  //     sort = "";
  //     _refreshPage();
  //   } else if (v == 'nearest'.tr) {
  //     sort = "close";
  //     if (latLang.value == null)
  //       _handlePermission();
  //     else {
  //       _refreshPage();
  //     }
  //   } else if (v == 'A-Z') {
  //     sort = "name";
  //     _refreshPage();
  //   } else {
  //     sort = "";
  //     _refreshPage();
  //   }
  //   // switch (v) {
  //   //   case 'most_rated'.tr:
  //   //     {
  //   //       sort = "stars";
  //   //       _refreshPage();
  //   //       break;
  //   //     }
  //   //   case 1:
  //   //     {
  //   //       sort = "";
  //   //       _refreshPage();
  //   //       break;
  //   //     }
  //   //   case 2:
  //   //     {
  //   //       sort = "close";
  //   //       if (latLang.value == null)
  //   //         _handlePermission();
  //   //       else {
  //   //         _refreshPage();
  //   //       }
  //   //       break;
  //   //     }
  //   //   case 3:
  //   //     {
  //   //       sort = "name";
  //   //       _refreshPage();
  //   //       break;
  //   //     }
  //   //   default:
  //   //     {
  //   //       sort = "";
  //   //       _refreshPage();
  //   //     }
  //   // }
  // }
  //
  // void _refreshPage() {
  //   cancelToken.cancel();
  //   cancelToken = CancelToken();
  //   // Utils.resetPagingController(pagingController);
  //   pageController.refresh();
  //   loadData(1);
  // }
  //
  // Future<void> _getDeviceLocation() async {
  //   fetechingGPSDataStatus(FetechingGPSDataStatus.loading);
  //   EasyLoading.show(status: "getting_location_from_device".tr);
  //   try {
  //     Location location = new Location();
  //     bool _serviceEnabled = await location.serviceEnabled();
  //     print("serv-enabled $_serviceEnabled");
  //     var locationData =
  //         await location.getLocation().timeout(Duration(seconds: 10));
  //     print("loc" + locationData.toString());
  //
  //     // AuthController.to.setLastUserLocation(
  //     latLang.value = locationData;
  //     // Utils.whereShouldIGo();
  //     fetechingGPSDataStatus(FetechingGPSDataStatus.success);
  //     EasyLoading.dismiss();
  //     _refreshPage();
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //
  //     fetechingGPSDataStatus(FetechingGPSDataStatus.failed);
  //
  //     AppGetDialog.show(middleText: "failed_to_get_location_data".tr);
  //   }
  // }

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
        .fetchDrugStores(
            page: page,
            sort: sort,
            the24Hours: the24HourState,
            cancelToken: cancelToken,
            filterName: selectedSort,
            limitPerPage: 50)
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
