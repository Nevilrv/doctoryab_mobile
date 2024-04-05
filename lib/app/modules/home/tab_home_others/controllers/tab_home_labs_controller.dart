import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/LabsRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../theme/AppImages.dart';

enum FetechingGPSDataStatus {
  loading,
  failed,
  success,
  idle,
}

class LabsController extends GetxController {
  var pageController = PagingController<int, Labs>(firstPageKey: 1);

  List<String> filterList = [
    'promoted'.tr,
    "best_rating".tr,
    // 'recommended'.tr,
    'nearest_lab'.tr,
    'a-z'.tr,
  ];
  String sort = "";
  String selectedSort = "promoted".tr;
  TextEditingController search = TextEditingController();
  List<Labs> searchDataList = [];
  bool isSearching = false;
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
    _fetchAds();
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
    if (v == 'best_rating'.tr) {
      sort = "stars";

      _refreshPage();
    }
    // else if (v == 'recommended'.tr) {
    //   sort = "";
    //   _refreshPage();
    // }
    else if (v == 'nearest_lab'.tr) {
      sort = "close";
      if (latLang.value == null)
        _handlePermission();
      else {
        _refreshPage();
      }
    } else if (v == 'a-z'.tr) {
      sort = "name";
      _refreshPage();
    } else {
      sort = "";
      _refreshPage();
    }
  }

  void _refreshPage() {
    cancelToken.cancel();
    cancelToken = CancelToken();
    pageController.refresh();

    pageController.itemList.clear();
    // pageController.itemList = [];
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
      cancelToken.cancel();
      cancelToken = CancelToken();
      pageController.refresh();

      // pageController.itemList = [];
      loadData(pageController.firstPageKey);
    } catch (e) {
      EasyLoading.dismiss();

      fetechingGPSDataStatus(FetechingGPSDataStatus.failed);

      AppGetDialog.show(middleText: "failed_to_get_location_data".tr);
    }
  }

  showFilterDialog() {
    List<String> filterList = [
      'promoted'.tr,
      "best_rating".tr,
      // 'recommended'.tr,
      'nearest_lab'.tr,
      'a-z'.tr,
    ];
    selectedSort = "$selectedSort";
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
                          selectedSort = l;

                          Get.back();
                          changeSort(l);
                          print('------>>>selectedSort.>>>>>$selectedSort');

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

  void loadData(int page) {
    LabsRepository()
        .fetchLabs(
      page: page,
      cancelToken: cancelToken,
      sort: sort,
      lat: latLang()?.latitude,
      lon: latLang()?.longitude,
      filterName: selectedSort,
    )
        .then((data) {
      //TODO handle all in model

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }

        var newItems = <Labs>[];
        var promotedItems = <Labs>[];

        if (selectedSort == 'promoted'.tr) {
          data.data["data"].forEach((item) {
            if (item['active'] == true) {
              promotedItems.add(Labs.fromJson(item));
            } else {
              newItems.add(Labs.fromJson(item));
            }
          });

          newItems.forEach((element) {
            promotedItems.add(element);
          });
        } else {
          data.data["data"].forEach((item) {
            promotedItems.add(Labs.fromJson(item));
          });
        }
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==labItems===>${promotedItems.length}======$page');
        if (promotedItems == null || promotedItems.length == 0) {
          pageController.appendLastPage(promotedItems);
        } else {
          pageController.appendPage(promotedItems, page + 1);
        }

        locationData.clear();
        locationTitle.clear();
        pageController.itemList.forEach((element) {
          if (element.geometry.coordinates != null) {
            locationData.add(element.geometry);
            locationTitle.add(element.name);
          }
        });
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
        print('==labItems===>${newItems.length}======$page');
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

  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();

      if (v.data != null) {
        v.data.forEach((element) {
          adList.add(element);
          update();
        });
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) _fetchAds();
      });
    });
  }
}
