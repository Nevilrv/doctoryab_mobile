import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/dateSquare.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/schedule_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  BookController bookController = Get.find()..fetchDoctorTimeTable(1);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppAppBar.specialAppBar('appointment_details'.tr,
                backgroundColor: Colors.transparent,
                action: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATION);
                    },
                    child: SvgPicture.asset(
                      AppImages.blackBell,
                      height: 24,
                      width: 24,
                    ),
                  ),
                )),
            body: GetBuilder<BookController>(
              builder: (controller) {
                return Container(
                  height: h,
                  // color: AppColors.red,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          // height: 220,

                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Container(
                            height: h * 0.7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // color: Colors.black,
                                            // height: 65,
                                            // width: 65,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.lightGrey),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${ApiConsts.hostUrl}${controller.doctor.photo}",
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // SizedBox(height: 10),
                                                  Text(
                                                    "${controller.doctor.name ?? ""}",
                                                    style: AppTextTheme.h(12)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    "${controller.doctor.speciality ?? ""}",
                                                    style: AppTextTheme.b(11)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        itemSize: 17,
                                                        initialRating:
                                                            double.parse(
                                                          "${controller.doctor.averageRatings == null ? "0.0" : controller.doctor.averageRatings.toString() ?? "0.0"}",
                                                        ),
                                                        // minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          // size: 10,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      SizedBox(width: 4),
                                                      // Text(
                                                      //   '(${double.tryParse(controller.doctor.totalStar?.toStringAsFixed(1)) ?? ""})',
                                                      //   style: AppTextTheme.b(10.5)
                                                      //       .copyWith(color: AppColors.lgt2),
                                                      // ),
                                                      Text(
                                                        '(${controller.doctor.totalFeedbacks == null ? 0 : controller.doctor.totalFeedbacks}) Reviews',
                                                        style: AppTextTheme.b(
                                                                11)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      controller.isLoading == true
                                          ? Center(
                                              child: CircularProgressIndicator(
                                              color: AppColors.primary,
                                            ))
                                          : controller.dataList.isEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      top: Get.height * 0.2),
                                                  child: Center(
                                                      child: Text(
                                                          "no_slot_available"
                                                              .tr)),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: w * 0.2,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5),
                                                              height: 3,
                                                            )),
                                                        SizedBox(
                                                          width: w * 0.02,
                                                        ),
                                                        Text(
                                                          'select_a_date'.tr,
                                                          style: AppTextTheme.b(
                                                                  11)
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                        ),
                                                        SizedBox(
                                                          width: w * 0.02,
                                                        ),
                                                        Container(
                                                            width: w * 0.2,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5),
                                                              height: 3,
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: List.generate(
                                                            controller.dataList
                                                                .length,
                                                            (index) {
                                                          List<String>
                                                              parsedDate =
                                                              controller
                                                                  .dataList[
                                                                      index]
                                                                  .date
                                                                  .toPersianDateStr(
                                                                      showDayStr:
                                                                          true,
                                                                      useAfghaniMonthName:
                                                                          true)
                                                                  .split(' ');
                                                          bool extraSpaceMode =
                                                              parsedDate
                                                                      .length ==
                                                                  6;
                                                          String month =
                                                              extraSpaceMode
                                                                  ? parsedDate[
                                                                      3]
                                                                  : parsedDate[
                                                                      2];
                                                          String day =
                                                              extraSpaceMode
                                                                  ? parsedDate[
                                                                      2]
                                                                  : parsedDate[
                                                                      1];
                                                          String dayText =
                                                              extraSpaceMode
                                                                  ? parsedDate[
                                                                          0] +
                                                                      " " +
                                                                      parsedDate[
                                                                          1]
                                                                  : parsedDate[
                                                                      0];
                                                          log("month--------------> ${month}");
                                                          log("day--------------> ${day}");

                                                          log("dayText--------------> ${dayText}");
                                                          log("parsedDate--------------> ${parsedDate}");

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .selectedDates
                                                                    .value = index;
                                                                controller
                                                                        .selectedDataList =
                                                                    controller
                                                                        .dataList[
                                                                            index]
                                                                        .times;
                                                                controller
                                                                        .selectedDate =
                                                                    controller
                                                                        .dataList[
                                                                            index]
                                                                        .date
                                                                        .toString();
                                                                if (controller
                                                                    .selectedDataList
                                                                    .isNotEmpty) {
                                                                  controller
                                                                          .selectedDataTime =
                                                                      controller
                                                                          .selectedDataList[
                                                                              0]
                                                                          .toString();
                                                                }
                                                                controller
                                                                    .update();
                                                              },
                                                              child: Container(
                                                                height: 90,
                                                                width: 90,
                                                                decoration: BoxDecoration(
                                                                    color: controller.selectedDates.value ==
                                                                            index
                                                                        ? AppColors
                                                                            .primary
                                                                        : AppColors
                                                                            .primary
                                                                            .withOpacity(
                                                                                0.4),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            19)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      day.toEnglishDigit(),
                                                                      // controller
                                                                      //     .dataList[
                                                                      //         index]
                                                                      //     .date
                                                                      //     .day
                                                                      //     .toString(),
                                                                      style: AppTextTheme.b(
                                                                              22)
                                                                          .copyWith(
                                                                              color: AppColors.white),
                                                                    ),
                                                                    Text(
                                                                      "${month}",
                                                                      // "${DateFormat('MMM').format(controller.dataList[index].date)}",
                                                                      style: AppTextTheme.b(
                                                                              14)
                                                                          .copyWith(
                                                                              color: AppColors.white),
                                                                    ),
                                                                    Text(
                                                                      "(${controller.dataList[index].times.length}) Free Slots",
                                                                      style: AppTextTheme.b(8).copyWith(
                                                                          color: AppColors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: w * 0.2,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5),
                                                              height: 3,
                                                            )),
                                                        SizedBox(
                                                          width: w * 0.02,
                                                        ),
                                                        Text(
                                                          'select_a_time'.tr,
                                                          style: AppTextTheme.b(
                                                                  11)
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                        ),
                                                        SizedBox(
                                                          width: w * 0.02,
                                                        ),
                                                        Container(
                                                            width: w * 0.2,
                                                            child: Divider(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5),
                                                              height: 3,
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.01,
                                                    ),
                                                    GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .selectedDataList
                                                          .length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisSpacing:
                                                                  10,
                                                              crossAxisSpacing:
                                                                  9,
                                                              mainAxisExtent:
                                                                  40),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                      .selectedDataTime =
                                                                  controller
                                                                      .selectedDataList[
                                                                          index]
                                                                      .toString();
                                                              log("controller.selectedDataTime--------------> ${controller.selectedDataTime}");

                                                              controller
                                                                  .update();
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: controller
                                                                              .selectedDataTime ==
                                                                          controller.selectedDataList[index]
                                                                              .toString()
                                                                      ? AppColors
                                                                          .primary
                                                                      : AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.4),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              11)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${DateFormat("hh:mm").format(DateTime.parse(controller.selectedDataList[index].toLocal().toString()))} ${DateFormat("hh:mm a").format(DateTime.parse(controller.selectedDataList[index].toLocal().toString())).toString().contains("AM") ? "am".tr : "pm".tr}",
                                                                    style: AppTextTheme.b(
                                                                            11)
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),
                                                    Container(
                                                      height: 70,
                                                      width: w,
                                                      child: Center(
                                                        child:
                                                            CustomRoundedButton(
                                                          color:
                                                              AppColors.primary,
                                                          textColor:
                                                              Colors.white,
                                                          splashColor: Colors
                                                              .white
                                                              .withOpacity(0.2),
                                                          disabledColor:
                                                              AppColors
                                                                  .easternBlue
                                                                  .withOpacity(
                                                                      0.2),
                                                          // height: 50,
                                                          width: w,
                                                          text: "next".tr,
                                                          textStyle: AppTextStyle
                                                              .boldWhite14
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          onTap: () {
                                                            Get.toNamed(
                                                              Routes
                                                                  .CONFIRMATION,
                                                              // arguments: item.doctor, controller.arguments.cCategory],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ).paddingOnly(
                                                        bottom: 20, top: 8),
                                                  ],
                                                )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          right: 20,
                          left: 20,
                          child: BottomBarView(isHomeScreen: false))
                    ],
                  ),
                );
              },
            )));
  }
  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar("book".tr),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                // height: 160,
                // TODO make it better using some utils func
                height: controller.hasError.value
                    ? MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom
                    : 160,
                width: Get.width,
                child: Center(
                  child: PagedListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                    pagingController: controller.pagingController,
                    separatorBuilder: (c, i) {
                      return SizedBox(width: 30);
                    },
                    builderDelegate: PagedChildBuilderDelegate<ScheduleData>(
                        itemBuilder: (context, item, index) {
                          // var item = controller.latestVideos[index];

                          return Obx(
                            () => DateSquare(
                              length: item.times.length,
                              date: item.date,
                              color: controller.selectedDate() ==
                                      item.date.toIso8601String()
                                  ? Get.theme.primaryColor
                                  : Get.theme.primaryColor.withOpacity(0.15),
                            ).onTap(
                              () {
                                controller.changeSlectedDate(item.date, index);
                              },
                            ),
                          );
                        },
                        //TODO URGENT Change bellow with shimmer and so on
                        // noMoreItemsIndicatorBuilder: (_) => PagingNoMoreItemList(),
                        noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(
                            title: "doctor_has_not_empty_slots"
                                .trArgs([controller.doctor()?.fullname ?? ""]),
                            subTitle:
                                "all_doctor_appointments_free_slots_are_full"
                                    .tr),
                        firstPageErrorIndicatorBuilder: (context) =>
                            PagingErrorView(
                              controller: controller.pagingController,
                            ),
                        firstPageProgressIndicatorBuilder: (_) {
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.dateChilds() ?? <Widget>[Container()],
              ).paddingHorizontal(30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Hero(
          tag: "bot_but",
          child: Center(
            child: Obx(() => CustomRoundedButton(
                  color: AppColors.easternBlue,
                  textColor: Colors.white,
                  splashColor: Colors.white.withOpacity(0.2),
                  disabledColor: AppColors.easternBlue.withOpacity(0.2),
                  // height: 50,
                  width: 250,
                  text: "next".tr,
                  onTap: controller.isTimePicked()
                      ? () {
                          BookingController.to.selectedDate(
                              DateTime.tryParse(controller.selectedTime()));
                          Get.toNamed(Routes.PATIENT_INFO);
                        }
                      : null,
                )),
          ),
        ),
      ).paddingOnly(bottom: 20, top: 8),
    );
  }*/
}
