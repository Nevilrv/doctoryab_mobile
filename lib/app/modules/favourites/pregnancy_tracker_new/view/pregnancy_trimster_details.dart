import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PregnancyTrimster extends GetView<PregnancyTrackerNewController> {
  PregnancyTrimster({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: GetBuilder<PregnancyTrackerNewController>(
        builder: (controller) {
          return controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: h * 0.12,
                      width: w,
                      color: AppColors.primary,
                      padding: EdgeInsets.only(
                          left: w * 0.04, right: w * 0.04, top: h * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.white,
                              child: Icon(
                                SettingsController.appLanguge == 'English'
                                    ? Icons.keyboard_arrow_left
                                    : Icons.keyboard_arrow_right,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'pregnancy_tracker'.tr,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.08,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.02,
                            ),

                            /// SLIDER
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                RotatedBox(
                                  quarterTurns:
                                      SettingsController.appLanguge == 'English'
                                          ? 2
                                          : 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.weekCount > 0) {
                                        controller.decrementTrimster();
                                      }
                                    },
                                    child: Image.asset(
                                      AppImages.arrowImage,
                                      height: h * 0.036,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.048),
                                  child: new LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 108,
                                    animation: true,
                                    lineHeight: h * 0.05,
                                    animationDuration: 2500,
                                    percent: (controller
                                            .pregnancyData
                                            .ptModules[controller.weekCount]
                                            .week /
                                        39),
                                    center: Text(
                                      "${'week'.tr}: ${controller.pregnancyData.ptModules[controller.weekCount].week}",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff00BF63),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller
                                            .pregnancyData
                                            .ptModules[controller.weekCount]
                                            .week ==
                                        39) {
                                      Get.toNamed(Routes.PREGNANCY_COMPLETION);
                                    }

                                    if (controller.weekCount <
                                        controller.pregnancyData.ptModules
                                                .length -
                                            1) {
                                      controller.incrementTrimster();
                                    }
                                  },
                                  child: RotatedBox(
                                    quarterTurns:
                                        SettingsController.appLanguge ==
                                                'English'
                                            ? 4
                                            : 2,
                                    child: Image.asset(AppImages.arrowImage,
                                        height: h * 0.036),
                                  ),
                                ),
                              ],
                            ),

                            /// Week Wise Data

                            Container(
                              width: w,
                              // height: h * 0.4,
                              margin: EdgeInsets.symmetric(
                                  horizontal: w * 0.04, vertical: h * 0.03),
                              decoration: BoxDecoration(
                                color: (controller
                                                .pregnancyData
                                                .ptModules[controller.weekCount]
                                                .week >
                                            0 &&
                                        controller
                                                .pregnancyData
                                                .ptModules[controller.weekCount]
                                                .week <
                                            13)
                                    ? Color(0xffE1F0DA)
                                    : (controller
                                                    .pregnancyData
                                                    .ptModules[
                                                        controller.weekCount]
                                                    .week >
                                                12 &&
                                            controller
                                                    .pregnancyData
                                                    .ptModules[
                                                        controller.weekCount]
                                                    .week <
                                                28)
                                        ? Color(0xffF2E5FF)
                                        : Color(0xffFFDEE8),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: h * 0.015),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.06),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'conception_date'.tr,
                                              style: TextStyle(
                                                color: Color(0xffFF4181),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${DateFormat('EE, dd MMM yyyy').format(DateTime.parse(controller.pregnancyData.conceptionDate))}',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: h * 0.06,
                                          width: 2,
                                          color: AppColors.white,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'due_date'.tr,
                                              style: TextStyle(
                                                color: Color(0xffFF4181),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${DateFormat('EE, dd MMM yyyy').format(DateTime.parse(controller.pregnancyData.dueDate))}',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.025,
                                      vertical: h * 0.035,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                            ApiConsts.hostUrl +
                                                controller
                                                    .pregnancyData
                                                    .ptModules[
                                                        controller.weekCount]
                                                    .img,
                                            height: h * 0.21),
                                        SizedBox(
                                          width: w * 0.03,
                                        ),
                                        new CircularPercentIndicator(
                                          radius: h * 0.185,
                                          lineWidth: w * 0.038,
                                          animation: true,
                                          percent: controller
                                                  .pregnancyData
                                                  .ptModules[
                                                      controller.weekCount]
                                                  .week /
                                              39,
                                          center: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${controller.pregnancyData.ptModules[controller.weekCount].trimister} Trimster',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Divider(
                                                indent: w * 0.12,
                                                endIndent: w * 0.12,
                                                thickness: 1,
                                                color: Color(0xff737373),
                                              ),
                                              Text(
                                                '0 ${'days_left'.tr}',
                                              )
                                            ],
                                          ),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: AppColors.primary,
                                          backgroundColor: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: h * 0.07,
                                    width: w,
                                    decoration: BoxDecoration(
                                      color: (controller
                                                      .pregnancyData
                                                      .ptModules[
                                                          controller.weekCount]
                                                      .week >
                                                  0 &&
                                              controller
                                                      .pregnancyData
                                                      .ptModules[
                                                          controller.weekCount]
                                                      .week <
                                                  13)
                                          ? Color(0xff80CBC4)
                                          : (controller
                                                          .pregnancyData
                                                          .ptModules[controller
                                                              .weekCount]
                                                          .week >
                                                      12 &&
                                                  controller
                                                          .pregnancyData
                                                          .ptModules[controller
                                                              .weekCount]
                                                          .week <
                                                      28)
                                              ? Color(0xffBC92FF)
                                              : Color(0xffFFA4A4),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(16)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 0.08),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('size'.tr),
                                              Text(
                                                SettingsController.appLanguge ==
                                                        'English'
                                                    ? controller
                                                            .pregnancyData
                                                            .ptModules[controller
                                                                .weekCount]
                                                            .sizeEnglish ??
                                                        "None"
                                                    : SettingsController
                                                                .appLanguge ==
                                                            'پشتو'
                                                        ? controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .sizePashto ??
                                                            "None"
                                                        : controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .sizeDari ??
                                                            "None",
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: h * 0.055,
                                            width: 2,
                                            color: AppColors.white,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('weight'.tr),
                                              Text(
                                                SettingsController.appLanguge ==
                                                        'English'
                                                    ? controller
                                                            .pregnancyData
                                                            .ptModules[controller
                                                                .weekCount]
                                                            .weightEnglish ??
                                                        "None"
                                                    : SettingsController
                                                                .appLanguge ==
                                                            'پشتو'
                                                        ? controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .weightPashto ??
                                                            "None"
                                                        : controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .weightDari ??
                                                            "None",
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: h * 0.055,
                                            width: 2,
                                            color: AppColors.white,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('length'.tr),
                                              Text(
                                                SettingsController.appLanguge ==
                                                        'English'
                                                    ? controller
                                                            .pregnancyData
                                                            .ptModules[controller
                                                                .weekCount]
                                                            .lengthEnglish ??
                                                        "None"
                                                    : SettingsController
                                                                .appLanguge ==
                                                            'پشتو'
                                                        ? controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .lengthPashto ??
                                                            "None"
                                                        : controller
                                                                .pregnancyData
                                                                .ptModules[
                                                                    controller
                                                                        .weekCount]
                                                                .lengthDari ??
                                                            "None",
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Center(
                              child: Text(
                                'at_this_week'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.05),
                              child: Html(
                                data: SettingsController.appLanguge == 'English'
                                    ? "${controller.pregnancyData.ptModules[controller.weekCount].weekInfoEnglish}"
                                    : SettingsController.appLanguge == 'پشتو'
                                        ? "${controller.pregnancyData.ptModules[controller.weekCount].weekInfoPashto}"
                                        : "${controller.pregnancyData.ptModules[controller.weekCount].weekInfoDari}",
                                customTextAlign: (_) =>
                                    SettingsController.appLanguge == "English"
                                        ? TextAlign.left
                                        : TextAlign.right,
                                onImageError: (exception, stackTrace) {
                                  return Image.network(
                                      "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
