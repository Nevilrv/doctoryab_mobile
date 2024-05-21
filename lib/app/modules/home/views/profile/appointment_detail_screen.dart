import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/modules/home/controllers/appointmtnet_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/appintment_feedback_screen.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AppointmentDetailScreen extends StatelessWidget {
  History? history;
  AppointmentDetailScreen({Key? key, this.history}) : super(key: key);
  AppointmentHistoryController appointmentHistoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('appointment_details'.tr,
              style: AppTextStyle.boldPrimary16
                  .copyWith(fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: RotatedBox(
                quarterTurns:
                    SettingsController.appLanguge == "English" ? 0 : 2,
                child: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
              )),
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: history!.doctor?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: h * 0.7,
                        width: w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: AppColors.black.withOpacity(0.25))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // color: Colors.black,
                                    // height: 65,
                                    // width: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.lightGrey),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${ApiConsts.hostUrl}${history?.doctor?[index].photo}",
                                        height: h * 0.11,
                                        width: h * 0.11,
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) {
                                          return Image.asset(
                                            "assets/png/person-placeholder.jpg",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        errorWidget: (_, __, ___) {
                                          return Image.asset(
                                            "assets/png/person-placeholder.jpg",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            history == null
                                                ? SizedBox()
                                                : Text(
                                                    "${history?.doctor?[index].name ?? ""}",
                                                    style: AppTextTheme.h(12)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                            Text(
                                              "${history?.doctor?[index].category?.title}",
                                              style: AppTextTheme.h(11)
                                                  .copyWith(
                                                      color: AppColors.primary
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            SizedBox(height: 2),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  itemSize: 17,
                                                  initialRating: double.parse(
                                                      "${history?.doctor?[index].averageRatings == null ? "0" : history?.doctor?[index].averageRatings.toString()}"),
                                                  // minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    // size: 10,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                SizedBox(width: 4),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(ReviewScreen(
                                                    //   appBarTitle: "Doctor Reviews",
                                                    // ));

                                                    Get.toNamed(Routes.REVIEW,
                                                        arguments: [
                                                          "Doctor_Review",
                                                          history
                                                              ?.doctor?[index]
                                                        ]);
                                                  },
                                                  child: Text(
                                                    '(${history?.doctor?[index].totalFeedbacks == null ? "0" : history?.doctor?[index].totalFeedbacks.toString()}) ${"reviews".tr}',
                                                    style: AppTextTheme.b(12)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: w * 0.2,
                                      child: Divider(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    'time_info'.tr,
                                    style: AppTextTheme.b(11).copyWith(
                                        color:
                                            AppColors.primary.withOpacity(0.5)),
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Container(
                                      width: w * 0.2,
                                      child: Divider(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              // appointmentBox(w),
                              // SizedBox(
                              //   height: h * 0.03,
                              // ),
                              DateAppointmentBox(w),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              VisitedDoctorBox(w),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              history?.visited == false
                                  ? history?.status == "cancelled"
                                      ? Text(
                                          SettingsController.appLanguge ==
                                                  "English"
                                              ? "Your appointment is cancelled!"
                                              : SettingsController.appLanguge ==
                                                      "فارسی"
                                                  ? " !وقت معاینه شما کنسل شد"
                                                  : " ستاسو ملاقات لغوه شو",
                                          style: AppTextTheme.h(13).copyWith(
                                              color: AppColors.red2
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w500))
                                      : GestureDetector(
                                          onTap: () {
                                            AppGetDialog.showCancelAppointment(
                                              doctorName: '',
                                              onTap: () {
                                                Get.back();
                                                appointmentHistoryController
                                                    .cancelAppointment(
                                                        id: history?.id,
                                                        patientId:
                                                            history?.patientId,
                                                        context: context);
                                                Get.back();
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: AppColors.primary,
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 4),
                                                      blurRadius: 4,
                                                      color: AppColors.black
                                                          .withOpacity(0.1))
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: Center(
                                                child: Text(
                                                  "Cancel Appointments",
                                                  style:
                                                      AppTextStyle.boldWhite10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                  : SizedBox(),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(AppointmentFeedbackScreen(
                                    history: history!,
                                  ));
                                },
                                child: Container(
                                  width: w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: AppColors.primary,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            color: AppColors.black
                                                .withOpacity(0.25))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Center(
                                      child: Text(
                                        "give_feedback".tr,
                                        style: AppTextStyle.boldWhite10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
            ),
          ],
        ),
      ),
    );
  }

  // Stack appointmentBox(double w) {
  //   var d = DateTime.parse(history.visitDate == null
  //           ? DateTime.now()
  //           : history.visitDate.toLocal().toString())
  //       .toPersianDateStr(
  //         strDay: false,
  //         strMonth: true,
  //         useAfghaniMonthName: true,
  //       )
  //       .trim()
  //       .split(' ');
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Container(
  //         width: w,
  //         decoration: BoxDecoration(
  //             color: AppColors.white,
  //             borderRadius: BorderRadius.circular(5),
  //             boxShadow: [
  //               BoxShadow(
  //                   offset: Offset(0, 4),
  //                   blurRadius: 4,
  //                   color: AppColors.black.withOpacity(0.25))
  //             ],
  //             border: Border.all(color: AppColors.lightPurple4, width: 2)),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           child: Row(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: AppColors.red.withOpacity(0.1),
  //                     borderRadius: BorderRadius.circular(4)),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //                   child: Center(
  //                       child: Row(
  //                     children: [
  //                       Text(
  //                         "${d[0]}",
  //                         // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
  //                         style: AppTextStyle.mediumPrimary12
  //                             .copyWith(color: AppColors.red),
  //                       ),
  //                       Text(
  //                         " ${d[1]}",
  //                         // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
  //                         style: AppTextStyle.mediumPrimary12
  //                             .copyWith(color: AppColors.red),
  //                       ),
  //                       Text(
  //                         " ${d[3]}",
  //                         // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
  //                         style: AppTextStyle.mediumPrimary12
  //                             .copyWith(color: AppColors.red),
  //                       ),
  //                     ],
  //                   )),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: w * 0.02,
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: AppColors.red.withOpacity(0.1),
  //                     borderRadius: BorderRadius.circular(4)),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //                   child: Center(
  //                     child: Text(
  //                       "/",
  //                       style: AppTextStyle.mediumPrimary12
  //                           .copyWith(color: AppColors.red),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: w * 0.02,
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: AppColors.red.withOpacity(0.1),
  //                     borderRadius: BorderRadius.circular(4)),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //                   child: Center(
  //                     child: Text(
  //                       "${DateFormat("HH.MM").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
  //                       style: AppTextStyle.mediumPrimary12
  //                           .copyWith(color: AppColors.red),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         left: 20,
  //         top: -7.5,
  //         child: Container(
  //           color: AppColors.white,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 5),
  //             child: Text(
  //               "visit_date".tr,
  //               style: AppTextTheme.h(11).copyWith(
  //                   color: AppColors.lightPurple4, fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Stack VisitedDoctorBox(double w) {
    log('------history.visited-----${history?.visited}');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: w,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black.withOpacity(0.25))
              ],
              border: Border.all(color: AppColors.lightPurple4, width: 2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: history?.visited == true
                          ? AppColors.green.withOpacity(0.1)
                          : AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Text(
                        history?.visited == true ? "YES" : "NO",
                        style: AppTextStyle.mediumPrimary12.copyWith(
                          color: history?.visited == true
                              ? AppColors.green
                              : AppColors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: -7.5,
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "visited_by_doctor".tr,
                style: AppTextTheme.h(11).copyWith(
                    color: AppColors.lightPurple4, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }

  Stack DateAppointmentBox(double w) {
    var d = DateTime.parse(history?.visitDate == null
            ? DateTime.now().toString()
            : history!.visitDate!.toLocal().toString())
        .toPersianDateStr(
          strDay: false,
          strMonth: true,
          useAfghaniMonthName: true,
        )
        .trim()
        .split(' ');
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: w,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black.withOpacity(0.25))
              ],
              border: Border.all(color: AppColors.lightPurple4, width: 2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            "${d[0]}",
                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
                            style: AppTextStyle.mediumPrimary12
                                .copyWith(color: AppColors.red),
                          ),
                          Text(
                            " ${d[1]}",
                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
                            style: AppTextStyle.mediumPrimary12
                                .copyWith(color: AppColors.red),
                          ),
                          Text(
                            " ${d[3]}",
                            // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(history.visitDate.toString() == null ? DateTime.now().toString() : history.visitDate.toString()))}",
                            style: AppTextStyle.mediumPrimary12
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Text(
                        "/",
                        style: AppTextStyle.mediumPrimary12
                            .copyWith(color: AppColors.red),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Text(
                        "${DateFormat("HH.MM").format(DateTime.parse(history?.visitDate.toString() == null ? DateTime.now().toString() : history!.visitDate.toString()))}",
                        style: AppTextStyle.mediumPrimary12
                            .copyWith(color: AppColors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: -7.5,
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "date_of_appointments".tr,
                style: AppTextTheme.h(11).copyWith(
                    color: AppColors.lightPurple4, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }
}
