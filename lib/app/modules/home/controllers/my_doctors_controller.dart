import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyDoctorsController extends GetxController {
  // var arguments = Get.arguments as CategoryBridge;
  var category = BookingController.to.selectedCategory;

  String hospitalId;
  String sort = "";
  String selectedSort = "";
  List<String> filterList;

  List<Geometry> locationData = [];
  List<String> locationTitle = [];

  bool _nearByResturantsPageInitDone = false;
  Doctor selectedDoctorData;
  var pagingController = PagingController<int, Doctor>(firstPageKey: 1);

  //*Dio
  CancelToken cancelToken = CancelToken();

  // BannerAd bannerAd;
  bool isLoadAd = false;
  @override
  void onInit() {
    log("my docror-------------------->");
    // bannerAds();
    filterList = [
      'most_rated'.tr,
      'suggested'.tr,
      'nearest'.tr,
      'sponsored'.tr,
      'A-Z'
    ];
    pagingController.addPageRequestListener((pageKey) {
      fetchDoctors(pageKey);
    });
    // var dummyList = ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    category.value = null;
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

  void fetchDoctors(int pageKey) {
    DoctorsRepository()
        .fetchMyDoctors(
      cancelToken: cancelToken,
    )
        .then((data) {
      var newItems = Doctors.fromJson(data.data).data;
      print("newItems>>newItems>${newItems.length}====${pageKey}");
      if (newItems == null || newItems.length == 0) {
        pagingController.appendLastPage(newItems);
      }

      log(" pagingController.itemList.length--------------> ${pagingController.itemList.length}");
      locationData.clear();
      locationTitle.clear();
      if (pagingController.itemList.isNotEmpty) {
        pagingController.itemList.forEach((element) {
          if (element.geometry.coordinates != null) {
            locationData.add(element.geometry);
            locationTitle.add(element.name);
          }
        });
      }
      log("locationData--------------> ${locationData}");
      // log("leent ${pagingController.itemList.length}");
    }).catchError((e, s) {
      log("e--------------> ${e}");

      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
      FirebaseCrashlytics.instance.recordError(e, s);
      log(e.toString());
    });
  }
}
