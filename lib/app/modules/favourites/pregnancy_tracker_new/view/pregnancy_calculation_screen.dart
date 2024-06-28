import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PregnancyCalculation extends GetView<PregnancyTrackerNewController> {
  PregnancyCalculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: GetBuilder<PregnancyTrackerNewController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.12,
                width: w,
                color: AppColors.primary,
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.04),
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
                          Icons.arrow_back_ios_new,
                          color: AppColors.primary,
                          size: 20,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: h * 0.025),
                child: Center(
                  child: Text(
                    'pregnancy_calculator'.tr,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              controller.type == 'ConceptionDate'
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 12, bottom: 8, top: 10, right: 10),
                                  child: Image.asset(
                                    AppImages.conceptionDate,
                                    height: h * 0.05,
                                  ),
                                ),
                                Text(
                                  'conception_date'.tr,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'whats_your_conception_date'.tr,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.formattedConceptionDate}',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SettingsController.appLanguge == 'English'
                                    ? GestureDetector(
                                        onTap: () {
                                          controller
                                              .showDatePicker(
                                            initialDate: controller.conceptionInitialDay,
                                            lastDate: DateTime.now(),
                                            firstDate: DateTime.now().subtract(Duration(days: 266)),
                                            context: context,
                                          )
                                              .then((selectedDate) {
                                            if (selectedDate != null) {
                                              controller.conceptionInitialDay = selectedDate;

                                              controller.formattedConceptionDate = SettingsController.appLanguge == 'English'
                                                  ? DateFormat('dd-MM-yyyy').format(selectedDate)
                                                  : '${selectedDate.toJalali().formatter.wN}, ${selectedDate.toJalali().formatter.d}-${selectedDate.toJalali().formatter.mm}-${selectedDate.toJalali().formatter.yyyy}';

                                              controller.update();
                                            }
                                          });
                                        },
                                        child: Image.asset(
                                          AppImages.calender,
                                          height: 25,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          Jalali? picked = await showPersianDatePicker(
                                              context: context,
                                              initialDate: Jalali.now(),
                                              firstDate: Jalali.fromDateTime(DateTime.now().subtract(Duration(days: 266))),
                                              lastDate: Jalali.now(),
                                              initialEntryMode: PDatePickerEntryMode.calendarOnly,
                                              initialDatePickerMode: PDatePickerMode.day,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: ThemeData(
                                                    colorScheme: ColorScheme.light(
                                                      primary: AppColors.primary,
                                                      onPrimary: Colors.white,
                                                      surface: AppColors.primary,
                                                      onSurface: AppColors.black,
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              });
                                          if (picked != null) {
                                            Gregorian gregorianDate = picked.toGregorian();

                                            DateTime gregorianDateTime =
                                                DateTime(gregorianDate.year, gregorianDate.month, gregorianDate.day);
                                            controller.conceptionInitialDay = gregorianDateTime;

                                            controller.formattedConceptionDate = '${picked.year}-${picked.month}-${picked.day}';
                                            controller.update();
                                          }
                                        },
                                        child: Image.asset(
                                          AppImages.calender,
                                          height: 25,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : controller.type == 'LastPeriod'
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12, bottom: 8, top: 10, right: 10),
                                      child: Image.asset(
                                        AppImages.periodsDate,
                                        height: h * 0.05,
                                      ),
                                    ),
                                    Text(
                                      'last_period'.tr,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${controller.formattedPregnancyDate}',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SettingsController.appLanguge == 'English'
                                        ? GestureDetector(
                                            onTap: () {
                                              controller
                                                  .showDatePicker(
                                                initialDate: controller.pregnancyInitialDay,
                                                lastDate: DateTime.now(),
                                                firstDate: DateTime.now().subtract(Duration(days: 266)),
                                                context: context,
                                              )
                                                  .then((selectedDate) {
                                                if (selectedDate != null) {
                                                  controller.pregnancyInitialDay = selectedDate;

                                                  controller.formattedPregnancyDate = SettingsController.appLanguge == 'English'
                                                      ? DateFormat('dd-MM-yyyy').format(selectedDate)
                                                      : '${selectedDate.toJalali().formatter.wN}, ${selectedDate.toJalali().formatter.d}-${selectedDate.toJalali().formatter.mm}-${selectedDate.toJalali().formatter.yyyy}';

                                                  controller.update();
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                              AppImages.calender,
                                              height: 25,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              Jalali? picked = await showPersianDatePicker(
                                                  context: context,
                                                  initialDate: Jalali.now(),
                                                  firstDate: Jalali.fromDateTime(DateTime.now().subtract(Duration(days: 266))),
                                                  lastDate: Jalali.now(),
                                                  initialEntryMode: PDatePickerEntryMode.calendarOnly,
                                                  initialDatePickerMode: PDatePickerMode.day,
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: ThemeData(
                                                        colorScheme: ColorScheme.light(
                                                          primary: AppColors.primary,
                                                          onPrimary: Colors.white,
                                                          surface: AppColors.primary,
                                                          onSurface: AppColors.black,
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  });
                                              if (picked != null) {
                                                Gregorian gregorianDate = picked.toGregorian();

                                                DateTime gregorianDateTime =
                                                    DateTime(gregorianDate.year, gregorianDate.month, gregorianDate.day);
                                                controller.pregnancyInitialDay = gregorianDateTime;

                                                controller.formattedPregnancyDate = '${picked.year}-${picked.month}-${picked.day}';
                                                controller.update();
                                              }
                                            },
                                            child: Image.asset(
                                              AppImages.calender,
                                              height: 25,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 12),
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 15, vertical: 13),
                              //   decoration: BoxDecoration(
                              //     color: AppColors.white,
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //         height: 20,
                              //         width: 20,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(4),
                              //           border: Border.all(
                              //               color: AppColors.red, width: 2),
                              //         ),
                              //         child: Center(
                              //           child: Container(
                              //               height: 1.5,
                              //               width: 10,
                              //               color: AppColors.red),
                              //         ),
                              //       ),
                              //       Text(
                              //         '28',
                              //         style: TextStyle(
                              //           color: AppColors.primary,
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 20,
                              //         width: 20,
                              //         alignment: Alignment.center,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(4),
                              //           border: Border.all(
                              //               color: AppColors.red, width: 2),
                              //         ),
                              //         child: Center(
                              //           child: Icon(
                              //             Icons.add,
                              //             size: 14,
                              //             color: AppColors.red,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      : controller.type == 'DueDate'
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 12, bottom: 8, top: 10, right: 20),
                                          child: Image.asset(
                                            AppImages.dueDate,
                                            height: h * 0.05,
                                          ),
                                        ),
                                        Text(
                                          'due_date'.tr,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'whats_your_due_date'.tr,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.formattedDueDate,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SettingsController.appLanguge == 'English'
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .showDatePicker(
                                                    initialDate: controller.dueInitialDay,
                                                    lastDate: DateTime.now().add(Duration(days: 300)),
                                                    firstDate: DateTime.now(),
                                                    context: context,
                                                  )
                                                      .then((selectedDate) {
                                                    if (selectedDate != null) {
                                                      controller.dueInitialDay = selectedDate;

                                                      controller.formattedDueDate = SettingsController.appLanguge == 'English'
                                                          ? DateFormat('dd-MM-yyyy').format(selectedDate)
                                                          : '${selectedDate.toJalali().formatter.wN}, ${selectedDate.toJalali().formatter.d}-${selectedDate.toJalali().formatter.mm}-${selectedDate.toJalali().formatter.yyyy}';

                                                      controller.update();
                                                    }
                                                  });
                                                },
                                                child: Image.asset(
                                                  AppImages.calender,
                                                  height: 25,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () async {
                                                  Jalali? picked = await showPersianDatePicker(
                                                      context: context,
                                                      initialDate: Jalali.now(),
                                                      firstDate: Jalali.now(),
                                                      lastDate: Jalali.now().addDays(300),
                                                      initialEntryMode: PDatePickerEntryMode.calendarOnly,
                                                      initialDatePickerMode: PDatePickerMode.day,
                                                      builder: (context, child) {
                                                        return Theme(
                                                          data: ThemeData(
                                                            colorScheme: ColorScheme.light(
                                                              primary: AppColors.primary,
                                                              onPrimary: Colors.white,
                                                              surface: AppColors.primary,
                                                              onSurface: AppColors.black,
                                                            ),
                                                          ),
                                                          child: child!,
                                                        );
                                                      });
                                                  if (picked != null) {
                                                    Gregorian gregorianDate = picked.toGregorian();

                                                    DateTime gregorianDateTime =
                                                        DateTime(gregorianDate.year, gregorianDate.month, gregorianDate.day);
                                                    controller.dueInitialDay = gregorianDateTime;

                                                    controller.formattedDueDate = '${picked.year}-${picked.month}-${picked.day}';
                                                    controller.update();
                                                  }
                                                },
                                                child: Image.asset(
                                                  AppImages.calender,
                                                  height: 25,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> body = {};
                  Get.back();
                  if (controller.type == 'LastPeriod') {
                    int difference = DateTime.now().difference(controller.pregnancyInitialDay).inDays;
                    if (difference > 15) {
                      body = {
                        "type": "lastPeriod",
                        "date": "${DateFormat('yyyy-MM-dd').format(controller.pregnancyInitialDay).toEnglishDigit()}"
                      };

                      controller.pregnancyCalculation(body: body);
                      Get.offAndToNamed(Routes.PREGNANCY_TRIMSTER);
                    } else {
                      Get.snackbar(
                        'warning'.tr,
                        'snackbar_message'.tr,
                        backgroundColor: AppColors.primary,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: AppColors.white,
                        margin: EdgeInsets.all(10),
                        borderRadius: 15,
                        duration: Duration(seconds: 2),
                      );
                    }
                  } else if (controller.type == 'ConceptionDate') {
                    body = {
                      "type": "conception",
                      "date": "${DateFormat('yyyy-MM-dd').format(controller.conceptionInitialDay).toEnglishDigit()}"
                    };

                    log('body ---------->>>>>>>> ${body}');
                    controller.pregnancyCalculation(body: body);
                    Get.offAndToNamed(Routes.PREGNANCY_TRIMSTER);
                  } else {
                    body = {"type": "dueDate", "date": "${DateFormat('yyyy-MM-dd').format(controller.dueInitialDay).toEnglishDigit()}"};
                    controller.pregnancyCalculation(body: body);
                    Get.offAndToNamed(Routes.PREGNANCY_TRIMSTER);
                  }
                },
                child: Container(
                  height: h * 0.065,
                  width: w,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffFF4181),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'calculate'.tr,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
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
