import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/my_doctors_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/map_screen.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MyDoctorsView extends GetView<MyDoctorsController> {
  final String? hospitalId;
  final String? hospitalName;
  final bool hideAppbar;
  final Color? bgColor;

  MyDoctorsView({
    this.hospitalId,
    this.hospitalName,
    this.hideAppbar = false,
    this.bgColor,
  });
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // assert(Get.arguments is CategoryBridge && controller.arguments.sId != null);
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("my_doctors".tr, style: AppTextStyle.boldPrimary16.copyWith(fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
            // child: RotatedBox(
            //   quarterTurns:
            //       SettingsController.appLanguge == "English" ? 0 : 2,
            //   child: Icon(
            //     Icons.arrow_back_ios_new,
            //     color: AppColors.primary,
            //   ),
            // ),
          ),
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(Routes.NOTIFICATION);
          //       },
          //       child: SvgPicture.asset(
          //         AppImages.blackBell,
          //         height: 24,
          //         width: 24,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Stack(
          children: [
            GetBuilder<MyDoctorsController>(builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<LatLng> latLng = [];
                            controller.locationData.forEach((element) {
                              if (element.coordinates != null) {
                                latLng.add(LatLng(element.coordinates![1], element.coordinates![0]));
                              }
                              if (controller.locationData.length == latLng.length) {
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
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.map,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    "view_all_in_maps".tr,
                                    style: AppTextStyle.boldWhite12.copyWith(fontSize: 13),
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
                              padding: const EdgeInsets.symmetric(vertical: 9.5, horizontal: 10),
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
                          // controller.pagingController.itemList.clear();
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
                          // if ((i + 1) % 5 == 0) {

                          //
                          //   // controller.bannerAds();
                          //   return Padding(
                          //     padding: const EdgeInsets.only(
                          //         bottom: 15, right: 20, left: 20),
                          //     child: Stack(
                          //       children: [
                          //         Container(
                          //           child: CarouselSlider(
                          //               options: CarouselOptions(
                          //                 autoPlay: true,
                          //                 height: Get.height * 0.2,
                          //                 viewportFraction: 1.0,
                          //                 enlargeCenterPage: false,
                          //                 onPageChanged: (index, reason) {
                          //                   controller.adIndex = index;
                          //                   controller.update();
                          //                 },
                          //               ),
                          //               items: controller.adList
                          //                   .map((item) => Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                                 left: 5),
                          //                         child: Container(
                          //                           decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(15)),
                          //                           // margin: EdgeInsets.all(5.0),
                          //                           child: ClipRRect(
                          //                             borderRadius:
                          //                                 BorderRadius.all(
                          //                                     Radius.circular(
                          //                                         15.0)),
                          //                             child: Image.network(
                          //                                 "${ApiConsts.hostUrl}${item.img}",
                          //                                 fit: BoxFit.cover,
                          //                                 width: 1000.0),
                          //                           ),
                          //                         ),
                          //                       ))
                          //                   .toList()),
                          //         ),
                          //         Positioned(
                          //           bottom: Get.height * 0.017,
                          //           left: 0,
                          //           right: 0,
                          //           child: Center(
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: List.generate(
                          //                   controller.adList.length,
                          //                   (index) => Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                                 left: 3),
                          //                         child: CircleAvatar(
                          //                           radius: 5,
                          //                           backgroundColor: controller
                          //                                       .adIndex ==
                          //                                   index
                          //                               ? AppColors.primary
                          //                               : AppColors.primary
                          //                                   .withOpacity(0.2),
                          //                         ),
                          //                       )),
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   );
                          // } else {
                          return SizedBox(height: 5);
                          // }
                        },
                        builderDelegate: PagedChildBuilderDelegate<Doctor>(
                          itemBuilder: (context, item, index) {
                            return _doctorData(
                              context,
                              item,
                            );
                          },
                          noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
                          noItemsFoundIndicatorBuilder: (_) => Padding(
                            padding: EdgeInsets.only(top: h * 0.28),
                            child: PagingNoItemFountList(),
                          ),
                          firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                            controller: controller.pagingController,
                          ),
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
                    ),
                  ),

                  /*  Container(
                  height: h * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DOCTOR,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  // height: 220,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border:
                                        Border.all(color: AppColors.primary),
                                    boxShadow: [
                                      // BoxShadow(
                                      //   color: Colors.grey.withOpacity(0.1),
                                      //   spreadRadius: 7,
                                      //   blurRadius: 7,
                                      //   offset: Offset(0, 0),
                                      // ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: h * 0.2,
                                        width: w,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.black,

                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.lightGrey),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: "",
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // SizedBox(height: 10),
                                                    Text(
                                                      "Dr. Manu Django Conradine ",
                                                      style: AppTextTheme.h(12)
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "Internal Medicine",
                                                      style: AppTextTheme.b(11)
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5)),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        RatingBar.builder(
                                                          ignoreGestures: true,
                                                          itemSize: 15,
                                                          initialRating: 4,
                                                          // minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            // size: 10,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          '(12) Reviews',
                                                          style: AppTextTheme.b(
                                                                  12)
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Utils.openPhoneDialer(
                                                                  context,
                                                                  "3669595695");
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          w * 0.02),
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .secondary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Center(
                                                                child: Text(
                                                                  "call".tr,
                                                                  style: AppTextTheme
                                                                          .m(w *
                                                                              0.032)
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.white),
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
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              // BookingController.to.selectedDoctor(item);
                                                              Get.toNamed(
                                                                Routes.BOOK,
                                                                // arguments: [item, controller.arguments.cCategory],
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          w * 0.01),
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .lightBlack2,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Center(
                                                                child: Text(
                                                                  "appointment"
                                                                      .tr,
                                                                  style: AppTextTheme
                                                                          .m(w *
                                                                              0.032)
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.white),
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
                                      // if (item.address != null)
                                      // Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      // children: [
                                      // SvgPicture.asset(
                                      // "assets/svg/location_pin.svg",
                                      // color: AppColors.primary,
                                      // ).paddingOnly(top: 3),
                                      // SizedBox(width: 8),
                                      // Flexible(
                                      // child: Text(
                                      // item.address ?? "",
                                      // maxLines: 3,
                                      // style: AppTextTheme.b(12).copyWith(color: AppColors.lgt2),
                                      // overflow: TextOverflow.ellipsis,
                                      // ),
                                      // ),
                                      // ],
                                      // ).paddingVertical(8).onTap(() {
                                      // if (item.geometry?.coordinates !=
                                      // null) if (item.geometry.coordinates.length > 1) {
                                      // Utils.openGoogleMaps(item.geometry.coordinates[1],
                                      // item.geometry.coordinates[0]);
                                      // }
                                      // }),
                                      // SizedBox(
                                      // height: 5,
                                      // ),
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
                                              border: Border.all(
                                                  color: AppColors.primary),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                                FittedBox(
                                                  child: Text(
                                                    "Monday, August 10, 2022",
                                                    style: AppTextTheme.m(10)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                ),
                                                Spacer(),
                                                SvgPicture.asset(
                                                  AppImages.clock,
                                                  height: 15,
                                                  width: 15,
                                                  color: AppColors.primary,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    "09.00 - 10.00",
                                                    style: AppTextTheme.m(10)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ListTile(
                                      //     leading: AspectRatio(
                                      //       aspectRatio: 1,
                                      //       child: Container(
                                      //         // color: Colors.black,
                                      //         // height: 65,
                                      //         // width: 65,
                                      //         child: CachedNetworkImage(
                                      //           imageUrl: "${ApiConsts.hostUrl}${item.photo}",
                                      //           fit: BoxFit.cover,
                                      //           placeholder: (_, __) {
                                      //             return Image.asset(
                                      //               "assets/png/person-placeholder.jpg",
                                      //               fit: BoxFit.cover,
                                      //             );
                                      //           },
                                      //           errorWidget: (_, __, ___) {
                                      //             return Image.asset(
                                      //               "assets/png/person-placeholder.jpg",
                                      //               fit: BoxFit.cover,
                                      //             );
                                      //           },
                                      //         ),
                                      //       ).radiusAll(20),
                                      //       //   Image.network(
                                      //       //     "${ApiConsts.hostUrl}${item.photo}",
                                      //       //     fit: BoxFit.cover,
                                      //       //   ),
                                      //       // ).radiusAll(20),
                                      //     ),
                                      //     title: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.start,
                                      //       crossAxisAlignment: CrossAxisAlignment.center,
                                      //       mainAxisSize: MainAxisSize.min,
                                      //       children: [
                                      //         Flexible(
                                      //           child: Text(
                                      //             item.fullname ??
                                      //                 " ${item.name ?? ""} ${item.lname ?? ""}",
                                      //             style:
                                      //                 AppTextTheme.h(15).copyWith(color: AppColors.black2),
                                      //           ),
                                      //         ),
                                      //         if (item.verfied ?? false)
                                      //           Icon(
                                      //             Icons.verified,
                                      //             color: AppColors.verified,
                                      //           ).paddingHorizontal(6),
                                      //       ],
                                      //     ).paddingOnly(top: 8, bottom: 2),
                                      //
                                      //     // Text(
                                      //     //   "${item.name ?? ""} ${item.lname ?? ""}",
                                      //     //   style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
                                      //     // ).paddingOnly(top: 8),
                                      //     subtitle: Column(
                                      //       mainAxisAlignment: MainAxisAlignment.start,
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           item.category.title ?? "",
                                      //           style: AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                                      //         ),
                                      //         SizedBox(height: 8),
                                      //         Row(
                                      //           mainAxisSize: MainAxisSize.min,
                                      //           children: [
                                      //             RatingBar.builder(
                                      //               ignoreGestures: true,
                                      //               itemSize: 15,
                                      //               initialRating: item.stars.toDouble(),
                                      //               // minRating: 1,
                                      //               direction: Axis.horizontal,
                                      //               allowHalfRating: true,
                                      //               itemCount: 5,
                                      //               itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                      //               itemBuilder: (context, _) => Icon(
                                      //                 Icons.star,
                                      //                 color: Colors.amber,
                                      //                 // size: 10,
                                      //               ),
                                      //               onRatingUpdate: (rating) {
                                      //                 print(rating);
                                      //               },
                                      //             ),
                                      //             SizedBox(width: 4),
                                      //             Text(
                                      //               '(${double.tryParse(item.totalStar?.toStringAsFixed(1)) ?? ""})',
                                      //               style: AppTextTheme.b(10.5)
                                      //                   .copyWith(color: AppColors.lgt2),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         if (item.address != null)
                                      //           Row(
                                      //             crossAxisAlignment: CrossAxisAlignment.start,
                                      //             children: [
                                      //               SvgPicture.asset("assets/svg/location_pin.svg")
                                      //                   .paddingOnly(top: 4),
                                      //               SizedBox(width: 8),
                                      //               Flexible(
                                      //                 child: Text(
                                      //                   item.address ?? "",
                                      //                   maxLines: 3,
                                      //                   style: AppTextTheme.b(14)
                                      //                       .copyWith(color: AppColors.lgt2),
                                      //                   overflow: TextOverflow.ellipsis,
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ).paddingVertical(8).onTap(() {
                                      //             if (item.geometry?.coordinates !=
                                      //                 null) if (item.geometry.coordinates.length > 1) {
                                      //               Utils.openGoogleMaps(item.geometry.coordinates[1],
                                      //                   item.geometry.coordinates[0]);
                                      //             }
                                      //           }),
                                      //       ],
                                      //     ),
                                      //     onTap: () => Get.toNamed(Routes.DOCTOR, arguments: [item])),
                                      // SizedBox(height: 30),
                                      // Wrap(
                                      //   spacing: 8,
                                      //   runSpacing: 8,
                                      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     _buildButton(
                                      //       item,
                                      //       icon: SvgPicture.asset("assets/svg/call-24px.svg"),
                                      //       child: FittedBox(
                                      //         child: Text(
                                      //           "call".tr,
                                      //           style: AppTextTheme.m(14).copyWith(color: Colors.white),
                                      //         ),
                                      //       ),
                                      //       bgColor: AppColors.green,
                                      //       onTap: () => Utils.openPhoneDialer(context, item.phone),
                                      //
                                      //       //  () {
                                      //       //   final Uri _emailLaunchUri = Uri(
                                      //       //     scheme: 'tel',
                                      //       //     path: item.phone,
                                      //       //   );
                                      //       //   launch(_emailLaunchUri.toString())
                                      //       //       .onError((error, stackTrace) {
                                      //       //     //TODO Not tested
                                      //       //     ScaffoldMessenger.of(Get.context).showSnackBar(
                                      //       //       SnackBar(
                                      //       //         content: Text(
                                      //       //           error.toString(),
                                      //       //         ),
                                      //       //       ),
                                      //       //     );
                                      //
                                      //       //     return;
                                      //       //   });
                                      //       // },
                                      //     ),
                                      //     _buildButton(
                                      //       item,
                                      //       icon: SvgPicture.asset("assets/svg/date_range-24px.svg"),
                                      //       child: FittedBox(
                                      //         child: Text(
                                      //           "book_now".tr,
                                      //           style: AppTextTheme.m(14).copyWith(color: Colors.white),
                                      //         ),
                                      //       ),
                                      //       bgColor: AppColors.easternBlue,
                                      //       onTap:
                                      //           // loadMyDoctorsMode
                                      //           //     ? () {
                                      //           //         if (item.id == null || item.category == null) {
                                      //           //           // AppGetDialog.show(
                                      //           //           //     middleText: "doctor_id_or_category_is_null".tr);
                                      //
                                      //           //           AppGetDialog.showSeleceDoctorCategoryDialog(item,
                                      //           //               onChange: (cat) {
                                      //           //             BookingController.to.selectedDoctor(item);
                                      //           //             BookingController.to.selectedCategory(cat);
                                      //           //             Get.toNamed(
                                      //           //               Routes.BOOK,
                                      //           //               // arguments: [item, controller.arguments.cCategory],
                                      //           //             );
                                      //           //           });
                                      //           //           return;
                                      //           //         }
                                      //           //         BookingController.to.selectedDoctor(item);
                                      //           //         BookingController.to
                                      //           //             .selectedCategory(Category(id: item.category));
                                      //           //         Get.toNamed(
                                      //           //           Routes.BOOK,
                                      //           //           // arguments: [item.doctor, controller.arguments.cCategory],
                                      //           //         );
                                      //           //         //
                                      //           //         // AppGetDialog.showSeleceDoctorCategoryDialog(item,
                                      //           //         //     onChange: (cat) {
                                      //           //         //   BookingController.to.selectedDoctor(item);
                                      //           //         //   BookingController.to.selectedCategory(cat);
                                      //           //         //   Get.toNamed(
                                      //           //         //     Routes.BOOK,
                                      //           //         //     // arguments: [item, controller.arguments.cCategory],
                                      //           //         //   );
                                      //           //         // });
                                      //           //       }
                                      //           // :
                                      //           () {
                                      //         BookingController.to.selectedDoctor(item);
                                      //         Get.toNamed(
                                      //           Routes.BOOK,
                                      //           // arguments: [item, controller.arguments.cCategory],
                                      //         );
                                      //       },
                                      //     ),
                                      //   ],
                                      // ).paddingHorizontal(10),
                                      // SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )*/
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
        ),
      ),
    );
  }

  Widget _doctorData(BuildContext context, Doctor item) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var date;
    String? slot;

    if (item.schedules!.isNotEmpty) {
      if (item.schedules!.length == 1) {
        for (int i = 0; i <= 7; i++) {
          DateTime d = DateTime.now().add(Duration(days: i));
          if (item.schedules![0].dayOfWeek == d.weekday) {
            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules![0].times!.isNotEmpty) {
              slot = "${item.schedules![0].times!.first} - ${item.schedules![0].times!.last}";
            }

            break;
          }
        }
      } else {
        // List<Schedule> dataSort ;
        // dataSort.add(value)
        List da = [];
        item.schedules!.sort((a, b) => a.dayOfWeek!.compareTo(b.dayOfWeek!));
        for (int i = 0; i < item.schedules!.length; i++) {
          da.add(item.schedules![i].dayOfWeek);
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

        Schedule? data;
        item.schedules!.forEach((element) {
          if (element.dayOfWeek == finalWeekDay) {
            data = element;
          }
        });

        int indexxx = item.schedules!.indexOf(data!);

        if (indexxx == item.schedules!.length - 1) {
          indexxx = 0;
        } else {
          indexxx = indexxx + 1;
        }
        for (int i = 0; i <= 7; i++) {
          DateTime d = DateTime.now().add(Duration(days: i));

          if (d.weekday == 7) {
            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules![indexxx].times!.isNotEmpty) {
              slot = "${item.schedules![indexxx].times!.first} - ${item.schedules![indexxx].times!.last}";
            }
          }
          if (item.schedules![indexxx].dayOfWeek == d.weekday) {
            date = d
                .toPersianDateStr(
                  strDay: false,
                  strMonth: true,
                  useAfghaniMonthName: true,
                )
                .trim()
                .split(' ');
            if (item.schedules![indexxx].times!.isNotEmpty) {
              slot = "${item.schedules![indexxx].times!.first} - ${item.schedules![indexxx].times!.last}";
            }

            break;
          }
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 20, left: 20),
      child: GestureDetector(
        onTap: () {
          DoctorsController controller = Get.put(DoctorsController());
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
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightGrey),
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
                                    style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${item.speciality}",
                                  style: AppTextTheme.b(11).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 15,
                                      initialRating:
                                          double.parse(item.averageRatings == null ? "0.0" : item.averageRatings.toString() ?? "0.0"),
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
                                        Get.toNamed(Routes.REVIEW, arguments: ["Doctor_Review", item]);
                                      },
                                      child: Text(
                                        '(${item.totalFeedbacks == null ? 0 : item.totalFeedbacks ?? 0}) ${'reviews'.tr}',
                                        style: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
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
                                          Utils.openPhoneDialer(context, "${item.phone}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: w * 0.02),
                                          decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "call".tr,
                                              style: AppTextTheme.m(w * 0.032).copyWith(color: Colors.white),
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
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: w * 0.01),
                                          decoration: BoxDecoration(color: AppColors.lightBlack2, borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "appointment".tr,
                                              style: AppTextTheme.m(w * 0.032).copyWith(color: Colors.white),
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
                  // if (item.address != null)
                  // Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // children: [
                  // SvgPicture.asset(
                  // "assets/svg/location_pin.svg",
                  // color: AppColors.primary,
                  // ).paddingOnly(top: 3),
                  // SizedBox(width: 8),
                  // Flexible(
                  // child: Text(
                  // item.address ?? "",
                  // maxLines: 3,
                  // style: AppTextTheme.b(12).copyWith(color: AppColors.lgt2),
                  // overflow: TextOverflow.ellipsis,
                  // ),
                  // ),
                  // ],
                  // ).paddingVertical(8).onTap(() {
                  // if (item.geometry?.coordinates !=
                  // null) if (item.geometry.coordinates.length > 1) {
                  // Utils.openGoogleMaps(item.geometry.coordinates[1],
                  // item.geometry.coordinates[0]);
                  // }
                  // }),
                  // SizedBox(
                  // height: 5,
                  // ),
                  item.schedules!.isEmpty
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                      style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
                                    ),
                                    Text(
                                      " ${date[1]}",
                                      style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
                                    ),
                                    Text(
                                      " ${date[3]}",
                                      style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
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
                                          style: AppTextTheme.m(10).copyWith(color: AppColors.primary),
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
                      right: SettingsController.appLanguge != "English" ? null : 0,
                      left: SettingsController.appLanguge == "English" ? null : 0,
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
