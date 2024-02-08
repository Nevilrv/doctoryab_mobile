import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppAppBar {
  static AppBar specialAppBar(
    String title, {
    Color backgroundColor,
    Widget leading,
    bool showLeading = true,
    PreferredSizeWidget bottom,
    // Widget action,
  }) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColors.primary, centerTitle: true,
      title: Text(
        title,
        style: AppTextTheme.m(16).copyWith(
            color: backgroundColor == AppColors.scaffoldColor
                ? Colors.black
                : AppColors.primary,
            fontWeight: FontWeight.w600),
      ).paddingHorizontal(showLeading ? 0 : 16),
      leading: showLeading
          ? leading ??
              IconButton(
                onPressed: () => Get.back(),
                icon: RotatedBox(
                  quarterTurns:
                      SettingsController.appLanguge == "English" ? 0 : 2,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                    color: backgroundColor == AppColors.scaffoldColor
                        ? Colors.black
                        : AppColors.primary,
                  ),
                ),
              )
          : null,
      // centerTitle: true,
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
        child: RotatedBox(
          quarterTurns: SettingsController.appLanguge == "English" ? 0 : 2,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.boldPrimary16,
      ),
      centerTitle: true,
      actions: [
        savedIcon
            ? GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SAVED_DRUGS);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, bottom: 5, left: 15),
                  child: Icon(
                    Icons.bookmark_border_rounded,
                    color: AppColors.primary,
                  ),
                ),
              )
            : SizedBox(),
        // Padding(
        //   padding: const EdgeInsets.only(right: 20, left: 10),
        //   child: GestureDetector(
        //     onTap: () {
        //       Get.toNamed(Routes.NOTIFICATION);
        //     },
        //     child: SvgPicture.asset(
        //       AppImages.blackBell,
        //       height: 24,
        //       width: 24,
        //     ),
        //   ),
        // ),
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
          child: RotatedBox(
            quarterTurns: SettingsController.appLanguge == "English" ? 0 : 2,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
            ),
          )),
      title: bloodIcon == false
          ? Text(
              "$title ",
              textAlign: TextAlign.center,
              style: AppTextStyle.boldWhite16,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title ",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.boldWhite16,
                ),
                Image.asset(
                  AppImages.blood1,
                  height: 17,
                  width: 17,
                )
              ],
            ),
      centerTitle: true,
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 20, left: 10),
      //     child: GestureDetector(
      //       onTap: () {
      //         Get.toNamed(Routes.NOTIFICATION);
      //       },
      //       child: SvgPicture.asset(
      //         AppImages.bellwhite,
      //         height: 24,
      //         width: 24,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }

  static AppBar blueAppBar({String title, bool bloodIcon = false}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: RotatedBox(
          quarterTurns: SettingsController.appLanguge == "English" ? 0 : 2,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
      title: bloodIcon == false
          ? Text(
              "$title ",
              textAlign: TextAlign.center,
              style: AppTextStyle.boldPrimary16,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title ",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.boldPrimary16,
                ),
                Image.asset(
                  AppImages.blood1,
                  height: 17,
                  width: 17,
                )
              ],
            ),
      centerTitle: true,
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 20, left: 10),
      //     child: GestureDetector(
      //       onTap: () {
      //         Get.toNamed(Routes.NOTIFICATION);
      //       },
      //       child: SvgPicture.asset(
      //         AppImages.blackBell,
      //         height: 24,
      //         width: 24,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
