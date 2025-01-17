import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/repository/StoriesRepository.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/home_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_doctors_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/hospitals_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_labs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../data/models/ads_model.dart';
import '../../../routes/app_pages.dart';

class TabHomeMainController extends GetxController {
  var selectedCity = City().obs;

  //ads model is same as story
  var dataList = Rxn<AdsModel>(null);
  TextEditingController searchDoctor = TextEditingController();

  //stories
  @override
  void onInit() {
    selectedCity.value = SettingsController.auth.savedCity!;
    super.onInit();
  }

  var isHomeScreen = true.obs;

  @override
  void onReady() {
    super.onReady();
    _fetchStories();
  }

  @override
  void onClose() {}

  cityChanged(City city) {
    selectedCity(city);
    // pagingController.refresh();
    // Get.reset(clearFactory: false);
    // Utils.whereShouldIGo();
    try {
      Get.find<TabTabHomeController>().pagingController.refresh();
    } catch (e, s) {
      Logger().e("city-change-refresh", e, s);
    }
    try {
      Get.find<HospitalsController>().pageController.refresh();
    } catch (e, s) {
      Logger().e("city-change-refresh", e, s);
    }
    try {
      Get.find<DrugStoreController>().pageController!.refresh();
    } catch (e, s) {
      Logger().e("city-change-refresh", e, s);
    }
    try {
      Get.find<LabsController>().pageController.refresh();
    } catch (e, s) {
      Logger().e("city-change-refresh", e, s);
    }
    Get.find<HomeController>().pageController!.animateTo(0);
  }

  void _fetchStories() {
    StoriesRepository.fetchAds().then((v) {
      log("Ad Response ::::::::::::: ${v.data?.length}");
      log("Ad Response ::::::::::::: ${v.data}");

      // AdsModel v = AdsModel();
      if (v.data == null) {
        v.data = <Ad>[Ad()];
      }
      // var _tmp = v.data.where((element) => true).toList();
      // // _tmp.data.addAll(v.data.where((element) => true));
      // _tmp.addAll(v.data);
      // _tmp.addAll(v.data);
      // v.data.addAll(_tmp);
      dataList.value = v;
      // dataList.update((val) => v);
    }).catchError((e, s) {
      Logger().e("Error loading stories: ", e, s);
      Future.delayed(Duration(seconds: 3), () {
        _fetchStories();
      });
    });
  }

  void onTapStoryAvatar(int index) async {
    // stories.removeWhere((s) => s.userImage == storyArg.userImage);
    // storyArg.isActive = false;
    // stories.add(storyArg);
    // stories.refresh();
    Get.toNamed(Routes.APP_STORY, arguments: [index, dataList.value]);
  }

  resetStrories() {
    dataList.value = null;
    Future.delayed(Duration(seconds: 3), () {
      //

      _fetchStories();
    });
  }
}
