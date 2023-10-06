import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class AppAppBar {
  static AppBar specialAppBar(String title,
      {Color backgroundColor,
      Widget leading,
      bool showLeading = true,
      PreferredSizeWidget bottom,
      Widget action}) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColors.primary, centerTitle: true,
      title: Text(
        title,
        style: AppTextTheme.m(18).copyWith(
            color: backgroundColor == AppColors.scaffoldColor
                ? Colors.black
                : AppColors.primary,
            fontWeight: FontWeight.w600),
      ).paddingHorizontal(showLeading ? 0 : 16),
      leading: showLeading
          ? leading ??
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 22,
                  color: backgroundColor == AppColors.scaffoldColor
                      ? Colors.black
                      : AppColors.primary,
                ),
              )
          : null,
      // centerTitle: true,
      actions: [action ?? Container()],
      bottom: bottom,
    );
  }
}
