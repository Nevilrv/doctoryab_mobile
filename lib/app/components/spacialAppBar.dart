import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  static AppBar primaryAppBar({String title, bool savedIcon = false}) {
    return AppBar(
      backgroundColor: AppColors.lightGrey,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.boldPrimary20,
      ),
      centerTitle: true,
      actions: [
        savedIcon
            ? GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SAVED_DRUGS);
                },
                child: Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColors.primary,
                ),
              )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: SvgPicture.asset(
            AppImages.blackBell,
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }

  static AppBar whiteAppBar({String title, bool bloodIcon = false}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.white,
        ),
      ),
      title: Text(
        "$title ${bloodIcon ? "🩸" : ""}",
        textAlign: TextAlign.center,
        style: AppTextStyle.boldWhite20,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: SvgPicture.asset(
            AppImages.blackBell,
            color: Colors.white,
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
