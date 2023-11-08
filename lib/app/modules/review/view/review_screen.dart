import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/review/controller/review_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

class ReviewScreen extends GetView<ReviewController> {
  final String appBarTitle;
  const ReviewScreen({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: false,
      child: Obx(() {
        return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppAppBar.specialAppBar(controller.appBarTitle.value.tr,
                backgroundColor: Colors.transparent,
                action: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SvgPicture.asset(AppImages.blackBell),
                )),
            body: Container(
              height: h,
              // color: AppColors.red,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                                    imageUrl: controller.appBarTitle.value ==
                                            "doctor_reviews"
                                        ? "${ApiConsts.hostUrl}${controller.doctor.photo}"
                                        : controller.appBarTitle.value ==
                                                "pharmacy_reviews"
                                            ? "${ApiConsts.hostUrl}${controller.drugStore.photo}"
                                            : controller.appBarTitle.value ==
                                                    "laboratories_reviews"
                                                ? "${ApiConsts.hostUrl}${controller.labsData.photo}"
                                                : "${ApiConsts.hostUrl}${controller.hospitalData.photo}",
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
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 10),
                                      Text(
                                        controller.appBarTitle.value ==
                                                "doctor_reviews"
                                            ? "${controller.doctor.name ?? ""}"
                                            : controller.appBarTitle.value ==
                                                    "pharmacy_reviews"
                                                ? "${controller.drugStore.name ?? ""}"
                                                : controller.appBarTitle
                                                            .value ==
                                                        "laboratories_reviews"
                                                    ? "${controller.labsData.name ?? ""}"
                                                    : "${controller.hospitalData.name ?? ""}",
                                        style: AppTextTheme.h(12)
                                            .copyWith(color: AppColors.primary),
                                      ),
                                      controller.appBarTitle.value ==
                                              "doctor_reviews"
                                          ? SizedBox(height: 2)
                                          : SizedBox(),
                                      controller.appBarTitle.value ==
                                              "doctor_reviews"
                                          ? Text(
                                              controller.appBarTitle.value ==
                                                      "doctor_reviews"
                                                  ? "${controller.doctor.speciality ?? ''}"
                                                  : "",
                                              style: AppTextTheme.b(11)
                                                  .copyWith(
                                                      color: AppColors.primary
                                                          .withOpacity(0.5)),
                                            )
                                          : SizedBox(),
                                      controller.appBarTitle.value ==
                                              "doctor_reviews"
                                          ? SizedBox(height: 2)
                                          : SizedBox(),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 17,
                                            initialRating: controller
                                                        .appBarTitle.value ==
                                                    "doctor_reviews"
                                                ? double.parse(controller.doctor
                                                            .averageRatings ==
                                                        null
                                                    ? "0.0"
                                                    : controller.doctor
                                                            .averageRatings
                                                            .toString() ??
                                                        "0.0")
                                                : controller.appBarTitle
                                                            .value ==
                                                        "pharmacy_reviews"
                                                    ? double.parse(
                                                        "${controller.drugStore.averageRatings == null ? "0.0" : "${controller.drugStore.averageRatings}"}")
                                                    : controller.appBarTitle
                                                                .value ==
                                                            "laboratories_reviews"
                                                        ? double.parse(
                                                            "${controller.labsData.averageRatings == null ? "0.0" : "${double.parse(controller.labsData.averageRatings.toString())}"}")
                                                        : 0.0,
                                            // minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              // size: 10,
                                            ),
                                            onRatingUpdate: (rating) {
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
                                            controller.appBarTitle.value ==
                                                    "doctor_reviews"
                                                ? '(${controller.doctor.averageRatings == null ? 0 : controller.doctor.totalFeedbacks ?? 0}) Reviews'
                                                : controller.appBarTitle
                                                            .value ==
                                                        "pharmacy_reviews"
                                                    ? '(${controller.drugStore.totalFeedbacks == null ? 0 : controller.drugStore.totalFeedbacks ?? 0}) Reviews'
                                                    : controller.appBarTitle
                                                                .value ==
                                                            "laboratories_reviews"
                                                        ? '(${controller.labsData.totalFeedbacks == null ? 0 : controller.labsData.totalFeedbacks ?? 0}) Reviews'
                                                        : '(0) Reviews',
                                            style: AppTextTheme.b(11).copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
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
                          SizedBox(
                            height: h * 0.015,
                          ),
                          Divider(thickness: 1, color: AppColors.primary),
                          Container(
                            height: h * 0.54,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      StatefulBuilder(
                                        builder:
                                            (context, StateSetter setStates) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Center(
                                              child: Container(
                                                // height: Get.height * 0.3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "add_review".tr,
                                                        style: AppTextStyle
                                                            .boldPrimary16,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextField(
                                                        cursorColor:
                                                            AppColors.primary,
                                                        controller:
                                                            controller.comment,
                                                        style: AppTextTheme.b(
                                                                12)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                        decoration: InputDecoration(
                                                            labelText:
                                                                "comment".tr,
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            labelStyle: AppTextTheme.b(12).copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        4),
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .primary
                                                                        .withOpacity(0.4),
                                                                    width: 2)),
                                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2))),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "cleaningRating"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "satisfyRating"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "expertiseRating"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.05,
                                                                  initialRating:
                                                                      controller
                                                                          .cRating
                                                                          .value,
                                                                  // minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                    // size: 10,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    controller
                                                                        .cRating
                                                                        .value = rating;
                                                                    setStates(
                                                                        () {});
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.05,
                                                                  initialRating:
                                                                      controller
                                                                          .sRating
                                                                          .value,
                                                                  // minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                    // size: 10,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    controller
                                                                        .sRating
                                                                        .value = rating;
                                                                    setStates(
                                                                        () {});
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.05,
                                                                  initialRating:
                                                                      controller
                                                                          .eRating
                                                                          .value,
                                                                  // minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                    // size: 10,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    controller
                                                                        .eRating
                                                                        .value = rating;
                                                                    setStates(
                                                                        () {});
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .addDocFeedback(
                                                                  context:
                                                                      context);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color: AppColors
                                                                  .primary),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            child: Center(
                                                                child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    "add_review"
                                                                        .tr,
                                                                    style: AppTextStyle
                                                                        .boldWhite14),
                                                              ],
                                                            )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // confirm: Text("cooo"),
                                      // actions: <Widget>[Text("aooo"), Text("aooo")],
                                      // cancel: Text("bla bla"),
                                      // content: Text("bla bldddda"),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: AppColors.primary),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: AppColors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("add_review".tr,
                                              style: AppTextStyle.boldWhite14),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Expanded(
                                  child: controller.loading.value == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: AppColors.primary,
                                        ))
                                      : controller.feedbackData.isEmpty &&
                                              controller
                                                  .pharmacyFeedback.isEmpty &&
                                              controller.labsFeedback.isEmpty &&
                                              controller
                                                  .hospitalFeedback.isEmpty
                                          ? Center(
                                              child: Text("no_result_found".tr))
                                          : SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                children: List.generate(
                                                    controller.appBarTitle
                                                                .value ==
                                                            "doctor_reviews"
                                                        ? controller
                                                            .feedbackData.length
                                                        : controller.appBarTitle
                                                                    .value ==
                                                                "pharmacy_reviews"
                                                            ? controller
                                                                .pharmacyFeedback
                                                                .length
                                                            : controller.appBarTitle
                                                                        .value ==
                                                                    "laboratories_reviews"
                                                                ? controller
                                                                    .labsFeedback
                                                                    .length
                                                                : controller
                                                                    .hospitalFeedback
                                                                    .length,
                                                    (index) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                35,
                                                                            backgroundImage:
                                                                                NetworkImage(
                                                                              controller.appBarTitle.value == "doctor_reviews"
                                                                                  ? "${ApiConsts.hostUrl}${controller.feedbackData[index].photo}"
                                                                                  : controller.appBarTitle.value == "pharmacy_reviews"
                                                                                      ? "${ApiConsts.hostUrl}${controller.pharmacyFeedback[index].photo}"
                                                                                      : controller.appBarTitle.value == "laboratories_reviews"
                                                                                          ? "${ApiConsts.hostUrl}${controller.labsFeedback[index].photo}"
                                                                                          : "${ApiConsts.hostUrl}${controller.hospitalFeedback[index].photo}",
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            controller.appBarTitle.value == "doctor_reviews"
                                                                                ? "${DateFormat('dd.MM.yyyy').format(DateTime.parse(controller.feedbackData[index].createAt))}"
                                                                                : controller.appBarTitle.value == "pharmacy_reviews"
                                                                                    ? "${DateFormat('dd.MM.yyyy').format(DateTime.parse(controller.pharmacyFeedback[index].createAt))}"
                                                                                    : controller.appBarTitle.value == "laboratories_reviews"
                                                                                        ? "${DateFormat('dd.MM.yyyy').format(DateTime.parse(controller.labsFeedback[index].createAt))}"
                                                                                        : "${DateFormat('dd.MM.yyyy').format(DateTime.parse(controller.hospitalFeedback[index].createAt))}",
                                                                            style:
                                                                                AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 5),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            // SizedBox(height: 10),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Text(
                                                                                  controller.appBarTitle.value == "doctor_reviews"
                                                                                      ? controller.feedbackData[index].postedBy.name ?? ""
                                                                                      : controller.appBarTitle.value == "pharmacy_reviews"
                                                                                          ? controller.pharmacyFeedback[index].postedBy.name ?? ""
                                                                                          : controller.appBarTitle.value == "laboratories_reviews"
                                                                                              ? controller.labsFeedback[index].postedBy.name ?? ""
                                                                                              : controller.hospitalFeedback[index].postedBy.name ?? "",
                                                                                  style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                                ),
                                                                                Spacer(),
                                                                                RatingBar.builder(
                                                                                  ignoreGestures: true,
                                                                                  itemSize: 17,
                                                                                  initialRating: controller.appBarTitle.value == "doctor_reviews"
                                                                                      ? double.parse("${(double.parse(controller.feedbackData[index].satifyRating.toString()) + double.parse(controller.feedbackData[index].cleaningRating.toString()) + double.parse(controller.feedbackData[index].expertiseRating.toString())) / 3}" ?? "0.0")
                                                                                      : controller.appBarTitle.value == "pharmacy_reviews"
                                                                                          ? double.parse("${(double.parse(controller.pharmacyFeedback[index].satifyRating.toString()) + double.parse(controller.pharmacyFeedback[index].cleaningRating.toString()) + double.parse(controller.pharmacyFeedback[index].expertiseRating.toString())) / 3}" ?? "0.0")
                                                                                          : controller.appBarTitle.value == "laboratories_reviews"
                                                                                              ? double.parse(controller.labsFeedback[index].rating)
                                                                                              : double.parse("${(double.parse(controller.hospitalFeedback[index].satifyRating.toString()) + double.parse(controller.hospitalFeedback[index].cleaningRating.toString()) + double.parse(controller.hospitalFeedback[index].expertiseRating.toString())) / 3}" ?? "0.0"),
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
                                                                            SizedBox(height: 2),
                                                                            ExpandableText(
                                                                              controller.appBarTitle.value == "doctor_reviews"
                                                                                  ? controller.feedbackData[index].comment ?? ""
                                                                                  : controller.appBarTitle.value == "pharmacy_reviews"
                                                                                      ? controller.pharmacyFeedback[index].comment ?? ""
                                                                                      : controller.appBarTitle.value == "laboratories_reviews"
                                                                                          ? controller.labsFeedback[index].comment ?? ""
                                                                                          : controller.hospitalFeedback[index].comment ?? "",
                                                                              expandText: 'Read more',
                                                                              collapseText: 'Read less',
                                                                              maxLines: 3,
                                                                              linkColor: AppColors.primary,
                                                                              style: AppTextStyle.boldPrimary11.copyWith(fontWeight: FontWeight.w500, color: AppColors.primary.withOpacity(0.5)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                  thickness: 1,
                                                                  color: AppColors
                                                                      .primary),
                                                            ],
                                                          ),
                                                        )),
                                              ),
                                            ),
                                )
                              ],
                            ),
                          )
                        ]),
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
            ));
      }),
    );
  }
}
