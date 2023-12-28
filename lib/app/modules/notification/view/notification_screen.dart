import 'dart:developer';

import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/home_controller.dart';
import 'package:doctor_yab/app/modules/home/views/blog/tab_blog_view.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/hospital_new/tab_main/bindings/tab_main_binding.dart';
import 'package:doctor_yab/app/modules/notification/controllers/notification_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({Key key}) : super(key: key);
  NotificationController controller = Get.find()..loadNotification();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppAppBar.specialAppBar(
            'notifications'.tr,
            backgroundColor: Colors.transparent,
          ),
          body: GetBuilder<NotificationController>(
            builder: (controller) {
              return Container(
                height: h,
                // color: AppColors.red,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        height: Get.height * 0.8,
                        child: controller.isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            : controller.notification.isEmpty
                                ? Center(child: Text("no_result_found".tr))
                                : SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: List.generate(
                                          controller.notification.length,
                                          (index) {
                                        // var d;
                                        // if (controller.notification[index]
                                        //         .prescriptionId !=
                                        //     null) {
                                        //   d = DateTime.parse(controller
                                        //           .notification[index]
                                        //           .prescriptionId
                                        //           .createAt)
                                        //       .toPersianDateStr(
                                        //         strDay: false,
                                        //         strMonth: true,
                                        //         useAfghaniMonthName: true,
                                        //       )
                                        //       .trim()
                                        //       .split(' ');
                                        // } else if (controller
                                        //         .notification[index]
                                        //         .appointmentId !=
                                        //     null) {
                                        //   var _date = controller
                                        //               .notification[index]
                                        //               .appointmentId
                                        //               .createAt ==
                                        //           null
                                        //       ? DateTime.now()
                                        //       : DateTime
                                        //               .fromMillisecondsSinceEpoch(
                                        //                   int.tryParse(
                                        //                       controller
                                        //                           .notification[
                                        //                               index]
                                        //                           .appointmentId
                                        //                           .createAt))
                                        //           ?.toLocal();
                                        //   d = DateTime.parse(_date.toString())
                                        //       .toPersianDateStr(
                                        //         strDay: false,
                                        //         strMonth: true,
                                        //         useAfghaniMonthName: true,
                                        //       )
                                        //       .trim()
                                        //       .split(' ');
                                        // } else if (controller
                                        //         .notification[index].blogId !=
                                        //     null) {
                                        //   d = DateTime.parse(controller
                                        //           .notification[index]
                                        //           .blogId
                                        //           .createAt)
                                        //       .toPersianDateStr(
                                        //         strDay: false,
                                        //         strMonth: true,
                                        //         useAfghaniMonthName: true,
                                        //       )
                                        //       .trim()
                                        //       .split(' ');
                                        // } else {
                                        //   d = DateTime.parse(
                                        //           DateTime.now().toString())
                                        //       .toPersianDateStr(
                                        //         strDay: false,
                                        //         strMonth: true,
                                        //         useAfghaniMonthName: true,
                                        //       )
                                        //       .trim()
                                        //       .split(' ');
                                        // }

                                        print(
                                            '=============${SettingsController.appLanguge}');

                                        DateTime d;
                                        if (controller.notification[index]
                                                .prescriptionId !=
                                            null) {
                                          d = DateTime.parse(controller
                                              .notification[index]
                                              .prescriptionId
                                              .createAt);
                                        } else if (controller
                                                .notification[index]
                                                .appointmentId !=
                                            null) {
                                          var _date = controller
                                                      .notification[index]
                                                      .appointmentId
                                                      .createAt ==
                                                  null
                                              ? DateTime.now()
                                              : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.tryParse(
                                                              controller
                                                                  .notification[
                                                                      index]
                                                                  .appointmentId
                                                                  .createAt))
                                                  ?.toLocal();
                                          d = DateTime.parse(_date.toString());
                                        } else if (controller
                                                .notification[index].blogId !=
                                            null) {
                                          d = DateTime.parse(controller
                                              .notification[index]
                                              .blogId
                                              .createAt);
                                        } else if (controller
                                                .notification[index].reportId !=
                                            null) {
                                          d = DateTime.parse(controller
                                              .notification[index]
                                              .reportId
                                              .createAt);
                                        } else {
                                          d = DateTime.now();
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              log('====HELLOTYPE${controller.notification[index].type}');

                                              if (controller.notification[index]
                                                      .type ==
                                                  'blog') {
                                                log('====HELLOTYPE${controller.notification[index].type}');

                                                HomeController ctl = Get.find();
                                                ctl.selectedIndex = 3;
                                                Get.to(() => TabBlogView(),
                                                    binding: TabMainBinding(),
                                                    arguments: {
                                                      'id': 'notification'
                                                    });
                                              } else if (controller
                                                      .notification[index]
                                                      .type ==
                                                  'prescription') {
                                                log('====HELLOTYPE${controller.notification[index].type}');
                                                Get.toNamed(
                                                    Routes.REPORT_MEDICAL,
                                                    arguments: {'id': "0"});
                                              } else if (controller
                                                      .notification[index]
                                                      .type ==
                                                  'labReport') {
                                                log('====HELLOTYPE${controller.notification[index].type}');

                                                Get.toNamed(
                                                    Routes.REPORT_MEDICAL,
                                                    arguments: {'id': "1"});
                                              } else if (controller
                                                      .notification[index]
                                                      .type ==
                                                  'appointment') {
                                                log('====HELLOTYPE${controller.notification[index].type}');

                                                Get.toNamed(
                                                    Routes.APPOINTMENT_HISTORY);
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            controller
                                                                    .notification[
                                                                        index]
                                                                    .title ??
                                                                "",
                                                            style: AppTextStyle
                                                                .boldPrimary11
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.5)),
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.circle,
                                                                size: 3,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                              SizedBox(
                                                                  width: 3),
                                                              Text(
                                                                "${calculateTime(d)}",
                                                                style: AppTextStyle
                                                                    .boldPrimary11
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .primary),
                                                              ),
                                                              // Text(
                                                              //   " ${d[1]}",
                                                              //   style: AppTextStyle
                                                              //       .boldPrimary11
                                                              //       .copyWith(
                                                              //           fontWeight:
                                                              //               FontWeight
                                                              //                   .w500,
                                                              //           color: AppColors
                                                              //               .primary),
                                                              // ),
                                                              // Text(
                                                              //   " ${d[3]}",
                                                              //   style: AppTextStyle
                                                              //       .boldPrimary11
                                                              //       .copyWith(
                                                              //           fontWeight:
                                                              //               FontWeight
                                                              //                   .w500,
                                                              //           color: AppColors
                                                              //               .primary),
                                                              // ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        controller
                                                                .notification[
                                                                    index]
                                                                .body ??
                                                            "",
                                                        style: AppTextTheme.h(
                                                                12)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                    thickness: 1,
                                                    color: AppColors.primary),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: BottomBarView(
                          isHomeScreen: false,
                          isBlueBottomBar: true,
                        ))
                  ],
                ),
              );
            },
          )),
    );
  }

  static String calculateTime(DateTime time) {
    Duration compare(DateTime x, DateTime y) {
      return Duration(
          microseconds:
              (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());
    }

    DateTime x = DateTime.now();
    DateTime y = time;

    Duration diff = compare(x, y);
    int days = diff.inDays;
    int hours = diff.inHours;
    int minutes = diff.inMinutes;

    String result = '';
    if (days > 365) {
      result = '${(days / 365).floor().toString()}y ago';
    } else if (days > 30) {
      result = '${(days / 30).floor().toString()}m ago';
    } else if (days > 7) {
      result = '${(days / 7).floor().toString()}w ago';
    } else if (days > 1) {
      result = '${(days / 1).floor().toString()}d ago';
    } else if (hours > 1) {
      result = '${hours}h ago';
    } else if (minutes > 1) {
      result = '${minutes}m ago';
    } else {
      result = 'Now';
    }

    return result;
  }
}
