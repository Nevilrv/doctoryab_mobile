import 'dart:developer';

import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PregnancyTrackerNewView extends GetView<PregnancyTrackerNewController> {
  PregnancyTrackerNewView({Key? key}) : super(key: key);

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
                  child: CircularProgressIndicator(color: AppColors.primary),
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
                              Get.offAllNamed(Routes.HOME,
                                  arguments: {'id': 2});
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.white,
                              child: Icon(
                                Icons.keyboard_arrow_left,
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
                    controller.isPregnant == false
                        ? Column(
                            children: [
                              SizedBox(
                                height: h * 0.05,
                              ),
                              Text(
                                'are_you_pregnant'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: h * 0.04,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.changeBool(true);
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.green,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(h * 0.018),
                                              child: Image.asset(
                                                AppImages.thumbsUp,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.015,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'yes'.tr,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAllNamed(Routes.HOME);
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.red,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(h * 0.018),
                                              child: RotatedBox(
                                                quarterTurns: 2,
                                                child: Image.asset(
                                                  AppImages.thumbsUp,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.015,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'no'.tr,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: h * 0.05,
                              ),
                              Container(
                                height: h * 0.35,
                                width: w * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10000),
                                  color: Color(0xffF652A0),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: h * 0.035),
                                  child: Image.asset(AppImages.pregnantWomenBg),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.05,
                                ),
                                Image.asset(
                                  AppImages.pregnantWomenBgTwo,
                                  height: h * 0.22,
                                ),
                                SizedBox(
                                  height: h * 0.05,
                                ),
                                Text(
                                  'calculation_method'.tr,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await controller.changeCalculationType(
                                        'ConceptionDate');
                                    Get.toNamed(Routes.CALCULATION_METHODS,
                                        arguments: {
                                          'type': 'ConceptionDate',
                                          'isCheck': true
                                        });
                                  },
                                  child: Container(
                                    height: h * 0.065,
                                    width: w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffE1F0DA),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, bottom: 8, top: 8),
                                          child: Image.asset(
                                              AppImages.conceptionDate),
                                        ),
                                        Text(
                                          'conception_date'.tr,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: AppColors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller
                                        .changeCalculationType('LastPeriod');
                                    Get.toNamed(Routes.CALCULATION_METHODS,
                                        arguments: {
                                          'type': 'LastPeriod',
                                          'isCheck': true
                                        });
                                  },
                                  child: Container(
                                    height: h * 0.065,
                                    width: w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    margin:
                                        EdgeInsets.only(bottom: 12, top: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffFBFADA),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, bottom: 8, top: 8),
                                          child: Image.asset(
                                              AppImages.periodsDate),
                                        ),
                                        Text(
                                          'last_period'.tr,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: AppColors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .changeCalculationType('DueDate');
                                    Get.toNamed(Routes.CALCULATION_METHODS,
                                        arguments: {
                                          'type': 'DueDate',
                                          'isCheck': true
                                        });
                                  },
                                  child: Container(
                                    height: h * 0.065,
                                    width: w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffFFDEE8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, bottom: 8, top: 8),
                                          child: Image.asset(AppImages.dueDate),
                                        ),
                                        Text(
                                          'due_date'.tr,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: AppColors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
        },
      ),
    );
  }
}
