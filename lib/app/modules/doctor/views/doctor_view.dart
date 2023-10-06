import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/ad_view.dart';
import 'package:doctor_yab/app/components/address_show_on_map.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

import 'package:get/get.dart';

import '../../../components/full_screen_image_viewer.dart';
import '../../../data/ApiConsts.dart';
import '../controllers/doctor_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class DoctorView extends GetView<DoctorController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: false,
      child: Scaffold(
        appBar: AppAppBar.specialAppBar(
            'doctor_profile'
                .trArgs([Utils.getTextOfBlaBla(controller.doctor.type)]),
            backgroundColor: Colors.transparent),
        body: Obx(
          () => SizedBox(
            child: controller.doctorFullData() == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
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
                        child: Column(children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.black,
                                  // height: 65,
                                  // width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.lightGrey),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.doctor.photo,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              controller.doctor.fullname ??
                                                  " ${controller.doctor.name ?? ""} ${controller.doctor.lname ?? ""}",
                                              style: AppTextTheme.h(15)
                                                  .copyWith(
                                                      color: AppColors.black2),
                                            ),
                                          ),
                                          if (controller.doctor.verfied ??
                                              false)
                                            Icon(
                                              Icons.verified,
                                              color: AppColors.verified,
                                            ).paddingHorizontal(6),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        controller.doctor.category.title ?? "",
                                        style: AppTextTheme.b(14)
                                            .copyWith(color: AppColors.lgt2),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 17,
                                            initialRating: controller
                                                .doctor.stars
                                                .toDouble(),
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
                                            '5.0 - 10 Reviews',
                                            style: AppTextTheme.b(13).copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Builder(
                                        builder: (context) {
                                          var flagExp = (controller
                                                      .doctorFullData()
                                                      .exp !=
                                                  null &&
                                              controller
                                                      .doctorFullData()
                                                      .exp
                                                      .length >
                                                  0 &&
                                              !controller
                                                  .doctorFullData()
                                                  .exp
                                                  .any((element) =>
                                                      element.year == null));
                                          var flagFee = (controller
                                                      .doctorFullData()
                                                      .fee !=
                                                  null &&
                                              controller.doctorFullData().fee !=
                                                  "");
                                          var flagAll = (flagFee || flagExp);
                                          return Row(
                                            children: [
                                              if (flagFee)
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 5),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primary),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Text(
                                                        "${"fee".tr}  ${controller.doctorFullData().fee} ${"afn".tr}",
                                                        style: AppTextTheme.m(
                                                                13)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              if (flagExp)
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 2),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primary),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Text(
                                                        " ${"work_experiance".tr} ${controller.doctorFullData().exp.map((e) {
                                                              if (e.year !=
                                                                  null)
                                                                return e.year;
                                                            }).toList().fold(0, (p, c) => p + c).toString()} ${"years".tr}",
                                                        style: AppTextTheme.m(
                                                                13)
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
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
                          controller.doctor.address == null
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'doctor_addres'.tr,
                                          style: AppTextTheme.b(16).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    controller.doctor.address == null
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              Utils.openGoogleMaps(
                                                  controller.doctor?.geometry
                                                          ?.coordinates[1] ??
                                                      0.0,
                                                  controller.doctor?.geometry
                                                          ?.coordinates[0] ??
                                                      0.0);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    color: AppColors.primary),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.map),
                                                    Spacer(),
                                                    Text(
                                                      controller.doctor.address,
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
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    controller.doctor.address == null
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              Utils.openGoogleMaps(
                                                  controller.doctor?.geometry
                                                          ?.coordinates[1] ??
                                                      0.0,
                                                  controller.doctor?.geometry
                                                          ?.coordinates[0] ??
                                                      0.0);
                                            },
                                            child: Container(
                                              height: h * 0.2,
                                              width: w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          AppImages.fullMap),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                  ],
                                ),
                          controller.doctor.tags.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'doctors_tags'.tr,
                                          style: AppTextTheme.b(16).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    controller.doctor.tags.isEmpty
                                        ? SizedBox()
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: AppColors.primary),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.certificate),
                                                  Spacer(),
                                                  Text(
                                                    controller.doctor.tags
                                                        .join(",".tr + " "),
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
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                          controller.doctor.detail != null &&
                                  controller.doctor.detail != ""
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'about_doctor'.tr,
                                          style: AppTextTheme.b(16).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    controller.doctor.detail != null &&
                                            controller.doctor.detail != ""
                                        ? SizedBox()
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: AppColors.primary),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.circleInfo),
                                                  Spacer(),
                                                  Text(
                                                    controller.doctor.detail
                                                        .trim(),
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
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                          Container(
                            height: 70,
                            child: Hero(
                              tag: "bot_but",
                              child: Center(
                                child: CustomRoundedButton(
                                  color: AppColors.primary,
                                  textColor: Colors.white,
                                  splashColor: Colors.white.withOpacity(0.2),
                                  disabledColor:
                                      AppColors.easternBlue.withOpacity(0.2),
                                  // height: 50,
                                  width: MediaQuery.of(context).size.width > 400
                                      ? 300
                                      : MediaQuery.of(context).size.width *
                                          75 /
                                          100,
                                  text: "book_now".tr,
                                  onTap: () {
                                    if (controller.doctor.id == null ||
                                        controller.doctor.category == null) {
                                      // AppGetDialog.show(
                                      //     middleText: "doctor_id_or_category_is_null".tr);

                                      AppGetDialog
                                          .showSeleceDoctorCategoryDialog(
                                              controller.doctor,
                                              onChange: (cat) {
                                        BookingController.to
                                            .selectedDoctor(controller.doctor);
                                        BookingController.to
                                            .selectedCategory(cat);
                                        Get.toNamed(
                                          Routes.BOOK,
                                          // arguments: [item.doctor, controller.arguments.cCategory],
                                        );
                                      });
                                      return;
                                    }
                                    BookingController.to
                                        .selectedDoctor(controller.doctor);
                                    BookingController.to.selectedCategory(
                                        Category(
                                            id: controller.doctor.category.id));
                                    Get.toNamed(
                                      Routes.BOOK,
                                      // arguments: [item.doctor, controller.arguments.cCategory],
                                    );

                                    //
                                    //    AppGetDialog.showSeleceDoctorCategoryDialog(
                                    //     controller.doctor, onChange: (cat) {
                                    //   BookingController.to.selectedDoctor(controller.doctor);
                                    //   BookingController.to.selectedCategory(cat);
                                    //   Get.toNamed(
                                    //     Routes.BOOK,
                                    //     // arguments: [item.doctor, controller.arguments.cCategory],
                                    //   );
                                    // });
                                  },
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
                          // Row(
                          //   children: [
                          //     _profileImge(img: controller.doctor.photo),
                          //     SizedBox(width: 20),
                          //     Flexible(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           FittedBox(
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Text(
                          //                   controller.doctor.fullname ??
                          //                       " ${controller.doctor.name ?? ""} ${controller.doctor.lname ?? ""}",
                          //                   style: AppTextTheme.h(15).copyWith(
                          //                       color: AppColors.black2),
                          //                 ),
                          //                 if (controller.doctor.verfied ?? false)
                          //                   Icon(
                          //                     Icons.verified,
                          //                     color: AppColors.verified,
                          //                   ).paddingHorizontal(6),
                          //               ],
                          //             ).paddingOnly(top: 8, bottom: 2),
                          //           ),
                          //           Text(
                          //             controller.doctor.category?.title ?? "",
                          //             style: AppTextTheme.r(14).copyWith(
                          //                 color: AppColors.lgt2, height: 1.0),
                          //           ),
                          //           SizedBox(height: 2),
                          //           RatingBar.builder(
                          //             ignoreGestures: true,
                          //             itemSize: 15,
                          //             initialRating: double.tryParse(controller
                          //                     .doctor.stars
                          //                     ?.toStringAsFixed(1)) ??
                          //                 0.0,
                          //             // minRating: 1,
                          //             direction: Axis.horizontal,
                          //             allowHalfRating: true,
                          //             itemCount: 5,
                          //             itemPadding:
                          //                 EdgeInsets.symmetric(horizontal: 1.0),
                          //             itemBuilder: (context, _) => Icon(
                          //               Icons.star,
                          //               color: Colors.amber,
                          //               // size: 10,
                          //             ),
                          //             onRatingUpdate: (rating) {
                          //               print(rating);
                          //             },
                          //           ),
                          //           SizedBox(height: 4),
                          //           Text(
                          //             "overal_rating_from_visitors".trArgs([
                          //               controller
                          //                       .doctorFullData()
                          //                       .countOfPatient
                          //                       ?.toString() ??
                          //                   ""
                          //             ]),
                          //             style: AppTextTheme.l(14).copyWith(
                          //                 color: AppColors.lgt2, height: 1.0),
                          //           ),
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ).paddingAll(24).sliverBox,
                          // () {
                          //   var flagExp =
                          //       (controller.doctorFullData().exp != null &&
                          //           controller.doctorFullData().exp.length > 0 &&
                          //           !controller
                          //               .doctorFullData()
                          //               .exp
                          //               .any((element) => element.year == null));
                          //   var flagFee =
                          //       (controller.doctorFullData().fee != null &&
                          //           controller.doctorFullData().fee != "");
                          //   var flagAll = (flagFee || flagExp);
                          //   if (flagAll) {
                          //     return Wrap(
                          //       alignment: WrapAlignment.center,
                          //       spacing: 10,
                          //       runSpacing: 10,
                          //       children: [
                          //         if (flagFee)
                          //           _feeOrExpChip(
                          //               Icon(FontAwesome.money),
                          //               "fee".tr,
                          //               controller.doctorFullData().fee,
                          //               "afn".tr),
                          //         if (flagExp)
                          //           _feeOrExpChip(
                          //               Icon(SimpleLineIcons.badge),
                          //               "work_experiance".tr,
                          //               controller
                          //                   .doctorFullData()
                          //                   .exp
                          //                   .map((e) {
                          //                     if (e.year != null) return e.year;
                          //                   })
                          //                   .toList()
                          //                   .fold(0, (p, c) => p + c)
                          //                   .toString(),
                          //               "years".tr),
                          //         // _feeOrExpChip(),
                          //       ],
                          //     )
                          //         .paddingHorizontal(6)
                          //         .paddingOnly(bottom: 16)
                          //         .sliverBox;
                          //   }
                          //
                          //   return SizedBox().sliverBox;
                          // }(),
                          // SizedBox(height: 10).sliverBox,
                          // if (controller.doctor?.geometry?.coordinates != null)
                          //   if ((controller
                          //               .doctor?.geometry?.coordinates?.length ??
                          //           0) >
                          //       1)
                          //     _buildMiniSection(
                          //       'doctor_addres'.tr,
                          //       AddressShowOnMap(
                          //         address: controller.doctor.address ?? "",
                          //         lat: controller
                          //                 .doctor?.geometry?.coordinates[1] ??
                          //             0.0,
                          //         lon: controller
                          //                 .doctor?.geometry?.coordinates[0] ??
                          //             0.0,
                          //       ),
                          //     ).sliverBox,
                          // if (controller.doctor.tags.length > 0)
                          //   _buildMiniSection(
                          //     'doctors_tags'.tr,
                          //     Text(
                          //       controller.doctor.tags.join(",".tr + " "),
                          //       style: AppTextTheme.r(12.5),
                          //     ),
                          //   ).sliverBox,
                          // if (controller.doctor.detail != null &&
                          //     controller.doctor.detail != "")
                          //   _buildMiniSection(
                          //     'about'.tr +
                          //         Utils.getTextOfBlaBla(controller.doctor.type),
                          //     ReadMoreText(
                          //       controller.doctor.detail.trim() ?? "",
                          //       trimLines: 2,
                          //       colorClickableText: AppColors.primary,
                          //       trimMode: TrimMode.Line,
                          //       trimCollapsedText: 'show_more'.tr,
                          //       trimExpandedText: 'show_less'.tr,
                          //       style: AppTextTheme.r(12.5),
                          //     ),
                          //   ).sliverBox,
                          // AdView().sliverBox, // Row(
                          //   children: [
                          //     _profileImge(img: controller.doctor.photo),
                          //     SizedBox(width: 20),
                          //     Flexible(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           FittedBox(
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Text(
                          //                   controller.doctor.fullname ??
                          //                       " ${controller.doctor.name ?? ""} ${controller.doctor.lname ?? ""}",
                          //                   style: AppTextTheme.h(15).copyWith(
                          //                       color: AppColors.black2),
                          //                 ),
                          //                 if (controller.doctor.verfied ?? false)
                          //                   Icon(
                          //                     Icons.verified,
                          //                     color: AppColors.verified,
                          //                   ).paddingHorizontal(6),
                          //               ],
                          //             ).paddingOnly(top: 8, bottom: 2),
                          //           ),
                          //           Text(
                          //             controller.doctor.category?.title ?? "",
                          //             style: AppTextTheme.r(14).copyWith(
                          //                 color: AppColors.lgt2, height: 1.0),
                          //           ),
                          //           SizedBox(height: 2),
                          //           RatingBar.builder(
                          //             ignoreGestures: true,
                          //             itemSize: 15,
                          //             initialRating: double.tryParse(controller
                          //                     .doctor.stars
                          //                     ?.toStringAsFixed(1)) ??
                          //                 0.0,
                          //             // minRating: 1,
                          //             direction: Axis.horizontal,
                          //             allowHalfRating: true,
                          //             itemCount: 5,
                          //             itemPadding:
                          //                 EdgeInsets.symmetric(horizontal: 1.0),
                          //             itemBuilder: (context, _) => Icon(
                          //               Icons.star,
                          //               color: Colors.amber,
                          //               // size: 10,
                          //             ),
                          //             onRatingUpdate: (rating) {
                          //               print(rating);
                          //             },
                          //           ),
                          //           SizedBox(height: 4),
                          //           Text(
                          //             "overal_rating_from_visitors".trArgs([
                          //               controller
                          //                       .doctorFullData()
                          //                       .countOfPatient
                          //                       ?.toString() ??
                          //                   ""
                          //             ]),
                          //             style: AppTextTheme.l(14).copyWith(
                          //                 color: AppColors.lgt2, height: 1.0),
                          //           ),
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ).paddingAll(24).sliverBox,
                          // () {
                          //   var flagExp =
                          //       (controller.doctorFullData().exp != null &&
                          //           controller.doctorFullData().exp.length > 0 &&
                          //           !controller
                          //               .doctorFullData()
                          //               .exp
                          //               .any((element) => element.year == null));
                          //   var flagFee =
                          //       (controller.doctorFullData().fee != null &&
                          //           controller.doctorFullData().fee != "");
                          //   var flagAll = (flagFee || flagExp);
                          //   if (flagAll) {
                          //     return Wrap(
                          //       alignment: WrapAlignment.center,
                          //       spacing: 10,
                          //       runSpacing: 10,
                          //       children: [
                          //         if (flagFee)
                          //           _feeOrExpChip(
                          //               Icon(FontAwesome.money),
                          //               "fee".tr,
                          //               controller.doctorFullData().fee,
                          //               "afn".tr),
                          //         if (flagExp)
                          //           _feeOrExpChip(
                          //               Icon(SimpleLineIcons.badge),
                          //               "work_experiance".tr,
                          //               controller
                          //                   .doctorFullData()
                          //                   .exp
                          //                   .map((e) {
                          //                     if (e.year != null) return e.year;
                          //                   })
                          //                   .toList()
                          //                   .fold(0, (p, c) => p + c)
                          //                   .toString(),
                          //               "years".tr),
                          //         // _feeOrExpChip(),
                          //       ],
                          //     )
                          //         .paddingHorizontal(6)
                          //         .paddingOnly(bottom: 16)
                          //         .sliverBox;
                          //   }
                          //
                          //   return SizedBox().sliverBox;
                          // }(),
                          // SizedBox(height: 10).sliverBox,
                          // if (controller.doctor?.geometry?.coordinates != null)
                          //   if ((controller
                          //               .doctor?.geometry?.coordinates?.length ??
                          //           0) >
                          //       1)
                          //     _buildMiniSection(
                          //       'doctor_addres'.tr,
                          //       AddressShowOnMap(
                          //         address: controller.doctor.address ?? "",
                          //         lat: controller
                          //                 .doctor?.geometry?.coordinates[1] ??
                          //             0.0,
                          //         lon: controller
                          //                 .doctor?.geometry?.coordinates[0] ??
                          //             0.0,
                          //       ),
                          //     ).sliverBox,
                          // if (controller.doctor.tags.length > 0)
                          //   _buildMiniSection(
                          //     'doctors_tags'.tr,
                          //     Text(
                          //       controller.doctor.tags.join(",".tr + " "),
                          //       style: AppTextTheme.r(12.5),
                          //     ),
                          //   ).sliverBox,
                          // if (controller.doctor.detail != null &&
                          //     controller.doctor.detail != "")
                          //   _buildMiniSection(
                          //     'about'.tr +
                          //         Utils.getTextOfBlaBla(controller.doctor.type),
                          //     ReadMoreText(
                          //       controller.doctor.detail.trim() ?? "",
                          //       trimLines: 2,
                          //       colorClickableText: AppColors.primary,
                          //       trimMode: TrimMode.Line,
                          //       trimCollapsedText: 'show_more'.tr,
                          //       trimExpandedText: 'show_less'.tr,
                          //       style: AppTextTheme.r(12.5),
                          //     ),
                          //   ).sliverBox,
                          // AdView().sliverBox,
                        ]),
                      ),
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: BottomBarView(isHomeScreen: false),
        // body: SingleChildScrollView(
        //   physics: BouncingScrollPhysics(),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 16),
        //       DoctorListTileItem(
        //         controller.doctor,
        //         listTileMode: ListTileMode.profile,
        //         trailing: controller.doctor.phone == null
        //             ? null
        //             : IconButton(
        //                 icon: Icon(
        //                   Icons.phone,
        //                   color: Colors.black,
        //                 ),
        //                 onPressed: () => Utils.openPhoneDialer(
        //                   context,
        //                   controller.doctor.phone,
        //                 ),
        //               ).paddingEnd(context, 10).paddingStart(context, 10),
        //       ),
        //       //*
        //       Row(
        //         children: [
        //           Container(
        //             child: SizedBox(
        //               width: 100,
        //               height: 100,
        //               child: Container(
        //                 color: AppColors.lgt,
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     FittedBox(
        //                       child: Text(
        //                         '${(controller.doctor.stars * 20).toStringAsFixed(0)}%',
        //                         style: AppTextTheme.b(32).copyWith(height: 1.0),
        //                       ),
        //                     ),
        //                     FittedBox(
        //                       child: Text(
        //                         'pat_satisfiction'.tr,
        //                         style: AppTextTheme.m(10),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ).radiusAll(20),
        //             ),
        //           ).paddingAll(10),
        //           //*
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 _buildLinePercent(
        //                   controller.doctor.treatment?.toDouble() ?? 0.0,
        //                   "treatment".trArgs(
        //                       [Utils.getTextOfBlaBla(controller.doctor.type)]),
        //                 ).paddingVertical(5),
        //                 _buildLinePercent(
        //                   controller.doctor.knowledge?.toDouble() ?? 0.0,
        //                   "knowledge".tr,
        //                 ).paddingVertical(5),
        //                 _buildLinePercent(
        //                   controller.doctor.cleaning?.toDouble() ?? 0.0,
        //                   "cleaning".tr,
        //                 ).paddingVertical(5),
        //               ],
        //             )
        //                 .paddingEnd(context, 30)
        //                 .paddingStart(context, 6)
        //                 .paddingVertical(45),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 20),
        //       if (controller.doctor?.geometry?.coordinates != null)
        //         if ((controller.doctor?.geometry?.coordinates?.length ?? 0) > 1)
        //           _buildMiniSection(
        //             'doctor_addres'.tr,
        //             AddressShowOnMap(
        //               address: controller.doctor.address ?? "",
        //               lat: controller.doctor?.geometry?.coordinates[1] ?? 0.0,
        //               lon: controller.doctor?.geometry?.coordinates[0] ?? 0.0,
        //             ),
        //           ),
        //       if (controller.doctor.tags.length > 0)
        //         _buildMiniSection(
        //           'doctors_tags'.tr,
        //           Text(
        //             controller.doctor.tags.join(",".tr + " "),
        //             style: AppTextTheme.r(12.5),
        //           ),
        //         ),
        //       if (controller.doctor.detail != null &&
        //           controller.doctor.detail != "")
        //         _buildMiniSection(
        //           'about'.tr + Utils.getTextOfBlaBla(controller.doctor.type),
        //           Text(
        //             controller.doctor.detail ?? "",
        //             style: AppTextTheme.r(12.5),
        //           ),
        //         ),
        //       AdView(),
        //     ],
        //   ).paddingHorizontal(10),
        // ),

        // bottomNavigationBar: Container(
        //   height: 70,
        //   child: Hero(
        //     tag: "bot_but",
        //     child: Center(
        //       child: CustomRoundedButton(
        //         color: AppColors.easternBlue,
        //         textColor: Colors.white,
        //         splashColor: Colors.white.withOpacity(0.2),
        //         disabledColor: AppColors.easternBlue.withOpacity(0.2),
        //         // height: 50,
        //         width: MediaQuery.of(context).size.width > 400
        //             ? 300
        //             : MediaQuery.of(context).size.width * 75 / 100,
        //         text: "book_now".tr,
        //         onTap: () {
        //           if (controller.doctor.id == null ||
        //               controller.doctor.category == null) {
        //             // AppGetDialog.show(
        //             //     middleText: "doctor_id_or_category_is_null".tr);
        //
        //             AppGetDialog.showSeleceDoctorCategoryDialog(
        //                 controller.doctor, onChange: (cat) {
        //               BookingController.to.selectedDoctor(controller.doctor);
        //               BookingController.to.selectedCategory(cat);
        //               Get.toNamed(
        //                 Routes.BOOK,
        //                 // arguments: [item.doctor, controller.arguments.cCategory],
        //               );
        //             });
        //             return;
        //           }
        //           BookingController.to.selectedDoctor(controller.doctor);
        //           BookingController.to.selectedCategory(
        //               Category(id: controller.doctor.category.id));
        //           Get.toNamed(
        //             Routes.BOOK,
        //             // arguments: [item.doctor, controller.arguments.cCategory],
        //           );
        //
        //           //
        //           //    AppGetDialog.showSeleceDoctorCategoryDialog(
        //           //     controller.doctor, onChange: (cat) {
        //           //   BookingController.to.selectedDoctor(controller.doctor);
        //           //   BookingController.to.selectedCategory(cat);
        //           //   Get.toNamed(
        //           //     Routes.BOOK,
        //           //     // arguments: [item.doctor, controller.arguments.cCategory],
        //           //   );
        //           // });
        //         },
        //         leading: Row(
        //           children: [
        //             SizedBox(width: 8),
        //             SvgPicture.asset("assets/svg/date_range-24px.svg"),
        //             Spacer(),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ).paddingOnly(bottom: 20, top: 8),
      ),
    );
  }

  Container _feeOrExpChip(
      Widget icon, String startText, String text, String endText) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        border: Border.all(
          width: 1.0,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // icon,
          // SizedBox(width: 6),
          Text(startText),
          SizedBox(width: 6),
          Text(text),
          SizedBox(width: 6),
          Text(endText),
        ],
      ),
    );
  }

  Widget _profileImge({double radius, String img}) {
    return CircleAvatar(
      radius: radius ?? 50,
      child: Container(
          // color: Colors.black,
          // height: 65,
          // width: 65,
          child:
              //   Image.network(
              //     "${ApiConsts.hostUrl}${doctor.photo}",
              //     fit: BoxFit.cover,
              //   ),
              // ).radiusAll(imageRadius ?? 20),
              CachedNetworkImage(
        imageUrl: "${ApiConsts.hostUrl}$img",
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
        fit: BoxFit.cover,
      )).radiusAll(100).onTap(() {
        Get.to(
          () => FullScreenImageViewr("${ApiConsts.hostUrl}$img"),
          transition: Transition.topLevel,
        );
      }),
    );
  }

  Widget _buildLinePercent(double progress, String title) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: AppTextTheme.b(9.5),
                ),
                Spacer(),
                Text(
                  progress.toStringAsFixed(0) + "%",
                  style: AppTextTheme.b(9.5),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: constraints.maxWidth,
                  color: AppColors.lgt,
                  // constraints: BoxConstraints.expand(),
                ),
                Container(
                  height: 4,
                  width: constraints.maxWidth * progress / 100,
                  color: AppColors.easternBlue,
                  // constraints: BoxConstraints.expand(),
                ),
              ],
            ).radiusAll(10),
          ],
        );
      },
    );
  }

  Widget _buildMiniSection(String title, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.b(15.5),
        ),
        SizedBox(height: 10),
        child,
        SizedBox(height: 10),
      ],
    ).paddingExceptTop(16);
  }
}
