import 'dart:convert';
import 'dart:developer';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/appointmtnet_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/appointment_detail_screen.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AppointmentHistoryScreen extends GetView<AppointmentHistoryController> {
  AppointmentHistoryScreen({Key? key}) : super(key: key);
  AppointmentHistoryController appointmentHistoryController = Get.find()..fetchAppointmentHistory();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('appointment_history'.tr, style: AppTextStyle.boldPrimary16.copyWith(fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          // child: RotatedBox(
          //     quarterTurns: SettingsController.appLanguge == "English" ? 0 : 2,
          //     child:
          //         Icon(Icons.arrow_back_ios_new, color: AppColors.primary)),
        ),
        elevation: 0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
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
        //   )
        // ],
      ),
      body: GetBuilder<AppointmentHistoryController>(
        builder: (controller) {
          return controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primary,
                ))
              : Container(
                  height: h,
                  width: w,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: controller.appointmentList.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: Get.height * 0.25,
                                  ),
                                  child: Center(child: Text("no_result_found".tr)),
                                )
                              : Column(
                                  children: [
                                    ListView.builder(
                                        itemCount: controller.appointmentList.length,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 90),
                                        itemBuilder: (context, index) {
                                          //TODO f-date
                                          var _d = controller.appointmentList[index].createAt == null
                                              ? DateTime.now()
                                              : DateTime.fromMillisecondsSinceEpoch(
                                                      int.parse(controller.appointmentList[index].createAt.toString()))
                                                  .toLocal();

                                          var date = _d!
                                              .toPersianDateStr(
                                                strDay: false,
                                                strMonth: true,
                                                useAfghaniMonthName: true,
                                              )
                                              .trim()
                                              .split(' ');

                                          var visitDate = DateTime.parse(controller.appointmentList[index] == ''
                                                  ? DateTime.now().toString()
                                                  : controller.appointmentList[index].visitDate!.toLocal().toString())
                                              .toPersianDateStr(
                                                strDay: false,
                                                strMonth: true,
                                                useAfghaniMonthName: true,
                                              )
                                              .trim()
                                              .split(' ');

                                          var visitDate121 = DateTime.parse(controller.appointmentList[index] == ""
                                              ? DateTime.now().toString()
                                              : controller.appointmentList[index].visitDate!.toLocal().toString());
                                          print('visitDate$visitDate121');
                                          log('LOFFOFOFOF${jsonEncode(controller.appointmentList[index])}');

                                          return Column(
                                            children: [
                                              Container(
                                                width: w,
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: Offset(0, 4), blurRadius: 4, color: AppColors.black.withOpacity(0.25))
                                                    ]),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      controller.appointmentList[index].patientId == null
                                                          ? Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors.red.withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(4)),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                    child: Center(
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            "${date[0]} ",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                          Text(
                                                                            " ${date[3]}",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                          Text(
                                                                            " ${date[1]}",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors.red.withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(4)),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                    child: Center(
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            "${date[0]}",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                          Text(
                                                                            " ${date[1]}",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                          Text(
                                                                            " ${date[3]}",
                                                                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.appointmentList[index].createAt == null ? DateTime.now().toString() : controller.appointmentList[index].createAt))}",
                                                                            style:
                                                                                AppTextStyle.mediumPrimary12.copyWith(color: AppColors.red),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                SvgPicture.asset(AppImages.doc, height: 20, width: 20),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "department".tr,
                                                                  style: AppTextStyle.boldBlack10
                                                                      .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  " ${controller.appointmentList[index].doctor![0].category?.title ?? ''}",
                                                                  style: AppTextStyle.boldBlack10
                                                                      .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.bold),
                                                                ),
                                                              ],
                                                            ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(AppImages.profile2, height: 20, width: 20),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            "doctor".tr,
                                                            style: AppTextStyle.boldBlack10
                                                                .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                          ),
                                                          Text(
                                                            " ${controller.appointmentList[index].doctor?[0].fullname ?? ""}",
                                                            style: AppTextStyle.boldBlack10
                                                                .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(AppImages.calendar, height: 20, width: 20),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "${visitDate[0]}",
                                                                // "${DateFormat().add_yMMMMEEEEd().format(DateTime.parse(controller.appointmentList[index].visitDate.toString() == null ? DateTime.now().toString() : controller.appointmentList[index].visitDate.toString()))}",
                                                                style: AppTextStyle.boldBlack10
                                                                    .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                              ),
                                                              Text(
                                                                " ${visitDate[1]}",
                                                                // "${DateFormat().add_yMMMMEEEEd().format(DateTime.parse(controller.appointmentList[index].visitDate.toString() == null ? DateTime.now().toString() : controller.appointmentList[index].visitDate.toString()))}",
                                                                style: AppTextStyle.boldBlack10
                                                                    .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                              ),
                                                              Text(
                                                                " ${visitDate[3]}",
                                                                // "${DateFormat().add_yMMMMEEEEd().format(DateTime.parse(controller.appointmentList[index].visitDate.toString() == null ? DateTime.now().toString() : controller.appointmentList[index].visitDate.toString()))}",
                                                                style: AppTextStyle.boldBlack10
                                                                    .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          SvgPicture.asset(AppImages.clock, height: 20, width: 20),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${DateFormat("HH.MM").format(DateTime.parse(controller.appointmentList[index].visitDate.toString() == null ? DateTime.now().toString() : controller.appointmentList[index].visitDate.toString()))}",
                                                            style: AppTextStyle.boldBlack10
                                                                .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      controller.appointmentList[index].status == "cancelled"
                                                          ? SizedBox()
                                                          : Row(
                                                              children: [
                                                                SvgPicture.asset(AppImages.chat, height: 20, width: 20),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  "review".tr,
                                                                  style: AppTextStyle.boldBlack10
                                                                      .copyWith(color: AppColors.lightBlack2, fontWeight: FontWeight.w400),
                                                                ),
                                                                Spacer(),
                                                                RatingBar.builder(
                                                                  ignoreGestures: true,
                                                                  itemSize: 17,
                                                                  initialRating: double.parse(
                                                                      "${controller.appointmentList[index].doctor?[0].averageRatings == null ? "0" : controller.appointmentList[index].doctor?[0].averageRatings.toString()}"),
                                                                  // minRating: 1,
                                                                  direction: Axis.horizontal,
                                                                  allowHalfRating: true,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                                  itemBuilder: (context, _) => Icon(
                                                                    Icons.star,
                                                                    color: Colors.amber,
                                                                    // size: 10,
                                                                  ),
                                                                  onRatingUpdate: (rating) {
                                                                    print(rating);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(AppointmentDetailScreen(
                                                    history: controller.appointmentList[index],
                                                  ));
                                                  // Get.toNamed(Routes.HISTORY_DETAILS);
                                                },
                                                child: Container(
                                                  width: w,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: controller.appointmentList[index].status == "cancelled"
                                                          ? Color(0xffFE9402)
                                                          : AppColors.primary,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset: Offset(0, 4), blurRadius: 4, color: AppColors.black.withOpacity(0.25))
                                                      ]),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Center(
                                                      child: Text(
                                                        controller.appointmentList[index].status == "cancelled"
                                                            ? "cancel".tr
                                                            : "see_details".tr,
                                                        style: AppTextStyle.boldWhite10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: BottomBarView(
                          isHomeScreen: false,
                          isBlueBottomBar: true,
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
