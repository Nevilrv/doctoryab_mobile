import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemeConsts {
  static double getWindowHeightInSafeArea(BuildContext context) {
    return Get.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }
}
