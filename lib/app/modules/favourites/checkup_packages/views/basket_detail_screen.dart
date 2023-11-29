import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_sub_details_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/appointment_detail_screen.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BasketDetailScreen extends GetView<CheckupPackagesController> {
  BasketDetailScreen({Key key}) : super(key: key);
  CheckupPackagesController checkupPackagesController = Get.find()
    ..getPackageHistory();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "basket_details".tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.boldWhite16,
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.76,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: GetBuilder<CheckupPackagesController>(
                      builder: (controller) {
                        return Container(
                          height: h,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 20, bottom: 20),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: controller.historyLoading == true
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.3),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          )),
                                        )
                                      : controller.packageHistory.isEmpty
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.25),
                                              child: Center(
                                                  child: Text(
                                                      "no_result_found".tr)),
                                            )
                                          : Column(
                                              children: [
                                                ...List.generate(
                                                    controller.packageHistory
                                                        .length, (index) {
                                                  var _d = controller
                                                              .packageHistory[
                                                                  index]
                                                              .visitDate ==
                                                          null
                                                      ? DateTime.now()
                                                      : DateTime.parse(controller
                                                              .packageHistory[
                                                                  index]
                                                              .visitDate
                                                              .toString())
                                                          ?.toLocal();
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        width: w,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      Offset(
                                                                          0, 4),
                                                                  blurRadius: 4,
                                                                  color: AppColors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.25))
                                                            ]),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .doc,
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    "package_name"
                                                                        .tr,
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    " ${controller.packageHistory[index].packageId.title ?? ''}",
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Spacer(),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .red
                                                                            .withOpacity(
                                                                                0.1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "${_d.toPersianDateStr(
                                                                            strDay:
                                                                                false,
                                                                            strMonth:
                                                                                true,
                                                                            useAfghaniMonthName:
                                                                                true,
                                                                          )}",
                                                                          // "${DateFormat("dd.MM.yyyy").format(DateTime.parse(controller.packageHistory[index].visitDate.toString() == null ? DateTime.now().toString() : controller.packageHistory[index].visitDate.toString()))}",
                                                                          style: AppTextStyle
                                                                              .mediumPrimary12
                                                                              .copyWith(color: AppColors.red),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .profile2,
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    "hospital_name"
                                                                        .tr,
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    " ${controller.packageHistory[index].hospitalId.name ?? ""}",
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .calendar,
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    "${_d.toPersianDateStr(
                                                                      strDay:
                                                                          false,
                                                                      strMonth:
                                                                          true,
                                                                      useAfghaniMonthName:
                                                                          true,
                                                                    )}",
                                                                    // "${DateFormat().add_yMMMMEEEEd().format(DateTime.parse(controller.packageHistory[index].visitDate.toString() == null ? DateTime.now().toString() : controller.packageHistory[index].visitDate.toString()))}",
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Spacer(),
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .clock,
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "${DateFormat("HH.MM").format(DateTime.parse(controller.packageHistory[index].visitDate.toString() == null ? DateTime.now().toString() : controller.packageHistory[index].visitDate.toString()))}",
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .currency_exchange,
                                                                    size: 17,
                                                                    color: AppColors
                                                                        .lightBlack2,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    "price".tr,
                                                                    style: AppTextStyle
                                                                        .boldBlack16
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    " ${"${controller.packageHistory[index].packageId.price}" ?? ""}",
                                                                    style: AppTextStyle
                                                                        .boldBlack16
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      AppImages
                                                                          .chat,
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    "You review on this service",
                                                                    style: AppTextStyle
                                                                        .boldBlack10
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.lightBlack2,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Spacer(),
                                                                  RatingBar
                                                                      .builder(
                                                                    ignoreGestures:
                                                                        true,
                                                                    itemSize:
                                                                        17,
                                                                    initialRating:
                                                                        double.parse(
                                                                            "${controller.packageHistory[index].packageId.averageRating}"),
                                                                    // minRating: 1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding:
                                                                        EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                1.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      // size: 10,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
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
                                                          Get.to(
                                                              BasketSubDetailScreen(
                                                            history: controller
                                                                    .packageHistory[
                                                                index],
                                                          ));
                                                        },
                                                        child: Container(
                                                          width: w,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .primary,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    offset:
                                                                        Offset(0,
                                                                            4),
                                                                    blurRadius:
                                                                        4,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.25))
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Center(
                                                              child: Text(
                                                                "see_details"
                                                                    .tr,
                                                                style: AppTextStyle
                                                                    .boldWhite10,
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
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  child: BottomBarView(
                                    isHomeScreen: false,
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
      ),
    );
  }
}
