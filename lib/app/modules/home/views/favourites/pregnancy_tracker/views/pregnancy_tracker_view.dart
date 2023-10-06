import 'package:doctor_yab/app/modules/home/views/favourites/pregnancy_tracker/controllers/pregnancy_tracker_controller.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/pregnancy_tracker/views/tab_calculator_view.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/pregnancy_tracker/views/tab_calendar_view.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PregnancyTrackerView extends GetView<PregnancyTrackerController> {
  PregnancyTrackerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<PregnancyTrackerController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomBarView(isHomeScreen: false),
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              appBar(h),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(
                          top: 48,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, top: 17, bottom: 32),
                                    child: Text(
                                      "baby_growing".tr,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.boldWhite25
                                          .copyWith(height: 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: h * 0.0605,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: -50,
                              child: Image.asset(
                                AppImages.baby1,
                                height: h * 0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller.pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            TabCalculatorView(),
                            TabCalendarView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container appBar(double h) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(20).copyWith(top: 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45, bottom: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.back2,
                        height: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "pregnancy_tracker".tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.boldWhite20,
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.blackBell,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.pageController.index = 0;
              controller.update();
            },
            child: Container(
              height: h * 0.055,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.pageController.index == 0
                    ? AppColors.white
                    : AppColors.primary,
                border: Border.all(
                  color: AppColors.white,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  "calc".tr,
                  style: controller.pageController.index == 0
                      ? AppTextStyle.boldPrimary15
                      : AppTextStyle.boldWhite15,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.pageController.index = 1;
              controller.update();
            },
            child: Container(
              height: h * 0.055,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.pageController.index == 0
                    ? AppColors.primary
                    : AppColors.white,
                border: Border.all(
                  color: AppColors.white,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  "calender".tr,
                  style: controller.pageController.index == 0
                      ? AppTextStyle.boldWhite15
                      : AppTextStyle.boldPrimary15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
