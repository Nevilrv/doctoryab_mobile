import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PregnancyCompletion extends GetView<PregnancyTrackerNewController> {
  PregnancyCompletion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            height: h * 0.12,
            width: w,
            color: AppColors.primary,
            padding:
                EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: RotatedBox(
                      quarterTurns:
                          SettingsController.appLanguge == 'English' ? 4 : 2,
                      child: Image.asset(
                        AppImages.arrowImage,
                        color: AppColors.white,
                        height: h * 0.03,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'congratulations1'.tr,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.HOME, arguments: {'id': 2});
                  },
                  child: Icon(
                    Icons.home,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: h * 0.06),
            child: Text(
              'congratulations'.tr,
              style: TextStyle(
                  fontFamily: 'Shrikhand',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary),
            ),
          ),
          Image.asset(
            AppImages.pregnancyCompletion,
            height: h * 0.38,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.VACCINATE_BABY, arguments: true);
            },
            child: Container(
              height: h * 0.058,
              width: w * 0.3,
              margin: EdgeInsets.only(top: h * 0.04),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SettingsController.appLanguge == 'English'
                          ? w * 0.09
                          : w * 0,
                      right: SettingsController.appLanguge == 'English'
                          ? w * 0.0
                          : w * 0.09,
                    ),
                    child: Text(
                      'next'.tr,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: SettingsController.appLanguge == 'English'
                          ? w * 0.02
                          : w * 0,
                      left: SettingsController.appLanguge == 'English'
                          ? w * 0.0
                          : w * 0.02,
                    ),
                    child: RotatedBox(
                      quarterTurns:
                          SettingsController.appLanguge == 'English' ? 4 : 2,
                      child: Image.asset(
                        AppImages.arrowImage,
                        color: AppColors.white,
                        height: h * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
