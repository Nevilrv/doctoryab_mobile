import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/doctor_list_tile_item.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/doctor_listtile_shimmer.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:doctor_yab/app/modules/doctors/views/doctors_view.dart';
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

class TabSearchView extends GetView<TabSearchController> {
  @override
  Widget build(BuildContext context) {
    return Background(
      isSecond: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppAppBar.specialAppBar('search_doctor'.tr,
            backgroundColor: Colors.transparent,
            action: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                AppImages.blackBell,
                height: 24,
              ),
            )),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    child: BannerView(),
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
                          )
                        : Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.2),
                            child: Text("no_result_found".tr),
                          ))
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
          child: Column(
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
                            Text(
                              "${item.name}",
                              style: AppTextTheme.h(12)
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${item.speciality}",
                              style: AppTextTheme.b(11).copyWith(
                                  color: AppColors.primary.withOpacity(0.5)),
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
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
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
                                          vertical: 5, horizontal: w * 0.02),
                                      decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "call".tr,
                                          style: AppTextTheme.m(w * 0.032)
                                              .copyWith(color: Colors.white),
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
                                          vertical: 5, horizontal: w * 0.01),
                                      decoration: BoxDecoration(
                                          color: AppColors.lightBlack2,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "appointment".tr,
                                          style: AppTextTheme.m(w * 0.032)
                                              .copyWith(color: Colors.white),
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
                        FittedBox(
                          child: Text(
                            "Monday, August 10, 2022",
                            style: AppTextTheme.m(10)
                                .copyWith(color: AppColors.primary),
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
                                .copyWith(color: AppColors.primary),
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
