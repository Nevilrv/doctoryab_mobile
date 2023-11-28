import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/booking_add_other_info_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingInfoScreen extends GetView<CheckupPackagesController> {
  Package item;
  BookingInfoScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("id-------->${SettingsController.userId}");
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
        return Container(
          height: h,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 45, bottom: 10),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "other_information".tr,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.boldWhite16,
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(BasketDetailScreen());
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
                                          AppImages.history,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   right: 0,
                                  //   // top: -5,
                                  //   child: CircleAvatar(
                                  //     radius: 8,
                                  //     backgroundColor: AppColors.red2,
                                  //     child: Center(
                                  //       child: Text(
                                  //         "3",
                                  //         style: AppTextStyle.boldWhite10,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "your_city_selection".tr,
                              style: AppTextStyle.boldGrey12.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.locations.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "no_result_found".tr, context: context);
                            }
                          },
                          child: Container(
                            width: w,
                            // height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(0.4),
                                    width: 2),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 7, bottom: 7, left: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      AppImages.map,
                                      color: AppColors.primary.withOpacity(0.5),
                                    ),
                                  ),
                                  Container(
                                    width: w * 0.75,
                                    child: DropdownButton<String>(
                                      underline: SizedBox(),
                                      // value: controller.selectedLocation.value ?? "",
                                      icon: Icon(Icons.expand_more,
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                      isDense: true,
                                      hint: Text(
                                        controller.selectedLocation.value == ""
                                            ? "Please_select_city".tr
                                            : controller.selectedLocation.value,
                                        style: AppTextStyle.mediumPrimary12
                                            .copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                      ),
                                      isExpanded: true,

                                      items: controller.locations
                                          .map((City value) {
                                        return DropdownMenuItem<String>(
                                          value: value.sId,
                                          child: Text(value.eName,
                                              style: AppTextStyle
                                                  .mediumPrimary12
                                                  .copyWith(
                                                      color:
                                                          AppColors.primary)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.locations.forEach((element) {
                                          if (value == element.sId) {
                                            controller.selectedLocation.value =
                                                element.eName;
                                          }
                                        });
                                        controller.selectedLocationId.value =
                                            value;

                                        // controller.getLabAndHospitalList();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "select_hospital".tr,
                              style: AppTextStyle.boldGrey12.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.selectedLocation.value.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "Please_select_city".tr,
                                  context: context);
                            } else if (controller
                                .selectHospitalLabList.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "no_result_found".tr, context: context);
                            }
                          },
                          child: Container(
                            width: w,
                            // height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(0.4),
                                    width: 2),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 7, bottom: 7, left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<dynamic>(
                                      underline: SizedBox(),
                                      // value: controller.selectedHospitalLab.value ??
                                      //     "",
                                      hint: Text(
                                        controller.selectedHospitalLabName
                                                    .value ==
                                                ""
                                            ? "please_select_clinic,hospital_or_lab"
                                                .tr
                                            : controller
                                                .selectedHospitalLabName.value,
                                        style: AppTextStyle.mediumPrimary12
                                            .copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                      ),
                                      onTap: () {},
                                      icon: Icon(Icons.expand_more,
                                          color: AppColors.primary
                                              .withOpacity(0.4)),
                                      isDense: true,
                                      isExpanded: true,
                                      items: controller.selectHospitalLabList
                                          .map((dynamic value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value['id'],
                                          child: Text(value['name'],
                                              style: AppTextStyle
                                                  .mediumPrimary12
                                                  .copyWith(
                                                      color:
                                                          AppColors.primary)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.selectedHospitalLabId.value =
                                            value;
                                        log("controller.selectedHospitalLabId.value--------------> ${controller.selectedHospitalLabId.value}");

                                        controller.selectHospitalLabList
                                            .forEach((element) {
                                          if (element['id'] ==
                                              controller.selectedHospitalLabId
                                                  .value) {
                                            controller.selectedHospitalLabName
                                                .value = element['name'];

                                            if (element['type'] == "lab") {
                                              controller.selectedType.value =
                                                  'lab';
                                              controller.getLabScheduleList(
                                                  // labId:
                                                  //     "61a0a8557b2fbfe02f03bbd3",
                                                  labId: element['id'],
                                                  type: 'lab');
                                            } else {
                                              controller.selectedType.value =
                                                  'hospital';
                                              controller.getLabScheduleList(
                                                  // hospitalId:
                                                  //     "63495ef6390446114d25be0b",
                                                  hospitalId: element['id'],
                                                  type: 'hospital');
                                            }
                                          }
                                        });
                                        controller.update();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "select_date".tr,
                              style: AppTextStyle.boldGrey12.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller
                                .selectedHospitalLabId.value.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "please_select_hospital_lab".tr,
                                  context: context);
                            }
                          },
                          child: Container(
                            width: w,
                            // height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(0.4),
                                    width: 2),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 7, bottom: 7, left: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      AppImages.calendar,
                                      height: 23,
                                      width: 23,
                                      color: AppColors.primary.withOpacity(0.5),
                                    ),
                                  ),
                                  Expanded(
                                    child: DropdownButton<dynamic>(
                                      underline: SizedBox(),
                                      // value: controller.selectedHospitalLab.value ??
                                      //     "",
                                      hint: Text(
                                        controller.selectedDate.value == ""
                                            ? 'please_select_date'.tr
                                            : "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.selectedDate.value))}",
                                        style: AppTextStyle.mediumPrimary12
                                            .copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                      ),
                                      onTap: () {},
                                      icon: Icon(Icons.expand_more,
                                          color: AppColors.primary
                                              .withOpacity(0.4)),
                                      isDense: true,
                                      isExpanded: true,
                                      items: controller.scheduleListDate
                                          .map((DateTime value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(
                                              "${DateFormat("dd.MM.yyyy").format(DateTime.parse(value.toString()))}",
                                              style: AppTextStyle
                                                  .mediumPrimary12
                                                  .copyWith(
                                                      color:
                                                          AppColors.primary)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.selectDate(value);
                                      },
                                    ),
                                  ),
                                  // Text(
                                  //   controller.selectedDate.value == ""
                                  //       ? 'please_select_date'.tr
                                  //       : controller.selectedDate.toString(),
                                  //   style: AppTextStyle.mediumPrimary12
                                  //       .copyWith(
                                  //           color: AppColors.primary
                                  //               .withOpacity(0.5)),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "select_time".tr,
                              style: AppTextStyle.boldGrey12.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.selectedDate.value.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "please_select_date".tr,
                                  context: context);
                            } else if (controller.timeList.isEmpty) {
                              Utils.commonSnackbar(
                                  text: "no_result_found".tr, context: context);
                            }
                          },
                          child: Container(
                            width: w,
                            // height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(0.4),
                                    width: 2),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 7, bottom: 7, left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      underline: SizedBox(),
                                      hint: Text(
                                          controller.selectedTime.value == ""
                                              ? "please_select_time".tr
                                              : "${DateTime.parse(controller.selectedTime.value).hour.toString().padLeft(2, '0')}:${DateTime.parse(controller.selectedTime.value).minute.toString().padLeft(2, '0')}",
                                          style: AppTextStyle.mediumPrimary12
                                              .copyWith(
                                                  color: AppColors.primary
                                                      .withOpacity(0.5))),
                                      // value: controller.selectedTime.value ?? "",
                                      icon: Icon(Icons.expand_more,
                                          color: AppColors.primary
                                              .withOpacity(0.4)),
                                      isDense: true,
                                      isExpanded: true,
                                      items: controller.timeList
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                              "${DateTime.parse(value).hour.toString().padLeft(2, '0')}:${DateTime.parse(value).minute.toString().padLeft(2, '0')}",
                                              style: AppTextStyle
                                                  .mediumPrimary12
                                                  .copyWith(
                                                      color: AppColors.primary
                                                          .withOpacity(0.5))),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.selectedTime.value = value;

                                        // log("time-------->${DateTime.parse(controller.selectedTime.value).toUtc().toIso8601String()}");
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.selectedTime.value == "") {
                              Utils.commonSnackbar(
                                  text: "please_select_time".tr,
                                  context: context);
                            } else {
                              log("controller.selectedTime.value--------------> ${controller.selectedTime.value}");

                              Get.to(BookingOtherInfoScreen(
                                selectedDate: controller.selectedTime.value,
                                packageId: item.id,
                              ));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.teal,
                                border: Border.all(color: AppColors.teal)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Confirm".tr,
                                  style: AppTextTheme.b(15).copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: BottomBarView(
                    isHomeScreen: false,
                  ))
            ],
          ),
        );
      }),
    );
  }
  //
  // Get.dialog(
  // Padding(
  // padding:
  // const EdgeInsets.symmetric(horizontal: 30),
  // child: Center(
  // child: Container(
  // width: w,
  // // height: Get.height * 0.3,
  // decoration: BoxDecoration(
  // borderRadius: BorderRadius.circular(30),
  // color: AppColors.white,
  // ),
  // child: Padding(
  // padding: EdgeInsets.symmetric(
  // horizontal: h * 0.03, vertical: 10),
  // child: Column(
  // mainAxisSize: MainAxisSize.min,
  // children: [
  // SizedBox(
  // height: h * 0.01,
  // ),
  // SvgPicture.asset(
  // AppImages.success,
  // height: 230,
  // width: 230,
  // ),
  // SizedBox(
  // height: h * 0.01,
  // ),
  // Text(
  // "book_success".tr,
  // style: AppTextStyle.boldPrimary24
  //     .copyWith(
  // color: AppColors.green3),
  // ),
  // SizedBox(
  // height: h * 0.01,
  // ),
  // Text(
  // "Your booking request succesfully, check your e-mail other details!",
  // textAlign: TextAlign.center,
  // style: AppTextStyle.mediumBlack16
  //     .copyWith(
  // color: AppColors.black3,
  // fontSize: 15),
  // ),
  // SizedBox(
  // height: h * 0.03,
  // ),
  // GestureDetector(
  // onTap: () {
  // Get.back();
  // Get.back();
  // },
  // child: Container(
  // width: w,
  // decoration: BoxDecoration(
  // borderRadius:
  // BorderRadius.circular(10),
  // color: AppColors.primary),
  // child: Padding(
  // padding:
  // const EdgeInsets.symmetric(
  // vertical: 10,
  // horizontal: 15),
  // child: Center(
  // child: Text(
  // "back_to_checkup_list"
  //     .tr,
  // style: AppTextStyle
  //     .boldWhite15)),
  // ),
  // ),
  // )
  // ],
  // ),
  // ),
  // ),
  // ),
  // ),
  // // confirm: Text("cooo"),
  // // actions: <Widget>[Text("aooo"), Text("aooo")],
  // // cancel: Text("bla bla"),
  // // content: Text("bla bldddda"),
  // );
}
