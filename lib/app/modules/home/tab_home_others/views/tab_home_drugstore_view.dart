import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/NewItems.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/categories_grid_shimmer.dart';
import 'package:doctor_yab/app/components/shimmer/city_shimmer.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/drug_store_lab_view.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/pharmacy_detail_screen.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_others_view.dart';
import 'package:doctor_yab/app/modules/review/view/review_screen.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import '../../../../utils/app_text_styles.dart';
import '/app/extentions/widget_exts.dart';
import 'dart:math' as math;

class TabHomeDrugstoreView extends GetView<DrugStoreController> {
  // @override
  // bool get pageHas24Hours => true;
  // @override
  // Widget buildItem(c, it, i) {
  //   int _calculateWekday(DateTime d) {
  //     return d.weekday == 7 ? 0 : d.weekday;
  //   }
  //
  //   debugPrint((DateTime(2021, 7, 30).weekday).toString() + " weakday-now");
  //
  //   return NewItems(
  //     // is24Hour: i % 2 == 0,
  //     is24Hour:
  //         it.the24Hours?.contains(_calculateWekday(DateTime.now())) ?? false,
  //     title: it.name,
  //     address: it.address,
  //     phoneNumber: (it.phone?.length ?? 0) > 0 ? it.phone[0] : null,
  //     imagePath: it.photo,
  //     latLng: it.geometry.coordinates,
  //   ).onTap(() {
  //     Get.to(() => DrugStoreLabView(
  //         Labs.fromJson(it.toJson()), DRUG_STORE_LAB_PAGE_TYPE.drugstore));
  //     // Get.to(() => DoctorsView(
  //     //       action: DOCTORS_LOAD_ACTION.ofhospital,
  //     //       hospitalId: it.id ?? "",
  //     //       hospitalName: it.name,
  //     //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Container(
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
                            style:
                                AppTextStyle.boldWhite12.copyWith(fontSize: 13),
                          ),
                        ],
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
                        AppImages.moon,
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
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: "search_pharmacy".tr,
                hintStyle: AppTextStyle.mediumPrimary11.copyWith(fontSize: 13),
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
            BannerView(),
            SizedBox(
              height: 10,
            ),
            PagedListView.separated(
              pagingController: controller.pageController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (c, i) {
                return SizedBox(height: 15);
              },
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) {
                  return _drugData(context, item, h, w);
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
            // SingleChildScrollView(
            //   physics: BouncingScrollPhysics(),
            //   child: Column(
            //     children: List.generate(3, (index) {
            //       return Padding(
            //         padding: EdgeInsets.symmetric(vertical: 10),
            //         child: GestureDetector(
            //           onTap: () {
            //             Get.to(PharmacyDetailScreen());
            //             // Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
            //           },
            //           child: Container(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //             // height: 220,
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(15),
            //             ),
            //             child: Column(
            //               children: [
            //                 Container(
            //                   // height: h * 0.2,
            //                   width: w,
            //                   child: Row(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Stack(
            //                         clipBehavior: Clip.none,
            //                         children: [
            //                           Container(
            //                             // color: Colors.black,
            //                             // height: 65,
            //                             // width: 65,
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10),
            //                                 color: AppColors.lightGrey),
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: CachedNetworkImage(
            //                                 imageUrl: "",
            //                                 height: h * 0.11,
            //                                 width: h * 0.11,
            //                                 fit: BoxFit.cover,
            //                                 placeholder: (_, __) {
            //                                   return Image.asset(
            //                                     "assets/png/person-placeholder.jpg",
            //                                     fit: BoxFit.cover,
            //                                   );
            //                                 },
            //                                 errorWidget: (_, __, ___) {
            //                                   return Image.asset(
            //                                     "assets/png/person-placeholder.jpg",
            //                                     fit: BoxFit.cover,
            //                                   );
            //                                 },
            //                               ),
            //                             ),
            //                           ),
            //                           Positioned(
            //                               top: -5,
            //                               left: -5,
            //                               child: SvgPicture.asset(
            //                                   AppImages.roundedMoon))
            //                         ],
            //                       ),
            //                       Expanded(
            //                         flex: 3,
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               horizontal: 5),
            //                           child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               // SizedBox(height: 10),
            //                               Text(
            //                                 "drugStore[index].name",
            //                                 style: AppTextTheme.h(12).copyWith(
            //                                     color: AppColors.primary),
            //                               ),
            //
            //                               SizedBox(height: 2),
            //                               Row(
            //                                 mainAxisSize: MainAxisSize.min,
            //                                 children: [
            //                                   RatingBar.builder(
            //                                     ignoreGestures: true,
            //                                     itemSize: 17,
            //                                     initialRating: 4,
            //                                     // minRating: 1,
            //                                     direction: Axis.horizontal,
            //                                     allowHalfRating: true,
            //                                     itemCount: 5,
            //                                     itemPadding:
            //                                         EdgeInsets.symmetric(
            //                                             horizontal: 1.0),
            //                                     itemBuilder: (context, _) =>
            //                                         Icon(
            //                                       Icons.star,
            //                                       color: Colors.amber,
            //                                       // size: 10,
            //                                     ),
            //                                     onRatingUpdate: (rating) {
            //                                       print(rating);
            //                                     },
            //                                   ),
            //                                   SizedBox(width: 4),
            //                                   GestureDetector(
            //                                     onTap: () {
            //                                       Get.to(ReviewScreen(
            //                                         appBarTitle:
            //                                             "pharmacy_reviews",
            //                                       ));
            //                                     },
            //                                     child: Text(
            //                                       '(10) ${"reviews".tr}',
            //                                       style: AppTextTheme.b(12)
            //                                           .copyWith(
            //                                               color: AppColors
            //                                                   .primary
            //                                                   .withOpacity(
            //                                                       0.5)),
            //                                     ).paddingOnly(top: 3),
            //                                   ),
            //                                 ],
            //                               ),
            //                               SizedBox(height: 5),
            //                               Row(
            //                                 children: [
            //                                   Expanded(
            //                                     child: GestureDetector(
            //                                       onTap: () {
            //                                         Utils.openPhoneDialer(
            //                                             context, "1234567890");
            //                                       },
            //                                       child: Container(
            //                                         padding:
            //                                             EdgeInsets.symmetric(
            //                                                 vertical: 5,
            //                                                 horizontal: 5),
            //                                         decoration: BoxDecoration(
            //                                             color:
            //                                                 AppColors.secondary,
            //                                             borderRadius:
            //                                                 BorderRadius
            //                                                     .circular(10)),
            //                                         child: Row(
            //                                           children: [
            //                                             Spacer(),
            //                                             Center(
            //                                               child: Text(
            //                                                 "call".tr,
            //                                                 style: AppTextTheme
            //                                                         .m(12)
            //                                                     .copyWith(
            //                                                         color: Colors
            //                                                             .white),
            //                                               ),
            //                                             ),
            //                                             Spacer(),
            //                                             SettingsController
            //                                                         .appLanguge !=
            //                                                     "English"
            //                                                 ? Transform(
            //                                                     alignment:
            //                                                         Alignment
            //                                                             .center,
            //                                                     transform: Matrix4
            //                                                         .rotationY(
            //                                                             math.pi),
            //                                                     child: SvgPicture
            //                                                         .asset(AppImages
            //                                                             .phone),
            //                                                   )
            //                                                 : SvgPicture.asset(
            //                                                     AppImages.phone)
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 5,
            //                 ),
            //                 Container(
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(5),
            //                       color: AppColors.lightGrey,
            //                       border: Border.all(color: AppColors.primary)),
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 10, vertical: 5),
            //                     child: Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SvgPicture.asset(
            //                           "assets/svg/location_pin.svg",
            //                           color: AppColors.primary,
            //                         ),
            //                         SizedBox(width: 8),
            //                         Flexible(
            //                           child: Text(
            //                             "H4FC+6VJ, Kabul, Afganistan, H4FC+6VJ، کابل",
            //                             maxLines: 1,
            //                             style: AppTextTheme.b(10)
            //                                 .copyWith(color: AppColors.primary),
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ),
            //                       ],
            //                     ).paddingVertical(8).onTap(() {
            //                       // if (item.geometry?.coordinates !=
            //                       //     null) if (item.geometry.coordinates.length > 1) {
            //                       //   Utils.openGoogleMaps(item.geometry.coordinates[1],
            //                       //       item.geometry.coordinates[0]);
            //                       // }
            //                     }),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 5,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _drugData(
    context,
    DrugStore item,
    h,
    w,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(PharmacyDetailScreen());
        // Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
                      // Positioned(
                      //     top: -5,
                      //     left: -5,
                      //     child: SvgPicture.asset(AppImages.roundedMoon))
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
                            "${item.name}",
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
                                initialRating: 4,
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
                                  Get.to(ReviewScreen(
                                    appBarTitle: "pharmacy_reviews",
                                  ));
                                },
                                child: Text(
                                  '(10) ${"reviews".tr}',
                                  style: AppTextTheme.b(12).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                ).paddingOnly(top: 3),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Utils.openPhoneDialer(
                                        context, "${item.phone}");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Center(
                                          child: Text(
                                            "call".tr,
                                            style: AppTextTheme.m(12)
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Spacer(),
                                        SettingsController.appLanguge !=
                                                "English"
                                            ? Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(math.pi),
                                                child: SvgPicture.asset(
                                                    AppImages.phone),
                                              )
                                            : SvgPicture.asset(AppImages.phone)
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
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.lightGrey,
                  border: Border.all(color: AppColors.primary)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/location_pin.svg",
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        // "H4FC+6VJ, Kabul, Afganistan, H4FC+6VJ، کابل",
                        "${item.address}",
                        maxLines: 1,
                        style: AppTextTheme.b(10)
                            .copyWith(color: AppColors.primary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ).paddingVertical(8).onTap(() {}),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
// class TabHomeDrugstoreView
//     extends TabHomeOthersView<DrugStoreController, DrugStore> {
//   @override
//   bool get pageHas24Hours => true;
//   @override
//   Widget buildItem(c, it, i) {
//     int _calculateWekday(DateTime d) {
//       return d.weekday == 7 ? 0 : d.weekday;
//     }
//
//    debugPrint((DateTime(2021, 7, 30).weekday).toString() + " weakday-now");
//
//     return NewItems(
//       // is24Hour: i % 2 == 0,
//       is24Hour:
//           it.the24Hours?.contains(_calculateWekday(DateTime.now())) ?? false,
//       title: it.name,
//       address: it.address,
//       phoneNumber: (it.phone?.length ?? 0) > 0 ? it.phone[0] : null,
//       imagePath: it.photo,
//       latLng: it.geometry.coordinates,
//     ).onTap(() {
//       Get.to(() => DrugStoreLabView(
//           Labs.fromJson(it.toJson()), DRUG_STORE_LAB_PAGE_TYPE.drugstore));
//       // Get.to(() => DoctorsView(
//       //       action: DOCTORS_LOAD_ACTION.ofhospital,
//       //       hospitalId: it.id ?? "",
//       //       hospitalName: it.name,
//       //     ));
//     });
//   }
// }
