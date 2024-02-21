import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PregnancyCalculation extends GetView<PregnancyTrackerNewController> {
  PregnancyCalculation({Key key}) : super(key: key);

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
              controller.type == 'LastPeriod'
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
                                  padding: EdgeInsets.only(
                                      left: 12, bottom: 8, top: 10, right: 10),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
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
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .showDatePicker(
                                      initialDate:
                                          controller.pregnancyInitialDay,
                                      lastDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      context: context,
                                    )
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        controller.pregnancyInitialDay =
                                            selectedDate;

                                        controller.formattedPregnancyDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(selectedDate);

                                        controller.update();
                                      }
                                    });
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
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          bottom: 8,
                                          top: 10,
                                          right: 20),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.formattedDueDate,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller
                                            .showDatePicker(
                                          initialDate: controller.dueInitialDay,
                                          lastDate: DateTime(2026),
                                          firstDate: DateTime(2021),
                                          context: context,
                                        )
                                            .then((selectedDate) {
                                          if (selectedDate != null) {
                                            controller.dueInitialDay =
                                                selectedDate;

                                            controller.formattedDueDate =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(selectedDate);
                                            controller.update();
                                          }
                                        });
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
                      : controller.type == 'ConceptionDate'
                          ? Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.05),
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
                                          padding: EdgeInsets.only(
                                              left: 12,
                                              bottom: 8,
                                              top: 10,
                                              right: 10),
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
                                      'Whats your conception date?'.tr,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${controller.formattedConceptionDate}',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .showDatePicker(
                                              initialDate: controller
                                                  .conceptionInitialDay,
                                              lastDate: DateTime(2026),
                                              firstDate: DateTime(2021),
                                              context: context,
                                            )
                                                .then((selectedDate) {
                                              if (selectedDate != null) {
                                                controller
                                                        .conceptionInitialDay =
                                                    selectedDate;

                                                controller
                                                        .formattedConceptionDate =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(selectedDate);

                                                controller.update();
                                              }
                                            });
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

                  if (controller.type == 'LastPeriod') {
                    int difference = DateTime.now()
                        .difference(controller.pregnancyInitialDay)
                        .inDays;
                    if (difference > 15) {
                      body = {
                        "type": "lastPeriod",
                        "date":
                            "${DateFormat('yyyy-MM-dd').format(controller.pregnancyInitialDay)}"
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
                      "date":
                          "${DateFormat('yyyy-MM-dd').format(controller.conceptionInitialDay)}"
                    };

                    controller.pregnancyCalculation(body: body);
                    Get.offAndToNamed(Routes.PREGNANCY_TRIMSTER);
                  } else {
                    body = {
                      "type": "dueDate",
                      "date":
                          "${DateFormat('yyyy-MM-dd').format(controller.dueInitialDay)}"
                    };
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
