import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PregnancyTrimster extends GetView<PregnancyTrackerNewController> {
  PregnancyTrimster({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: GetBuilder<PregnancyTrackerNewController>(
          builder: (controller) {
            return Column(
              children: [
                Container(
                  height: h * 0.1,
                  width: w,
                  color: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Icons.keyboard_arrow_left,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Pregnancy Tracker',
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
                SizedBox(
                  height: h * 0.015,
                ),

                /// SLIDER
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: GestureDetector(
                        onTap: () {
                          if (controller.weekCount > 1) {
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
                      padding: EdgeInsets.symmetric(horizontal: w * 0.048),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 108,
                        animation: true,
                        lineHeight: h * 0.05,
                        animationDuration: 2500,
                        percent: (controller.weekCount / 39),
                        center: Text(
                          "Week: ${controller.weekCount}",
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
                        if (controller.weekCount < 39) {
                          controller.incrementTrimster();
                        }
                      },
                      child:
                          Image.asset(AppImages.arrowImage, height: h * 0.036),
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
                    color:
                        (controller.weekCount > 0 && controller.weekCount < 13)
                            ? Color(0xffE1F0DA)
                            : (controller.weekCount > 12 &&
                                    controller.weekCount < 28)
                                ? Color(0xffF2E5FF)
                                : Color(0xffFFDEE8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.015,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Conception Date',
                                  style: TextStyle(
                                    color: Color(0xffFF4181),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Fri, 15 Dec 2023',
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
                                  'Due Date',
                                  style: TextStyle(
                                    color: Color(0xffFF4181),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Fri, 06 Sep 2024',
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
                            Image.asset(
                                (controller.weekCount > 0 &&
                                        controller.weekCount < 13)
                                    ? AppImages.trimster1
                                    : (controller.weekCount > 12 &&
                                            controller.weekCount < 28)
                                        ? AppImages.trimster2
                                        : AppImages.trimster3,
                                height: h * 0.21),
                            SizedBox(
                              width: w * 0.03,
                            ),
                            new CircularPercentIndicator(
                              radius: h * 0.185,
                              lineWidth: w * 0.038,
                              animation: true,
                              percent: controller.weekCount / 39,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (controller.weekCount > 0 &&
                                            controller.weekCount < 13)
                                        ? '1st Trimster'
                                        : (controller.weekCount > 12 &&
                                                controller.weekCount < 28)
                                            ? '2nd Trimster'
                                            : '3rd Trimster',
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
                                    (controller.weekCount > 0 &&
                                            controller.weekCount < 13)
                                        ? '217 Days left'
                                        : (controller.weekCount > 12 &&
                                                controller.weekCount < 28)
                                            ? '129 Days left'
                                            : '35 Days left',
                                  )
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
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
                          color: (controller.weekCount > 0 &&
                                  controller.weekCount < 13)
                              ? Color(0xff80CBC4)
                              : (controller.weekCount > 12 &&
                                      controller.weekCount < 28)
                                  ? Color(0xffBC92FF)
                                  : Color(0xffFFA4A4),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Size'),
                                  Text(
                                    (controller.weekCount > 0 &&
                                            controller.weekCount < 13)
                                        ? 'Cherry'
                                        : (controller.weekCount > 12 &&
                                                controller.weekCount < 28)
                                            ? 'Corn'
                                            : 'Pineapple',
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Weight'),
                                  Text(
                                    (controller.weekCount > 0 &&
                                            controller.weekCount < 13)
                                        ? '30 gr'
                                        : (controller.weekCount > 12 &&
                                                controller.weekCount < 28)
                                            ? '0.4 kg'
                                            : '2.5 kg',
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Length'),
                                  Text(
                                    (controller.weekCount > 0 &&
                                            controller.weekCount < 13)
                                        ? '4 cm'
                                        : (controller.weekCount > 12 &&
                                                controller.weekCount < 28)
                                            ? '15 cm'
                                            : '45 cm',
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
                    'At this week!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
