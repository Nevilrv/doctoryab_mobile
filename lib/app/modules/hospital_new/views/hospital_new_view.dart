import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
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
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppImages.blackBell),
            )),

        body: ProfileViewNew(
          address: "",
          photo: "",
          star: 4,
          geometry: null,
          name: "controller.hospital.name",
          phoneNumbers: ["26589658985"],
          numberOfusersRated: 5,
          child: Obx(() {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      tab.length,
                      (index) => GestureDetector(
                            onTap: () {
                              controller.tabIndex.value = index;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: controller.tabIndex.value != index
                                      ? AppColors.white
                                      : AppColors.primary,
                                  border: Border.all(color: AppColors.primary)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Center(
                                  child: Container(
                                      width: w * 0.25,
                                      child: Center(
                                          child: Text(
                                        tab[index],
                                        style:
                                            controller.tabIndex.value != index
                                                ? AppTextStyle.boldPrimary14
                                                : AppTextStyle.boldWhite14,
                                      ))),
                                ),
                              ),
                            ),
                          )),
                ),
                controller.tabIndex.value == 0
                    ? Container(
                        height: h * 0.263,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: List.generate(
                                3,
                                (index) => Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      // height: 220,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.1),
                                        //     spreadRadius: 7,
                                        //     blurRadius: 7,
                                        //     offset: Offset(0, 0),
                                        //   ),
                                        // ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            // height: h * 0.2,
                                            width: w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    // color: Colors.black,
                                                    // height: 65,
                                                    // width: 65,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .lightGrey),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: "",
                                                        fit: BoxFit.cover,
                                                        placeholder: (_, __) {
                                                          return Image.asset(
                                                            "assets/png/person-placeholder.jpg",
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                        errorWidget:
                                                            (_, __, ___) {
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                            Flexible(
                                                              child: Text(
                                                                "Afghan Hospital",
                                                                style: AppTextTheme
                                                                        .h(15)
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .black2),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text(
                                                          "شفاخانه افغان",
                                                          style: AppTextTheme.b(
                                                                  14)
                                                              .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .lgt2),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(
                                                          // mainAxisSize: MainAxisSize.min,
                                                          // mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              itemSize: 15,
                                                              initialRating: 4,
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
                                                                print(rating);
                                                              },
                                                            ),
                                                            SizedBox(width: 4),
                                                            Center(
                                                              child: Text(
                                                                '5.0 - 10 Reviews',
                                                                style: AppTextTheme.b(12).copyWith(
                                                                    color: AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.5)),
                                                              ).paddingOnly(
                                                                  top: 3),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            2),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .lightBlack2,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "appointment"
                                                                          .tr,
                                                                      style: AppTextTheme.m(
                                                                              14)
                                                                          .copyWith(
                                                                              color: Colors.white),
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
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Utils.openPhoneDialer(context, item.phone);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppImages.calendar,
                                                      height: 22,
                                                      width: 22,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "Monday, August 10, 2022",
                                                        style: AppTextTheme.m(
                                                                14)
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SvgPicture.asset(
                                                      AppImages.clock,
                                                      height: 22,
                                                      width: 22,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "09.00 - 10.00",
                                                        style: AppTextTheme.m(
                                                                14)
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          ),
                        ),
                      )
                    : controller.tabIndex.value == 1
                        ? Container(
                            height: h * 0.263,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                children: List.generate(
                                    1,
                                    (index) => Container(
                                          width: w, height: h * 0.1,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          // height: 220,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: AppColors.primary
                                                    .withOpacity(0.5)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 7,
                                                blurRadius: 7,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            "About by hospital lorem ipsum bla bla.",
                                            style: AppTextStyle.mediumBlack12
                                                .copyWith(
                                                    color:
                                                        AppColors.lightBlack2,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        )),
                              ),
                            ),
                          )
                        : Container(
                            height: h * 0.263,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 10),
                              child: GridView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 9,
                                        mainAxisExtent: h * 0.26),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: h * 0.15,
                                          width: w,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=sph",
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
                                        Text(
                                          "Example Service",
                                          style: AppTextStyle.boldPrimary14,
                                        ),
                                        Text(
                                          "Example service explain",
                                          style: AppTextStyle.boldPrimary12
                                              .copyWith(
                                                  color: AppColors.primary
                                                      .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.primary,
                                              border: Border.all(
                                                  color: AppColors.primary)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Center(
                                              child: Text(
                                                "22000 Afghani",
                                                style: AppTextStyle.boldWhite14,
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
            );
          }),
        ),
        bottomNavigationBar: BottomBarView(isHomeScreen: false),
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
