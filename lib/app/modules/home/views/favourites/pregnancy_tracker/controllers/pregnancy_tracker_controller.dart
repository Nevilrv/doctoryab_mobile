import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PregnancyTrackerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = TabController(length: 2, vsync: this);
  }
}
