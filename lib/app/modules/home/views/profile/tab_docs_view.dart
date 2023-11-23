import 'dart:developer';

import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/data/repository/ReportsRepository.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/controllers/reports_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/reports_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class TabDocsView extends GetView<ReportsController> {
  List tab = [
    "doctor_rerports".tr,
    "lab_reports".tr,
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('TabDocsView'),
          //   centerTitle: true,
          // ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('reports'.tr,
                style: AppTextStyle.boldPrimary20
                    .copyWith(fontWeight: FontWeight.w600)),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:
                    Icon(Icons.arrow_back_ios_new, color: AppColors.primary)),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  AppImages.blackBell,
                  height: 24,
                ),
              )
            ],
          ),
          body: Obx(() {
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
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

                                        if (index == 0) {
                                          controller.pagingController.itemList
                                              .clear();
                                          controller.fetchReportsDoctor(
                                              controller.pagingController
                                                  .firstPageKey);
                                        } else {
                                          controller.pagingController.itemList
                                              .clear();
                                          controller.fetchReportsLab(controller
                                              .pagingController.firstPageKey);
                                        }
                                      },
                                      child: Expanded(
                                        child: Container(
                                          // width: w * 0.4,
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
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: h * 0.74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.white,
                        ),
                        child: controller.tabIndex.value == 0
                            ? PagedListView.separated(
                                shrinkWrap: true,
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 30, horizontal: 22),
                                pagingController: controller.pagingController,
                                separatorBuilder: (c, i) {
                                  return Divider().paddingAll(10);
                                },
                                builderDelegate:
                                    PagedChildBuilderDelegate<Report>(
                                  itemBuilder: (context, item, index) {
                                    log("item.visitDate--------------> ${item.prescriptionCreateAt}");

                                    // var item = controller.latestVideos[index];
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                item.documents.isEmpty
                                                    ? SizedBox()
                                                    : Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primary),
                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              index % 2 == 0
                                                                  ? AppImages
                                                                      .document
                                                                  : AppImages
                                                                      .attachment,
                                                              color: AppColors
                                                                  .white,
                                                              height: 25,
                                                              width: 25),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: w * 0.64,
                                                      child: Text(
                                                        "Patient Name: ${item.name ?? ""}",
                                                        style: AppTextStyle
                                                            .boldPrimary14,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: w * 0.64,
                                                      child: Text(
                                                        "Doctor Name: ${item.doctor[0].name ?? ""}",
                                                        style: AppTextStyle
                                                            .boldPrimary14
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: w * 0.64,
                                                      child: Text(
                                                        "Doctor Note: ${item.description ?? ""}",
                                                        style: AppTextStyle
                                                            .boldPrimary14
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5)),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                item.prescriptionCreateAt ==
                                                            null ||
                                                        item.prescriptionCreateAt ==
                                                            ""
                                                    ? SizedBox()
                                                    : Container(
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                            color: AppColors.red
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Center(
                                                          child: Text(
                                                            "${item.prescriptionCreateAt.toString() == "" || item.prescriptionCreateAt == null ? "" : DateFormat('dd.MM.yyyy').format(DateTime.parse(item.prescriptionCreateAt))}",
                                                            style: AppTextStyle
                                                                .mediumPrimary12
                                                                .copyWith(
                                                                    color:
                                                                        AppColors
                                                                            .red),
                                                          ),
                                                        ),
                                                      ),
                                                item.prescriptionCreateAt ==
                                                            null ||
                                                        item.prescriptionCreateAt ==
                                                            ""
                                                    ? SizedBox()
                                                    : Container(
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            color: AppColors.red
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Divider(
                                                                thickness: 1,
                                                                color: AppColors
                                                                    .red),
                                                          ),
                                                        ),
                                                      ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.red
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Center(
                                                      child: Text(
                                                        "SEE ALL DETAILS",
                                                        style: AppTextStyle
                                                            .mediumPrimary12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .red),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  noMoreItemsIndicatorBuilder: (_) =>
                                      DotDotPagingNoMoreItems(),
                                  noItemsFoundIndicatorBuilder: (_) => Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.25),
                                    child:
                                        Center(child: PagingNoItemFountList()),
                                  ),
                                  firstPageErrorIndicatorBuilder: (context) =>
                                      PagingErrorView(
                                    controller: controller.pagingController,
                                  ),
                                ),
                              )
                            : PagedListView.separated(
                                shrinkWrap: true,
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 30, horizontal: 22),
                                pagingController: controller.pagingController,
                                separatorBuilder: (c, i) {
                                  return Divider().paddingAll(10);
                                },
                                builderDelegate:
                                    PagedChildBuilderDelegate<Report>(
                                  itemBuilder: (context, item, index) {
                                    log("item.visitDate--------------> ${item.prescriptionCreateAt}");

                                    // var item = controller.latestVideos[index];
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                item.documents.isEmpty
                                                    ? SizedBox()
                                                    : Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primary),
                                                        child: Center(
                                                          child: SvgPicture.asset(
                                                              index % 2 == 0
                                                                  ? AppImages
                                                                      .document
                                                                  : AppImages
                                                                      .attachment,
                                                              color: AppColors
                                                                  .white,
                                                              height: 25,
                                                              width: 25),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    item.name == ""
                                                        ? SizedBox()
                                                        : Container(
                                                            width: w * 0.64,
                                                            child: Text(
                                                              "Patient Name: ${item.name}",
                                                              style: AppTextStyle
                                                                  .boldPrimary14,
                                                            ),
                                                          ),
                                                    item.title == "" ||
                                                            item.title == null
                                                        ? SizedBox()
                                                        : Container(
                                                            width: w * 0.64,
                                                            child: Text(
                                                              "Test Name: ${item.title}",
                                                              style: AppTextStyle
                                                                  .boldPrimary14
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5)),
                                                            ),
                                                          ),
                                                    item.description == "" ||
                                                            item.description ==
                                                                null
                                                        ? SizedBox()
                                                        : Container(
                                                            width: w * 0.64,
                                                            child: Text(
                                                              "Test Note: ${item.description}",
                                                              style: AppTextStyle
                                                                  .boldPrimary14
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5)),
                                                            ),
                                                          ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                item.prescriptionCreateAt
                                                                .toString() ==
                                                            "" ||
                                                        item.prescriptionCreateAt ==
                                                            null
                                                    ? SizedBox()
                                                    : Container(
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                            color: AppColors.red
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Center(
                                                          child: Text(
                                                            "${item.prescriptionCreateAt.toString() == "" || item.prescriptionCreateAt == null ? "" : DateFormat('dd.MM.yyyy').format(DateTime.parse(item.prescriptionCreateAt))}",
                                                            style: AppTextStyle
                                                                .mediumPrimary12
                                                                .copyWith(
                                                                    color:
                                                                        AppColors
                                                                            .red),
                                                          ),
                                                        ),
                                                      ),
                                                item.prescriptionCreateAt
                                                                .toString() ==
                                                            "" ||
                                                        item.prescriptionCreateAt ==
                                                            null
                                                    ? SizedBox()
                                                    : Container(
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            color: AppColors.red
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Divider(
                                                                thickness: 1,
                                                                color: AppColors
                                                                    .red),
                                                          ),
                                                        ),
                                                      ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.red
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Center(
                                                      child: Text(
                                                        "SEE ALL DETAILS",
                                                        style: AppTextStyle
                                                            .mediumPrimary12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .red),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  noMoreItemsIndicatorBuilder: (_) =>
                                      DotDotPagingNoMoreItems(),
                                  noItemsFoundIndicatorBuilder: (_) => Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.25),
                                    child:
                                        Center(child: PagingNoItemFountList()),
                                  ),
                                  firstPageErrorIndicatorBuilder: (context) =>
                                      PagingErrorView(
                                    controller: controller.pagingController,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
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
            );
          }),
          // appBar: AppAppBar.specialAppBar(
          //   "reports".tr,
          //   showLeading: false,
          //   bottom: TabBar(
          //     indicatorColor: AppColors.green,h
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     // indicator: BoxDecoration(border: RoundedRectangleBorder()),
          //     tabs: [
          //       Text("doctor_rerports".tr).paddingAll(10),
          //       Text("lab_reports".tr).paddingAll(10),
          //     ],
          //   ),
          // ),
          // body: TabBarView(
          //   children: [
          //     ReportsView(REPORT_TYPE.doctor),
          //     ReportsView(REPORT_TYPE.lab),
          //   ],
          // ),
        ),
      ),
    );
  }
}
