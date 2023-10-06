import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/NewItems.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/drug_store_lab_view.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/pharmacy_detail_screen.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_others_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/app_text_styles.dart';
import '/app/extentions/widget_exts.dart';

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
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.zero,
                      width: 80,
                      height: 60,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          thumbIcon: MaterialStateProperty.resolveWith<Icon>(
                            (Set<MaterialState> states) {
                              return Icon(
                                FeatherIcons.moon,
                                color: AppColors.switchGreen,
                              );
                            },
                          ),
                          activeColor: AppColors.white,
                          splashRadius: 50,
                          value: controller.light1.value,
                          activeTrackColor: AppColors.switchGreen,
                          inactiveTrackColor: AppColors.switchGreen,
                          onChanged: (bool value) {
                            // controller.setEmergencyMode(value);
                            controller.light1.value = value;
                          },
                        ),
                      ),
                    ),
                    Text(
                      "نوکریوال".tr,
                      style: AppTextStyle.mediumBlack12
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(PharmacyDetailScreen());
                            // Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                                                  BorderRadius.circular(10),
                                              color: AppColors.lightGrey),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: "",
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
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "Afghan Hospital",
                                                      style: AppTextTheme.h(15)
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.green
                                                        .withOpacity(0.1)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  child: Text(
                                                    "نوکریوال",
                                                    style: AppTextStyle
                                                        .mediumBlack12
                                                        .copyWith(
                                                            color: AppColors
                                                                .green),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "شفاخانه افغان",
                                                style: AppTextTheme.b(14)
                                                    .copyWith(
                                                        color: AppColors.lgt2),
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 15,
                                                    initialRating: 4,
                                                    // minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
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
                                                    '5.0 - 10 Reviews',
                                                    style: AppTextTheme.b(12)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.5)),
                                                  ).paddingOnly(top: 3),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Utils.openPhoneDialer(
                                                            context,
                                                            "369988888");
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .secondary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          children: [
                                                            Spacer(),
                                                            Center(
                                                              child: Text(
                                                                "call".tr,
                                                                style: AppTextTheme
                                                                        .m(14)
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            SvgPicture.asset(
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
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.lightGrey),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/location_pin.svg",
                                          color: AppColors.primary,
                                        ).paddingOnly(top: 3),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            "H4FC+6VJ, Kabul, Afganistan, H4FC+6VJ، کابل",
                                            maxLines: 1,
                                            style: AppTextTheme.b(13).copyWith(
                                                color: AppColors.lgt2),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ).paddingVertical(8).onTap(() {
                                      // if (item.geometry?.coordinates !=
                                      //     null) if (item.geometry.coordinates.length > 1) {
                                      //   Utils.openGoogleMaps(item.geometry.coordinates[1],
                                      //       item.geometry.coordinates[0]);
                                      // }
                                    }),
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
                    }),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
