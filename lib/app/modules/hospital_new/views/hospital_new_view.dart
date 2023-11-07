import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';

import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/review/view/review_screen.dart';
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
import 'package:hive/hive.dart';

import '../../../components/spacialAppBar.dart';
import '../controllers/hospital_new_controller.dart';
import '../tab_main/views/tab_main_view.dart';

class HospitalNewView extends GetView<HospitalNewController> {
  List tab = ["doctors".tr, "services_list".tr, "about".tr];
// class HospitalNewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.specialAppBar("Hospitals",
            backgroundColor: Colors.transparent,
            action: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(AppImages.blackBell),
            )),

        body: Obx(() {
          return Stack(
            children: [
              controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ))
                  : ProfileViewNew(
                      address: controller.resModel.data.address ?? "",
                      photo:
                          "${ApiConsts.hostUrl}${controller.resModel.data.photo}",
                      star: controller.resModel.data.stars ?? "0.0",
                      reviewTitle: "hospital_reviews",
                      geometry: controller.resModel.data.geometry,
                      name: controller.resModel.data.name,
                      phoneNumbers: controller.resModel.data.phone,
                      numberOfusersRated: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  tab.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          controller.tabIndex.value = index;
                                        },
                                        child: Container(
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
                                                horizontal: 5, vertical: 8),
                                            child: Center(
                                              child: Container(
                                                  width: w * 0.2,
                                                  child: Center(
                                                      child: Text(
                                                    tab[index],
                                                    style: controller.tabIndex
                                                                .value !=
                                                            index
                                                        ? AppTextStyle
                                                            .boldPrimary10
                                                        : AppTextStyle
                                                            .boldWhite10,
                                                  ))),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                          controller.tabIndex.value == 0
                              ? Container(
                                  height: h * 0.495,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(top: 10),
                                    child:
                                        controller.isLoadingDoctor.value == true
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ))
                                            : controller.doctorList.isEmpty
                                                ? Center(
                                                    child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height * 0.2),
                                                    child: Text(
                                                        "no_result_found".tr),
                                                  ))
                                                : Column(
                                                    children: List.generate(
                                                        controller
                                                            .doctorList.length,
                                                        (index) =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                DoctorsController
                                                                    docController =
                                                                    Get.find();
                                                                docController
                                                                        .selectedDoctorData =
                                                                    controller
                                                                            .doctorList[
                                                                        index];
                                                                Get.toNamed(
                                                                    Routes
                                                                        .DOCTOR,
                                                                    arguments: controller
                                                                            .doctorList[
                                                                        index]);
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  index == 0
                                                                      ? SizedBox(
                                                                          height:
                                                                              5,
                                                                        )
                                                                      : SizedBox(),
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          10,
                                                                    ),
                                                                    // height: 220,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      // boxShadow: [
                                                                      //   BoxShadow(
                                                                      //     color: Colors.grey.withOpacity(0.1),
                                                                      //     spreadRadius: 7,
                                                                      //     blurRadius: 7,
                                                                      //     offset: Offset(0, 0),
                                                                      //   ),
                                                                      // ],
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          // height: h * 0.2,
                                                                          // width: w,
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                // color: Colors.black,
                                                                                // height: 65,
                                                                                // width: 65,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightGrey),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: "${ApiConsts.hostUrl}${controller.doctorList[index].photo}",
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
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      // SizedBox(height: 10),
                                                                                      Text(
                                                                                        "${controller.doctorList[index].name ?? ""}",
                                                                                        style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                                      ),
                                                                                      SizedBox(height: 2),
                                                                                      Text(
                                                                                        "${controller.doctorList[index].speciality ?? ""}",
                                                                                        style: AppTextTheme.b(11).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                                                                      ),
                                                                                      SizedBox(height: 2),
                                                                                      Row(
                                                                                        // mainAxisSize: MainAxisSize.min,
                                                                                        // mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          RatingBar.builder(
                                                                                            ignoreGestures: true,
                                                                                            itemSize: 15,
                                                                                            initialRating: double.parse("${controller.doctorList[index].stars ?? "0.0"}"),
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
                                                                                          SizedBox(width: 4),
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              Get.to(ReviewScreen(
                                                                                                appBarTitle: "hospital_reviews",
                                                                                              ));
                                                                                            },
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                '(10)  ${"reviews".tr}',
                                                                                                style: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                                                                              ).paddingOnly(top: 3),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(height: 5),
                                                                                      Row(
                                                                                        children: [
                                                                                          GestureDetector(
                                                                                            onTap: () {},
                                                                                            child: Container(
                                                                                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                                                                                              decoration: BoxDecoration(color: AppColors.lightBlack2, borderRadius: BorderRadius.circular(20)),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    "appointment".tr,
                                                                                                    style: AppTextTheme.m(12).copyWith(color: Colors.white),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // Utils.openPhoneDialer(context, item.phone);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: 5,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                color: AppColors.white,
                                                                                border: Border.all(color: AppColors.primary),
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                              child: Row(
                                                                                children: [
                                                                                  SvgPicture.asset(AppImages.calendar, height: 15, width: 15, color: AppColors.primary),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  FittedBox(
                                                                                    child: Text(
                                                                                      "Monday, August 10, 2022",
                                                                                      style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  SvgPicture.asset(AppImages.clock, height: 15, width: 15, color: AppColors.primary),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  FittedBox(
                                                                                    child: Text(
                                                                                      "09.00 - 10.00",
                                                                                      style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                  ),
                                  ),
                                )
                              : controller.tabIndex.value == 1
                                  ? controller.resModel.data.checkUp.isEmpty
                                      ? Center(
                                          child: Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.2),
                                          child: Text("no_result_found".tr),
                                        ))
                                      : Container(
                                          height: h * 0.495,
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.only(top: 10),
                                            child: GridView.builder(
                                              itemCount: controller
                                                  .resModel.data.checkUp.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 9,
                                                      mainAxisExtent: h * 0.27),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: h * 0.15,
                                                        width: w,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${ApiConsts.hostUrl}${controller.resModel.data.checkUp[index].img}",
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (_, __) {
                                                              return Image
                                                                  .asset(
                                                                "assets/png/person-placeholder.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            },
                                                            errorWidget:
                                                                (_, __, ___) {
                                                              return Image
                                                                  .asset(
                                                                "assets/png/person-placeholder.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${controller.resModel.data.checkUp[index].title ?? ""}",
                                                        style: AppTextStyle
                                                            .boldPrimary12,
                                                      ),
                                                      Text(
                                                        "${controller.resModel.data.checkUp[index].content}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyle
                                                            .boldPrimary11
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColors
                                                                .primary,
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primary)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      5),
                                                          child: Center(
                                                            child: Text(
                                                              "${controller.resModel.data.checkUp[index].price} Afghani",
                                                              style: AppTextStyle
                                                                  .boldWhite12,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                  : controller.resModel.data.description ==
                                              "" ||
                                          controller
                                                  .resModel.data.description ==
                                              null
                                      ? Center(
                                          child: Padding(
                                          padding: EdgeInsets.only(
                                              top: Get.height * 0.2),
                                          child: Text("no_result_found".tr),
                                        ))
                                      : Container(
                                          height: h * 0.495,
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: List.generate(
                                                  1,
                                                  (index) => Container(
                                                        width: w,
                                                        height: h * 0.1,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        // height: 220,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 7,
                                                              blurRadius: 7,
                                                              offset:
                                                                  Offset(0, 0),
                                                            ),
                                                          ],
                                                        ),
                                                        child: ExpandableText(
                                                          "${controller.resModel.data.description}",
                                                          expandText:
                                                              'Read more',
                                                          collapseText:
                                                              'Read less',
                                                          maxLines: 3,
                                                          linkColor:
                                                              AppColors.primary,
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
                                                      )),
                                            ),
                                          ),
                                        )
                          // TabBar(
                          //   controller: controller.tabController,
                          //   labelColor: AppColors.black2,
                          //   unselectedLabelColor: AppColors.lgt,
                          //   isScrollable: true,
                          //   tabs: [
                          //     Text("doctors".tr).paddingVertical(8),
                          //     Text("services_list".tr),
                          //     // Text("reviews".tr),
                          //     Text("about".tr),
                          //   ],
                          // )
                        ],
                      )),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: BottomBarView(
                    isHomeScreen: false,
                  ))
            ],
          );
        }),

        // body: ProfileViewNew(
        //   address: controller.hospital.address,
        //   photo: controller.hospital.photo,
        //   star: controller.hospital.stars,
        //   geometry: controller.hospital.geometry,
        //   name: controller.hospital.name,
        //   phoneNumbers: [controller.hospital.phone],
        //   numberOfusersRated: controller.hospital.usersStaredCount,
        //   child: TabMainView(),
        // ),
      ),
    );
  }
}
