import 'dart:developer';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_search_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TabSearchView extends GetView<TabSearchController> {
  TabSearchController controller=Get.put(TabSearchController());
  @override
  Widget build(BuildContext context) {
    return Background(
      isSecond: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppAppBar.specialAppBar(
          'search_doctor'.tr,
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
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    TextField(
                      style:
                          AppTextStyle.mediumPrimary11.copyWith(fontSize: 13),
                      cursorColor: AppColors.primary,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (s) => controller.filterName(s),
                      autofocus: true,
                      controller: controller.teSearchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "search_hint".tr,
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
                    controller.firstSearchInit()
                        ? Container(
                            height: Get.height * 0.72,
                            child: PagedListView.separated(
                              pagingController: controller.pagingController,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (c, i) {
                                if ((i + 1) % 5 == 0) {
                                  log("i--------------> $i");

                                  // controller.bannerAds();
                                  return GetBuilder<TabSearchController>(
                                    builder: (controller) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15,
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              child: CarouselSlider(
                                                  options: CarouselOptions(
                                                    autoPlay: true,
                                                    height: Get.height * 0.2,
                                                    viewportFraction: 1.0,
                                                    enlargeCenterPage: false,
                                                    onPageChanged:
                                                        (index, reason) {
                                                      controller.adIndex =
                                                          index;
                                                      controller.update();
                                                    },
                                                  ),
                                                  items: controller.adList
                                                      .map((item) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              // margin: EdgeInsets.all(5.0),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0)),
                                                                child: Image.network(
                                                                    "${ApiConsts.hostUrl}${item.img}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width:
                                                                        1000.0),
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
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 3),
                                                            child: CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor: controller
                                                                          .adIndex ==
                                                                      index
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.2),
                                                            ),
                                                          )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
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
                                    PagingNoItemFountList()
                                        .paddingOnly(top: Get.height * 0.3),
                                firstPageErrorIndicatorBuilder: (context) =>
                                    PagingErrorView(
                                  controller: controller.pagingController,
                                ),
                                firstPageProgressIndicatorBuilder: (_) {
                                  print(
                                      '----firstPageProgressIndicatorBuilder----');
                                  return DrugsGridShimmer(
                                    yCount: 5,
                                    xCount: 1,
                                    // linesCount: 4,
                                  );
                                },
                                newPageProgressIndicatorBuilder: (_) {
                                  print(
                                      '----newPageProgressIndicatorBuilder----');
                                  // return DrugsGridShimmer(
                                  //   yCount: 5,
                                  //   xCount: 1,
                                  // );

                                  return SizedBox();
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.3),
                              child: Text("no_result_found".tr),
                            ),
                          )
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: BottomBarView(
                    isHomeScreen: false,
                    isBlueBottomBar: true,
                  ),
                )
              ],
            ),
          ),
        ),
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
            log("d--as------------> $d");
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
            log("date--------------> $date");
            log("slot--------------> $slot");
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
        log("greater--------------> $greater");
        Schedule data;
        item.schedules.forEach((element) {
          if (element.dayOfWeek == finalWeekDay) {
            data = element;
          }
        });

        int indexxx = item.schedules.indexOf(data);
        log("indexxx--------------> $indexxx");
        log("item.schedules--------------> ${item.schedules}");

        if (indexxx == item.schedules.length - 1) {
          indexxx = 0;
        } else {
          indexxx = indexxx + 1;
        }
        for (int i = 0; i <= 7; i++) {
          log("i--------------> $i");

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

            log("date--------------> $date");
            log("slot--------------> $slot");
          }
          if (item.schedules[indexxx].dayOfWeek == d.weekday) {
            log("d--------------> $d");
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

            log("date--------------> $date");
            log("slot--------------> $slot");

            break;
          }
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          DoctorsController doctorsController = Get.put(DoctorsController());
          doctorsController.selectedDoctorData = item;
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
                                      initialRating: item.stars.toDouble(),
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
                                    Text(
                                      '(12) Reviews',
                                      style: AppTextTheme.b(12).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
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
                  // item.schedules.isEmpty
                  date == null
                      ? SizedBox()
                      : Container(
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
                ],
              ),
              item.isActive == true
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Directionality(
        textDirection: Directionality.of(context),
        child: TextField(
          // key: Key('SearchBarTextField'),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "search_hint".tr,
            hintStyle: TextStyle(
              color: AppColors.lgt,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (s) => controller.filterName(s),
          autofocus: true,
          controller: controller.teSearchController,
        ),
      ),
      actions: <Widget>[
        // Show an icon if clear is not active, so there's no ripple on tap
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (controller.teSearchController.text.isEmpty)
              Get.focusScope.unfocus();
            controller.teSearchController.clear();
            controller.firstSearchInit(false);
          },
          color: AppColors.lgt2,
        ),
      ],
      backgroundColor: AppColors.scaffoldColor,
    );
  }

  // Widget _buildItem(Doctor doctor) {
  //   return Column(
  //     children: [
  //       ListTile(
  //         onTap: () {
  //           Get.toNamed(Routes.DOCTOR, arguments: [doctor]);
  //         },
  //         leading: AspectRatio(
  //           aspectRatio: 1,
  //           child: Transform.scale(
  //             scale: 1.09,
  //             child: Container(
  //               color: Colors.black,
  //               // height: 65,
  //               // width: 65,
  //               child: Image.network(
  //                 "${ApiConsts.hostUrl}${doctor.photo}",
  //                 fit: BoxFit.cover,
  //               ),
  //             ).radiusAll(100),
  //           ),
  //         ),
  //         title: Text(
  //           doctor.name,
  //           style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
  //         ).paddingOnly(top: 8, bottom: 2),
  //         subtitle: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               doctor.speciality ?? "",
  //               style: AppTextTheme.b(14)
  //                   .copyWith(color: AppColors.lgt2, height: 1.0),
  //             ),
  //             SizedBox(height: 2),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 RatingBar.builder(
  //                   ignoreGestures: true,
  //                   itemSize: 15,
  //                   initialRating: doctor.stars,
  //                   // minRating: 1,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemCount: 5,
  //                   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
  //                   itemBuilder: (context, _) => Icon(
  //                     Icons.star,
  //                     color: Colors.amber,
  //                     // size: 10,
  //                   ),
  //                   onRatingUpdate: (rating) {
  //                     print(rating);
  //                   },
  //                 ),
  //                 SizedBox(width: 4),
  //                 Text(
  //                   '(${doctor.totalStar})',
  //                   style: AppTextTheme.b(10.5).copyWith(color: AppColors.lgt2),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 8),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
