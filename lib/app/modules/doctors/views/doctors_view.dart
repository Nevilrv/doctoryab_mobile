import 'dart:developer';
import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/map_screen.dart';
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
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/doctors_controller.dart';

class DoctorsView extends GetView<DoctorsController> {
  DoctorsController controller;
  String hospitalId;
  String hospitalName;
  final bool hideAppbar;
  final Color bgColor;
  // final bool loadMyDoctorsMode;
  DOCTORS_LOAD_ACTION action;
  DoctorsView({
    this.action = DOCTORS_LOAD_ACTION.fromCategory,
    this.hospitalId,
    this.hospitalName,
    this.hideAppbar = false,
    this.bgColor,
  }) {
    controller =
        Get.put(DoctorsController(), tag: "doctors_controller_$action");

    controller.hospitalId = hospitalId;
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // assert(Get.arguments is CategoryBridge && controller.arguments.sId != null);
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: hideAppbar
            ? null
            : AppAppBar.specialAppBar(() {
                switch (action) {
                  case DOCTORS_LOAD_ACTION.fromCategory:
                    {
                      return "doctors_of"
                          .trArgs([controller?.category()?.title]);
                    }
                  case DOCTORS_LOAD_ACTION.myDoctors:
                    {
                      return "my_doctors".tr;
                    }
                  case DOCTORS_LOAD_ACTION.ofhospital:
                    {
                      return hospitalName ?? "";
                    }
                }
              }(),
                showLeading: Navigator.of(context).canPop(),
                backgroundColor: Colors.transparent,
                action: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NOTIFICATION);
                      },
                      child: SvgPicture.asset(AppImages.blackBell)),
                )
                /*action: controller.action != DOCTORS_LOAD_ACTION.myDoctors
                      ? IconButton(
                          onPressed: () {
                            AppGetDialog.showFilterDialog(
                              controller.filterList,
                              controller.selectedSort,
                              filterCallBack: (i) => controller.changeSort(i),
                            );
                          },
                          icon:
                              Icon(AntDesign.filter, color: AppColors.primary),
                        )
                      : null*/
                ),
        // body: _buildItemView(DoctorBridge()),
        body: Stack(
          children: [
            GetBuilder<DoctorsController>(builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<LatLng> latLng = [];
                            controller.locationData.forEach((element) {
                              if (element.coordinates != null) {
                                latLng.add(LatLng(element.coordinates[1],
                                    element.coordinates[0]));
                              }
                              if (controller.locationData.length ==
                                  latLng.length) {
                                Get.to(MapScreen(
                                  latLng: latLng,
                                  name: controller.locationTitle,
                                  title: "Doctors location",
                                ));
                              }
                            });
                          },
                          child: Container(
                            width: w * 0.7,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.map,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    "view_all_in_maps".tr,
                                    style: AppTextStyle.boldWhite12
                                        .copyWith(fontSize: 13),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        // IconButton(
                        //   onPressed: () {
                        //     AppGetDialog.showFilterDialog(
                        //       controller.filterList,
                        //       controller.selectedSort,
                        //       filterCallBack: (i) => controller.changeSort(i),
                        //     );
                        //   },
                        //   icon: Icon(AntDesign.filter, color: AppColors.primary),
                        // ),
                        GestureDetector(
                          onTap: () {
                            controller.showFilterDialog();
                          },
                          child: Container(
                            width: w * 0.15,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9.5, horizontal: 10),
                              child: Center(
                                  child: SettingsController.appLanguge !=
                                          "English"
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
                  SizedBox(height: 10),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(bottom: 15, right: 20, left: 20),
                  //   child: BannerView(),
                  // ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () async {
                          await Future.delayed(Duration.zero, () {
                            controller.cancelToken.cancel();
                          });
                          controller.cancelToken = CancelToken();
                          controller.pagingController.itemList.clear();
                          controller.fetchDoctors(
                            controller.pagingController.firstPageKey,
                          );
                        },
                      ),
                      child: PagedListView.separated(
                        pagingController: controller.pagingController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (c, i) {
                          if ((i + 1) % 5 == 0) {
                            log("i--------------> $i");

                            // controller.bannerAds();
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, right: 20, left: 20),
                              child: Stack(
                                children: [
                                  Container(
                                    child: CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          height: Get.height * 0.2,
                                          viewportFraction: 1.0,
                                          enlargeCenterPage: false,
                                          onPageChanged: (index, reason) {
                                            controller.adIndex = index;
                                            controller.update();
                                          },
                                        ),
                                        items: controller.adList
                                            .map((item) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    // margin: EdgeInsets.all(5.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                      child: Image.network(
                                                          "${ApiConsts.hostUrl}${item.img}",
                                                          fit: BoxFit.cover,
                                                          width: 1000.0),
                                                    ),
                                                  ),
                                                ))
                                            .toList()),
                                  ),
                                  Positioned(
                                    bottom: Get.height * 0.017,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            controller.adList.length,
                                            (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: controller
                                                                .adIndex ==
                                                            index
                                                        ? AppColors.primary
                                                        : AppColors.primary
                                                            .withOpacity(0.2),
                                                  ),
                                                )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return SizedBox(height: 5);
                          }
                        },
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, item, index) {
                            return _doctorData(
                              context,
                              item,
                            );
                          },
                          noMoreItemsIndicatorBuilder: (_) =>
                              DotDotPagingNoMoreItems(),
                          noItemsFoundIndicatorBuilder: (_) =>
                              PagingNoItemFountList(),
                          firstPageErrorIndicatorBuilder: (context) =>
                              PagingErrorView(
                            controller: controller.pagingController,
                          ),
                          firstPageProgressIndicatorBuilder: (_) =>
                              DrugsGridShimmer(
                            yCount: 5,
                            xCount: 1,
                            // linesCount: 4,
                          ),
                          newPageProgressIndicatorBuilder: (_) =>
                              DrugsGridShimmer(
                            yCount: 5,
                            xCount: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: BottomBarView(
                isHomeScreen: false,
                isBlueBottomBar: true,
              ),
            )
          ],
        ) /* RefreshIndicator(
            onRefresh: () => Future.sync(
              () async {
                Utils.resetPagingController(controller.pagingController);
                await Future.delayed(Duration.zero, () {
                  controller.cancelToken.cancel();
                });
                controller.cancelToken = new CancelToken();
                controller.fetchDoctors(
                  controller.pagingController.firstPageKey,
                );
              },
            ),
            child: PagedListView.separated(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              pagingController: controller.pagingController,
              // physics: BouncingScrollPhysics(),
              separatorBuilder: (c, i) {
                return SizedBox(height: 15);
              },
              builderDelegate: PagedChildBuilderDelegate<Doctor>(
                itemBuilder: (context, item, index) {
                  // var item = controller.latestVideos[index];
                  // return _buildItemView(context, item);
                },
                noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
                noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
                firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                  controller: controller.pagingController,
                ),
              ),
            ),
          ).bgColor(bgColor)*/
        ,
      ),
    );
  }

  Widget _doctorData(BuildContext context, Doctor item) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var date;
    String slot;

    if (item.schedules.isNotEmpty) {
      if (item.schedules.length == 1) {
        for (int i = 0; i <= 7; i++) {
          DateTime d = DateTime.now().add(Duration(days: i));
          if (item.schedules[0].dayOfWeek == d.weekday) {
            log("d--as------------> ${d}");
            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules[0].times.isNotEmpty) {
              slot =
                  "${item.schedules[0].times.first} - ${item.schedules[0].times.last}";
            }
            log("date--------------> ${date}");
            log("slot--------------> ${slot}");
            break;
          }
        }
      } else {
        // List<Schedule> dataSort ;
        // dataSort.add(value)
        List da = [];
        item.schedules.sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));
        for (int i = 0; i < item.schedules.length; i++) {
          da.add(item.schedules[i].dayOfWeek);
        }
        var n = DateTime.now().weekday;
        var finalWeekDay;
        var greater = da.where((e) => e >= n).toList()..sort();
        var smaller = da.where((e) => e <= n).toList()..sort();
        if (greater.isEmpty) {
          finalWeekDay = smaller.first;
        } else {
          finalWeekDay = greater.first;
        }
        log("greater--------------> ${greater}");
        Schedule data;
        item.schedules.forEach((element) {
          if (element.dayOfWeek == finalWeekDay) {
            data = element;
          }
        });

        int indexxx = item.schedules.indexOf(data);
        log("indexxx--------------> ${indexxx}");
        log("item.schedules--------------> ${item.schedules}");

        if (indexxx == item.schedules.length - 1) {
          indexxx = 0;
        } else {
          indexxx = indexxx + 1;
        }
        for (int i = 0; i <= 7; i++) {
          log("i--------------> ${i}");

          DateTime d = DateTime.now().add(Duration(days: i));
          log("item.schedules[indexxx].dayOfWeek--------------> ${item.schedules[indexxx].dayOfWeek}");
          log("d.weekday--------------> ${d.weekday}");
          if (d.weekday == 7) {
            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules[indexxx].times.isNotEmpty) {
              slot =
                  "${item.schedules[indexxx].times.first} - ${item.schedules[indexxx].times.last}";
            }

            log("date--------------> ${date}");
            log("slot--------------> ${slot}");
          }
          if (item.schedules[indexxx].dayOfWeek == d.weekday) {
            log("d--------------> ${d}");
            log("item.schedules[indexxx + 1].times--------------> ${item.schedules[indexxx].times}");

            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules[indexxx].times.isNotEmpty) {
              slot =
                  "${item.schedules[indexxx].times.first} - ${item.schedules[indexxx].times.last}";
            }

            log("date--------------> ${date}");
            log("slot--------------> ${slot}");

            break;
          }
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 20, left: 20),
      child: GestureDetector(
        onTap: () {
          controller.selectedDoctorData = item;
          Get.toNamed(Routes.DOCTOR, arguments: item);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primary),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width * 0.49,
                                  child: Text(
                                    "${item.fullname ?? item.name ?? ""}",
                                    style: AppTextTheme.h(12)
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${item.speciality ?? ""}",
                                  style: AppTextTheme.b(11).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 15,
                                      initialRating: double.parse(
                                          item.averageRatings == null
                                              ? "0.0"
                                              : item.averageRatings
                                                      .toString() ??
                                                  "0.0"),
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
                                        Get.toNamed(Routes.REVIEW,
                                            arguments: ["Doctor_Review", item]);
                                      },
                                      child: Text(
                                        '(${item.totalFeedbacks == null ? 0 : item.totalFeedbacks ?? 0}) ${'reviews'.tr}',
                                        style: AppTextTheme.b(12).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Utils.openPhoneDialer(
                                              context, "${item.phone}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: w * 0.02),
                                          decoration: BoxDecoration(
                                              color: AppColors.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "call".tr,
                                              style: AppTextTheme.m(w * 0.032)
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          // BookingController.to.selectedDoctor(item);
                                          log("item--------------> ${item}");

                                          Get.toNamed(
                                            Routes.BOOK,
                                            arguments: item,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: w * 0.01),
                                          decoration: BoxDecoration(
                                              color: AppColors.lightBlack2,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "appointment".tr,
                                              style: AppTextTheme.m(w * 0.032)
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
                  item.schedules.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppImages.calendar,
                                  height: 15,
                                  width: 15,
                                  color: AppColors.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${date[0]}",
                                      style: AppTextTheme.m(10)
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    Text(
                                      " ${date[1]}",
                                      style: AppTextTheme.m(10)
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    Text(
                                      " ${date[3]}",
                                      style: AppTextTheme.m(10)
                                          .copyWith(color: AppColors.primary),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                slot == null
                                    ? SizedBox()
                                    : SvgPicture.asset(
                                        AppImages.clock,
                                        height: 15,
                                        width: 15,
                                        color: AppColors.primary,
                                      ),
                                slot == null
                                    ? SizedBox()
                                    : SizedBox(
                                        width: 5,
                                      ),
                                slot == null
                                    ? SizedBox()
                                    : FittedBox(
                                        child: Text(
                                          "${slot ?? "  -  "}",
                                          style: AppTextTheme.m(10).copyWith(
                                              color: AppColors.primary),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              item.active == true
                  ? Positioned(
                      top: -3,
                      right:
                          SettingsController.appLanguge != "English" ? null : 0,
                      left:
                          SettingsController.appLanguge == "English" ? null : 0,
                      child: SettingsController.appLanguge != "English"
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Image.asset(
                                AppImages.promote,
                                height: 18,
                                width: 18,
                                color: AppColors.primary,
                              ))
                          : Image.asset(
                              AppImages.promote,
                              height: 18,
                              width: 18,
                              color: AppColors.primary,
                            ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
