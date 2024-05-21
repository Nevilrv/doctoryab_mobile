import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
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

import '../../../data/models/labs_model.dart';

enum DOCTORS_LOAD_ACTION {
  fromCategory,
  myDoctors,
  ofhospital,
}

enum FetechingGPSDataStatus {
  loading,
  failed,
  success,
  idle,
}

class DoctorsController extends GetxController {
  // var arguments = Get.arguments as CategoryBridge;
  var category = BookingController.to.selectedCategory;
  // bool loadMyDoctorsMode;
  DOCTORS_LOAD_ACTION? action;
  String? hospitalId;
  String sort = "";
  String selectedSort = "".tr;

  List<String> filterList = [
    'promoted'.tr,
    "best_rating".tr,
    'nearest'.tr,
    'a-z'.tr
  ];
  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  //*Location
  var permissionStatus = Rxn<PermissionStatus>();
  var fetechingGPSDataStatus = Rx(FetechingGPSDataStatus.idle);
  var latLang = Rxn<LocationData>();
  Doctor? selectedDoctorData;
  var pagingController = PagingController<int, Doctor>(firstPageKey: 1);

  //*Dio
  CancelToken cancelToken = CancelToken();

  // BannerAd bannerAd;
  bool isLoadAd = false;
  @override
  void onInit() {
    selectedSort = "promoted".tr;
    update();
    // bannerAds();
    _fetchAds();
    pagingController.addPageRequestListener((pageKey) {
      fetchDoctors(pageKey);
    });

    super.onInit();
  }

  showFilterDialog() {
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
                          Get.back();
                          selectedSort = l;
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
                                l,
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    category.value = null;
  }

  void fetchDoctors(int pageKey) {
    log('latLang()?.latitude ---------->>>>>>>> ${latLang()?.latitude}');
    DoctorsRepository()
        .fetchDoctors(
      pageKey,
      cat: category.value,
      action: action,
      hospitalId: hospitalId,
      cancelToken: cancelToken,
      sort: sort,
      lat: latLang()?.latitude,
      lon: latLang()?.longitude,
      filterName: selectedSort,
    )
        .then((data) {
      var promotedItems = <Doctor>[];
      var newItems = <Doctor>[];

      log('data.data["data"] ---------->>>>>>>> ${data.data["data"]}');

      if (selectedSort == 'promoted'.tr) {
        data.data["data"].forEach((item) {
          if (item['active'] == true) {
            promotedItems.add(Doctor.fromJson(item));
          } else {
            newItems.add(Doctor.fromJson(item));
          }
        });

        newItems.forEach((element) {
          promotedItems.add(element);
        });
      } else {
        data.data["data"].forEach((item) {
          promotedItems.add(Doctor.fromJson(item));
        });
      }

      if (promotedItems.length == 0) {
        pagingController.appendLastPage(promotedItems);
      } else {
        pagingController.appendPage(promotedItems, pageKey + 1);
      }

      locationData.clear();
      locationTitle.clear();
      pagingController.itemList!.forEach((element) {
        if (element.geometry!.coordinates != null) {
          locationData.add(element.geometry!);
          locationTitle.add(element.name!);
        }
      });

      // log("leent ${pagingController.itemList.length}");
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
      FirebaseCrashlytics.instance.recordError(e, s);
      log(e.toString());
    });
  }

  void changeSort(String v) {
    // if (i == selectedSort) {
    //   // Get.back();
    //   return;
    // }

    print('---->>>>>V>>>>----$v');
    selectedSort = v;
    //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
    if (v == "best_rating".tr) {
      sort = "stars";
      _refreshPage();
    }
    // else if (v == 'recommended'.tr) {
    //   sort = "";
    //   _refreshPage();
    // }
    else if (v == 'nearest'.tr) {
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

  void _refreshPage() {
    cancelToken.cancel();
    cancelToken = CancelToken();
    // Utils.resetPagingController(pagingController);
    pagingController.refresh();
    pagingController.itemList?.clear();
    fetchDoctors(pagingController.firstPageKey);
    update();
    // fetchDoctors(1);
  }

  Future<void> _getDeviceLocation() async {
    fetechingGPSDataStatus(FetechingGPSDataStatus.loading);
    EasyLoading.show(status: "getting_location_from_device".tr);
    try {
      Location location = new Location();
      bool _serviceEnabled = await location.serviceEnabled();

      var locationData = await location.getLocation();

      // AuthController.to.setLastUserLocation(
      latLang.value = locationData;
      // Utils.whereShouldIGo();
      fetechingGPSDataStatus(FetechingGPSDataStatus.success);
      EasyLoading.dismiss();
      cancelToken.cancel();
      cancelToken = CancelToken();
      // Utils.resetPagingController(pagingController);
      pagingController.refresh();
      fetchDoctors(
        pagingController.firstPageKey,
      );
      // _refreshPage();
    } catch (e) {
      log('----E_---__--E-e---$e');
      EasyLoading.dismiss();
      fetechingGPSDataStatus(FetechingGPSDataStatus.failed);
      AppGetDialog.show(middleText: "failed_to_get_location_data".tr);
    }
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
              ],
            );
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

  // bannerAds() {
  //   bannerAd = BannerAd(
  //       size: AdSize(height: (100).round(), width: Get.width.round()),
  //       // size: AdSize.banner,
  //       adUnitId: Utils.bannerAdId,
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           isLoadAd = true;
  //           update();
  //           log('Banner Ad Loaded...');
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           log('Banner Ad failed...');
  //           ad.dispose();
  //         },
  //       ),
  //       request: AdRequest());
  //   return bannerAd.load();
  // }
  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();

      if (v.data != null) {
        v.data!.forEach((element) {
          adList.add(element);
          update();
        });
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {});
    });
  }
}
