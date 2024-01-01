import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/models/labs_model.dart';

enum FetechingGPSDataStatus {
  loading,
  failed,
  success,
  idle,
}

class HospitalsController extends GetxController {
  var pageController = PagingController<int, Hospital>(firstPageKey: 1);
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
    selectedSort = 'promoted'.tr;
    _fetchAds();
    addPageListener();
    super.onInit();
  }

  addPageListener() {
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
  }

  TextEditingController search = TextEditingController();
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  // List<String> filterList = [
  //   'most_rated'.tr,
  //   'suggested'.tr,
  //   'nearest'.tr,
  //   'sponsored'.tr,
  //   'A-Z'
  // ];
  List<String> filterList = [
    'promoted'.tr,
    "best_rating".tr,
    // 'recommended'.tr,
    'nearest_hospital'.tr,
    'a-z'.tr
  ];
  String sort = "";
  String selectedSort = 'promoted'.tr;

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

  void _refreshPage() {
    cancelToken.cancel();
    cancelToken = CancelToken();

    pageController.refresh();
    pageController.value.itemList.clear();
    loadData(pageController.firstPageKey);
  }

  void changeSort(String v) {
    // if (i == selectedSort) {
    //   // Get.back();
    //   return;
    // }

    print('---->>>>>V>>>>$v');
    selectedSort = v;
    //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];

    if (v == "best_rating".tr) {
      sort = "stars";
      _refreshPage();
    }
    // else if (v == 'recommended'.tr) {
    //   sort = "suggested";
    //   _refreshPage();
    // }
    else if (v == 'nearest_hospital'.tr) {
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

  showFilterDialog() {
    log("currentSelected--------------> $selectedSort");
    List<String> filterList = [
      'promoted'.tr,
      "best_rating".tr,
      // 'recommended'.tr,
      'nearest_hospital'.tr,
      'a-z'.tr
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

                          print('----selectedSort---->>>$selectedSort');
                          Get.back();
                          changeSort(l);
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
                                textAlign: TextAlign.center,
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

  RxBool loader = false.obs;

  void loadData(int page) async {
    loader.value = true;
    // update();
    HospitalRepository.fetchHospitals(
      page: page,
      cancelToken: cancelToken,
      sort: sort,
      filterName: selectedSort,
      lat: latLang()?.latitude,
      lon: latLang()?.longitude,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e("load-hospitals", e);
      },
    ).then((data) {
      print('---->>>>data>>>>$data');

      // Utils.addResponseToPagingController<Hospital>(
      //   data,
      //   pageController,
      //   page,
      // );
      // log("pageController.itemList--------------> ${pageController.itemList}");

      var promotedItems = <Hospital>[];
      var newItems = <Hospital>[];

      if (selectedSort == 'promoted'.tr) {
        data.forEach((item) {
          if (item.active == true) {
            promotedItems.add(Hospital.fromJson(item.toJson()));
          } else {
            newItems.add(Hospital.fromJson(item.toJson()));
          }
        });

        newItems.forEach((element) {
          promotedItems.add(element);
        });
      } else {
        data.forEach((item) {
          promotedItems.add(Hospital.fromJson(item.toJson()));
        });
      }
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
      log("locationData----HOSPITAl----------> ${locationData.length}");

      loader.value = false;
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
