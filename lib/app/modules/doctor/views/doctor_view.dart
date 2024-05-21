import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../data/ApiConsts.dart';
import '../controllers/doctor_controller.dart';

class DoctorView extends GetView<DoctorController> {
  List tab = ["doctor_information".tr, "reviews".tr];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.specialAppBar(
          'doctor_details'.tr,
          backgroundColor: Colors.transparent,
          // action: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.toNamed(Routes.NOTIFICATION);
          //     },
          //     child: SvgPicture.asset(
          //       AppImages.blackBell,
          //       height: 24,
          //       width: 24,
          //     ),
          //   ),
          // ),
        ),
        body: Obx(() {
          return Container(
            height: h,
            // color: AppColors.red,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    height: h * 0.77,
                    // padding: EdgeInsets.symmetric(vertical: 10),
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
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                                      "${ApiConsts.hostUrl}${controller.doctor!.photo}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 10),
                                    Text(
                                      "${controller.doctor?.fullname ?? ""}",
                                      style: AppTextTheme.h(12)
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "${controller.doctor?.speciality}",
                                      style: AppTextTheme.b(11).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                    ),
                                    SizedBox(height: 2),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.REVIEW, arguments: [
                                          "Doctor_Review",
                                          controller.doctor
                                        ]);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 17,
                                            initialRating: double.parse(controller
                                                            .doctor
                                                            ?.averageRatings ==
                                                        null
                                                    ? "0.0"
                                                    : controller.doctor
                                                            ?.averageRatings
                                                            .toString() ??
                                                        '0.0') ??
                                                0.0,
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
                                            '(${controller.doctor?.totalFeedbacks == null ? 0 : controller.doctor?.totalFeedbacks ?? 0}) ${'reviews'.tr}',
                                            style: AppTextTheme.b(11).copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Builder(
                                      builder: (context) {
                                        // var flagExp =
                                        //     (controller.doctorFullData().exp !=
                                        //             null &&
                                        //         controller
                                        //                 .doctorFullData()
                                        //                 .exp
                                        //                 .length >
                                        //             0 &&
                                        //         !controller
                                        //             .doctorFullData()
                                        //             .exp
                                        //             .any((element) =>
                                        //                 element.year == null));
                                        // var flagFee = (controller
                                        //             .doctorFullData()
                                        //             .fee !=
                                        //         null &&
                                        //     controller.doctorFullData().fee != "");
                                        // var flagAll = (flagFee || flagExp);
                                        return Row(
                                          children: [
                                            // if (flagFee)
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: w * 0.02),
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    "${"fee".tr} ${controller.doctor?.fee == "" ? "0" : controller.doctor?.fee ?? "0"} ${"afn".tr}",
                                                    style: AppTextTheme.m(
                                                            w * 0.032)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            // if (flagExp)
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: w * 0.01),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    "${"exp".tr} ${controller.doctor?.totalExperience == null ? "0" : controller.doctor?.totalExperience.toString()} ${"year".tr}",
                                                    style: AppTextTheme.m(
                                                            w * 0.032)
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ) /*Text(
                                                        " ${"work_experiance".tr} ${controller.doctorFullData().exp.map((e) {
                                                              if (e.year != null)
                                                                return e.year;
                                                            }).toList().fold(0, (p, c) => p + c).toString()} ${"years".tr}",
                                                        style: AppTextTheme.m(12)
                                                            .copyWith(
                                                                color: Colors.white),
                                                      )*/
                                                  ,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    )
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              tab.length,
                              (index) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.tabIndex.value = index;
                                        },
                                        child: Container(
                                          width: w * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  controller.tabIndex.value !=
                                                          index
                                                      ? AppColors.white
                                                      : AppColors.primary,
                                              border: Border.all(
                                                  color: AppColors.primary)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Center(
                                              child: Center(
                                                  child: Text(
                                                tab[index],
                                                style: controller
                                                            .tabIndex.value !=
                                                        index
                                                    ? AppTextStyle.boldPrimary10
                                                    : AppTextStyle.boldWhite10,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        controller.tabIndex.value == 0
                            ? Expanded(
                                child: SingleChildScrollView(
                                  // padding: EdgeInsets.only(top: 20),
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      controller.doctor?.address == "" ||
                                              controller.doctor?.address == null
                                          ? SizedBox()
                                          : controller.doctor?.address == "" ||
                                                  controller.doctor?.address ==
                                                      null
                                              ? SizedBox()
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
                                                          'doctor_addres'.tr,
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
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primary),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 6,
                                                            offset:
                                                                Offset(0, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                AppImages.map,
                                                                height: 22,
                                                                width: 22),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              width: Get.width *
                                                                  0.69,
                                                              child: Text(
                                                                "${controller.doctor?.address}",
                                                                style: AppTextStyle
                                                                    .mediumBlack12
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .lightBlack2,
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.015,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Utils.openGoogleMaps(
                                                            controller
                                                                        .doctor
                                                                        ?.geometry
                                                                        ?.coordinates![
                                                                    1] ??
                                                                0.0,
                                                            controller
                                                                    .doctor
                                                                    ?.geometry
                                                                    ?.coordinates![0] ??
                                                                0.0);
                                                      },
                                                      child: Container(
                                                        width: w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color: AppColors
                                                                .primary,
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primary)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Center(
                                                              child: Text(
                                                            "show_in_map".tr,
                                                            style: AppTextStyle
                                                                .boldWhite10
                                                                .copyWith(
                                                              fontSize: 11,
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                      controller.doctor?.tags?.isEmpty ?? true
                                          ? SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: h * 0.015,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.certificate,
                                                        height: 22,
                                                        width: 22),
                                                    Spacer(),
                                                    Container(
                                                        width: w * 0.2,
                                                        child: Divider(
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(0.5),
                                                          height: 3,
                                                        )),
                                                    SizedBox(
                                                      width: w * 0.02,
                                                    ),
                                                    Text(
                                                      'doctors_tags'.tr,
                                                      style: AppTextTheme.b(11)
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
                                                              .withOpacity(0.5),
                                                          height: 3,
                                                        )),
                                                    Spacer(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.015,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 6,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Center(
                                                      child: Text(
                                                        "${controller.doctor?.tags?.join(',') ?? ""}",
                                                        style: AppTextStyle
                                                            .mediumBlack12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .lightBlack2,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      controller.doctor?.detail == "" ||
                                              controller.doctor?.detail == null
                                          ? SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: h * 0.015,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.circleInfo,
                                                        width: 22,
                                                        height: 22),
                                                    Spacer(),
                                                    Container(
                                                        width: w * 0.2,
                                                        child: Divider(
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(0.5),
                                                          height: 3,
                                                        )),
                                                    SizedBox(
                                                      width: w * 0.02,
                                                    ),
                                                    Text(
                                                      'about_doctor'.tr,
                                                      style: AppTextTheme.b(11)
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
                                                              .withOpacity(0.5),
                                                          height: 3,
                                                        )),
                                                    Spacer(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.015,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 6,
                                                        offset: Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Center(
                                                      child: Text(
                                                        "${controller.doctor?.detail ?? ""}",
                                                        style: AppTextStyle
                                                            .mediumBlack12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .lightBlack2,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Container(
                                        height: 70,
                                        width: w,
                                        child: Hero(
                                          tag: "bot_but",
                                          child: Center(
                                            child: CustomRoundedButton(
                                              color: AppColors.primary,
                                              textColor: Colors.white,
                                              splashColor:
                                                  Colors.white.withOpacity(0.2),
                                              disabledColor: AppColors
                                                  .easternBlue
                                                  .withOpacity(0.2),
                                              // height: 50,
                                              width: w,
                                              text: "book_now".tr,
                                              textStyle: AppTextStyle
                                                  .boldWhite14
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                              onTap: () {
                                                Get.toNamed(
                                                  Routes.BOOK,
                                                  arguments: controller.doctor,
                                                );
                                              },
                                              // onTap: () {
                                              //   if (controller.doctor.id == null ||
                                              //       controller.doctor.category ==
                                              //           null) {
                                              //     // AppGetDialog.show(
                                              //     //     middleText: "doctor_id_or_category_is_null".tr);
                                              //
                                              //     AppGetDialog
                                              //         .showSeleceDoctorCategoryDialog(
                                              //             controller.doctor,
                                              //             onChange: (cat) {
                                              //       BookingController.to
                                              //           .selectedDoctor(
                                              //               controller.doctor);
                                              //       BookingController.to
                                              //           .selectedCategory(cat);
                                              //       Get.toNamed(
                                              //         Routes.BOOK,
                                              //         // arguments: [item.doctor, controller.arguments.cCategory],
                                              //       );
                                              //     });
                                              //     return;
                                              //   }
                                              //   BookingController.to.selectedDoctor(
                                              //       controller.doctor);
                                              //   BookingController.to
                                              //       .selectedCategory(Category(
                                              //           id: controller
                                              //               .doctor.category.id));
                                              //   Get.toNamed(
                                              //     Routes.BOOK,
                                              //     // arguments: [item.doctor, controller.arguments.cCategory],
                                              //   );
                                              //
                                              //   //
                                              //   //    AppGetDialog.showSeleceDoctorCategoryDialog(
                                              //   //     controller.doctor, onChange: (cat) {
                                              //   //   BookingController.to.selectedDoctor(controller.doctor);
                                              //   //   BookingController.to.selectedCategory(cat);
                                              //   //   Get.toNamed(
                                              //   //     Routes.BOOK,
                                              //   //     // arguments: [item.doctor, controller.arguments.cCategory],
                                              //   //   );
                                              //   // });
                                              // },
                                              // leading: Row(
                                              //   children: [
                                              //     SizedBox(width: 8),
                                              //     SvgPicture.asset(
                                              //         "assets/svg/date_range-24px.svg"),
                                              //     Spacer(),
                                              //   ],
                                              // ),
                                            ),
                                          ),
                                        ),
                                      ).paddingOnly(bottom: 20, top: 8)
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.015),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(
                                            StatefulBuilder(
                                              builder: (context,
                                                  StateSetter setStates) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  child: Center(
                                                    child: Container(
                                                      // height: Get.height * 0.3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors.white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                                  AppColors
                                                                      .primary,
                                                              controller:
                                                                  controller
                                                                      .comment,
                                                              style: AppTextTheme
                                                                      .b(12)
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5)),
                                                              decoration: InputDecoration(
                                                                  labelText: "comment"
                                                                      .tr,
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
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "doc_manner"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.06,
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
                                                                Text(
                                                                  "doc_skill"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.06,
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
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "doc_cleanness"
                                                                      .tr,
                                                                  style: AppTextStyle
                                                                      .boldPrimary12,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.06,
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
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.addDocFeedback(
                                                                    doctorId: controller
                                                                        .doctor!
                                                                        .datumId
                                                                        .toString(),
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
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          "add_review"
                                                                              .tr,
                                                                          style:
                                                                              AppTextStyle.boldWhite14),
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
                                              borderRadius:
                                                  BorderRadius.circular(3),
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
                                                    style: AppTextStyle
                                                        .boldWhite14),
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
                                                child:
                                                    CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ))
                                            : controller.feedbackData.isEmpty
                                                ? Center(
                                                    child: Text(
                                                        "no_result_found".tr))
                                                : SingleChildScrollView(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    child: Column(
                                                      children: List.generate(
                                                          controller
                                                              .feedbackData
                                                              .length, (index) {
                                                        var d = DateTime.parse(
                                                                controller
                                                                    .feedbackData[
                                                                        index]
                                                                    .createAt
                                                                    .toString())
                                                            .toPersianDateStr(
                                                              strDay: false,
                                                              strMonth: true,
                                                              useAfghaniMonthName:
                                                                  true,
                                                            )
                                                            .trim()
                                                            .split(' ');
                                                        return Padding(
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
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                35,
                                                                            backgroundImage:
                                                                                NetworkImage(
                                                                              "${ApiConsts.hostUrl}${controller.feedbackData[index].photo}",
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                "${d[0]}",
                                                                                style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                              ),
                                                                              Text(
                                                                                " ${d[1]}",
                                                                                style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                              ),
                                                                              Text(
                                                                                " ${d[3]}",
                                                                                style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                5),
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
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Container(
                                                                                  width: Get.width * 0.39,
                                                                                  child: Text(
                                                                                    controller.feedbackData[index].postedBy?.name ?? "",
                                                                                    style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                                  ),
                                                                                ),
                                                                                Spacer(),
                                                                                RatingBar.builder(
                                                                                  ignoreGestures: true,
                                                                                  itemSize: 17,
                                                                                  initialRating: double.parse("${(double.parse(controller.feedbackData[index].satifyRating.toString()) + double.parse(controller.feedbackData[index].cleaningRating.toString()) + double.parse(controller.feedbackData[index].expertiseRating.toString())) / 3}" ?? "0.0"),
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
                                                                              controller.feedbackData[index].comment ?? "",
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
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                      )
                                    ],
                                  ),
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
          );
        }),
      ),
    );
  }
}
