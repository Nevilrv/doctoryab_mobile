import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart' hide PermissionStatus;
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
  DOCTORS_LOAD_ACTION action;
  String hospitalId;
  String sort = "";
  String selectedSort = "";
  List<String> filterList;

  List<Geometry> locationData = [];
  List<String> locationTitle = [];
  //*Location
  var permissionStatus = Rx<PermissionStatus>(null);
  var fetechingGPSDataStatus = Rx(FetechingGPSDataStatus.idle);
  var latLang = Rx<LocationData>(null);
  bool _nearByResturantsPageInitDone = false;
  Doctor selectedDoctorData;
  var pagingController = PagingController<int, Doctor>(firstPageKey: 1);

  //*Dio
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
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

  void fetchDoctors(int pageKey) {
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
    )
        .then((data) {
      var newItems = Doctors.fromJson(data.data).data;
      print("newItems>>newItems>${newItems.length}====${pageKey}");
      if (newItems == null || newItems.length == 0) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }

      log(" pagingController.itemList.length--------------> ${pagingController.itemList.length}");
      locationData.clear();
      locationTitle.clear();
      pagingController.itemList.forEach((element) {
        if (element.geometry.coordinates != null) {
          locationData.add(element.geometry);
          locationTitle.add(element.name);
        }
      });
      log("locationData--------------> ${locationData}");
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
    selectedSort = v;
    //  ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
    if (v == 'most_rated'.tr) {
      sort = "stars";
      _refreshPage();
    } else if (v == 'suggested'.tr) {
      sort = "";
      _refreshPage();
    } else if (v == 'nearest'.tr) {
      sort = "close";
      if (latLang.value == null)
        _handlePermission();
      else {
        _refreshPage();
      }
    } else if (v == 'A-Z') {
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
    // fetchDoctors(1);
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
      }
    } catch (e) {
      AppGetDialog.show(
          middleText:
              e.toString() ?? "Failed to request location permission :-(");
    }
  }
}
