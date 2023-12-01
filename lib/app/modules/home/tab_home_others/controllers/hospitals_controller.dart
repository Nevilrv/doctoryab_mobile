import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/labs_model.dart';
import 'dart:math' as math;

class HospitalsController extends GetxController {
  @override
  var pageController = PagingController<int, Hospital>(firstPageKey: 1);
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
    selectedSort = "promoted";
    update();
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
    _fetchAds();
    super.onInit();
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
    "best_rating",
    'recommended',
    'nearest_hospital',
    'promoted',
    'a-z'
  ];
  String sort = "";
  String selectedSort = "promoted";
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

  showFilterDialog() {
    log("currentSelected--------------> ${selectedSort}");
    filterList = [
      "best_rating",
      'recommended',
      'nearest_hospital',
      'promoted',
      'a-z'
    ];
    selectedSort = "${selectedSort}";
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
