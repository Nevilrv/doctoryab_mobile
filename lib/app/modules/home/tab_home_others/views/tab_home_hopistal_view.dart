import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/hospitals_controller.dart';
import 'package:doctor_yab/app/modules/home/views/profile/map_screen.dart';
import 'package:doctor_yab/app/modules/review/view/review_screen.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabHomeHospitalsView extends GetView<HospitalsController> {
  // final MaterialStateProperty<Icon> thumbIcon =
  //     MaterialStateProperty.resolveWith<Icon>(
  //   (Set<MaterialState> states) {
  //
  //     return Icon(
  //       FeatherIcons.moon,
  //       color: AppColors.switchGreen,
  //     );
  //   },
  // );
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () async {
            print(
                "controller.pageController.firstPageKey>>>>${controller.pageController.firstPageKey}");
            await Future.delayed(Duration.zero, () {
              controller.cancelToken.cancel();
            });
            controller.cancelToken = new CancelToken();
            controller.pageController.itemList.clear();
            controller.loadData(
              controller.pageController.firstPageKey,
            );
          },
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        List<LatLng> latLng = [];
                        controller.locationData.forEach((element) {
                          log("element.coordinates[1]--------------> ${element.coordinates}");
                          if (element.coordinates != null) {
                            log(" element.coordinates[0]--------------> ${element.coordinates[0]}");
                            log("element.coordinates[1]--------------> ${element.coordinates[1]}");
                            latLng.add(LatLng(element.coordinates[1],
                                element.coordinates[0]));
                          }
                        });
                        Get.to(MapScreen(
                          latLng: latLng,
                          name: controller.locationTitle,
                          title: "Hospital location",
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.map,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "view_all_in_maps".tr,
                                style: AppTextStyle.boldWhite12
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9.5, horizontal: 10),
                        child: Center(
                            child: SvgPicture.asset(
                          AppImages.emergencyBell,
                          width: 25,
                          height: 24,
                        )),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9.5, horizontal: 10),
                        child: Center(
                            child: SvgPicture.asset(
                          AppImages.blackBell,
                          width: 25,
                          height: 24,
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppGetDialog.showFilterDialog(
                          controller.filterList,
                          controller.selectedSort,
                          filterCallBack: (i) => controller.changeSort(i),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9.5, horizontal: 10),
                          child: Center(
                              child: SettingsController.appLanguge != "English"
                                  ? Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Image.asset(
                                        AppImages.filter,
                                        width: 25,
                                        height: 24,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : Image.asset(
                                      AppImages.filter,
                                      width: 25,
                                      height: 24,
                                      color: AppColors.primary,
                                    )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                style: AppTextStyle.mediumPrimary11.copyWith(fontSize: 13),
                cursorColor: AppColors.primary,
                controller: controller.search,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (s) async {
                  if (s.isEmpty) {
                    controller.pageController.itemList.clear();
                    controller.loadData(
                      controller.pageController.firstPageKey,
                    );
                  }
                },
                onSubmitted: (value) {
                  controller.pageController.itemList.clear();
                  controller.searchData(
                    controller.pageController.firstPageKey,
                  );
                  controller.update();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "search_hospital".tr,
                  hintStyle:
                      AppTextStyle.mediumPrimary11.copyWith(fontSize: 13),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset(AppImages.search,
                        color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: AppColors.white.withOpacity(0.1),
                  constraints: BoxConstraints(maxHeight: 38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // BannerView(),
              PagedListView.separated(
                pagingController: controller.pageController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (c, i) {
                  if ((i + 1) % 5 == 0) {
                    return BannerView();
                  } else {
                    return SizedBox(height: 5);
                  }
                },
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) {
                    return buildItem(w, item, h, context);
                  },
                  firstPageProgressIndicatorBuilder: (_) => DrugsGridShimmer(
                    yCount: 5,
                    xCount: 1,
                    // linesCount: 4,
                  ),
                  newPageProgressIndicatorBuilder: (_) => DrugsGridShimmer(
                    yCount: 5,
                    xCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildItem(double w, Hospital item, double h, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.HOSPITAL_NEW, arguments: item);
          // Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
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
                              imageUrl: "${ApiConsts.hostUrl}${item.photo}",
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
                        Positioned(
                            top: -5,
                            left: -5,
                            child: SvgPicture.asset(AppImages.emergencyBell))
                      ],
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
                              "${item.name ?? ""}",
                              style: AppTextTheme.h(12)
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 17,
                                  initialRating:
                                      double.parse(item.stars.toString()),
                                  // minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
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
                                    // Get.toNamed(Routes.REVIEW, arguments: [
                                    //   "Doctor_Review",
                                    //   controller
                                    // ]);
                                    // Get.to(ReviewScreen(
                                    //   appBarTitle: "hospital_reviews",
                                    // ));
                                  },
                                  child: Text(
                                    '(${"${item.usersStaredCount ?? ""}"})  ${"reviews".tr}',
                                    style: AppTextTheme.b(12).copyWith(
                                        color:
                                            AppColors.primary.withOpacity(0.5)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Utils.openPhoneDialer(
                                          context, "${item.phone ?? ""}");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Center(
                                            child: Text(
                                              "call".tr,
                                              style: AppTextTheme.m(12)
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Spacer(),
                                          SettingsController.appLanguge !=
                                                  "English"
                                              ? Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(
                                                      math.pi),
                                                  child: SvgPicture.asset(
                                                      AppImages.phone),
                                                )
                                              : SvgPicture.asset(
                                                  AppImages.phone)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.lightGrey),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/location_pin.svg",
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "${"${item.address ?? ""}"}",
                          // maxLines: ,
                          style: AppTextTheme.b(11)
                              .copyWith(color: AppColors.primary),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget buildItem(c, it, i) {
  //   return  NewItems(
  //     // is24Hour: i % 2 == 0,
  //     is24Hour: false,
  //     title: it.name,
  //     address: it.address,
  //     phoneNumber: it.phone,
  //     imagePath: it.photo,
  //     latLng: it.geometry.coordinates,
  //   ).onTap(() {
  //     Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
  //     // Get.to(
  //     //   () => DrugStoreLabView(
  //     //     Labs(),
  //     //     DRUG_STORE_LAB_PAGE_TYPE.hospital,
  //     //     hospital: it,
  //     //   ),
  //     // );
  //
  //     // Get.to(() => DoctorsView(
  //     //       action: DOCTORS_LOAD_ACTION.ofhospital,
  //     //       hospitalId: it.id ?? "",
  //     //       hospitalName: it.name,
  //     //     ));
  //     // return;
  //     // // Get.toNamed(Routes.DOCTORS,
  //     // //     arguments: [Doctor(id: it.id, fullname: it.name, name: it.name)]);
  //   })
  //       ;
  // }
}
