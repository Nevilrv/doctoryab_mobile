import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/booking_info_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckUpDetailScreen extends GetView<CheckupPackagesController> {
  Package item;
  CheckUpDetailScreen(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 45, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.back2,
                                    height: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "checkup_details".tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.boldWhite20,
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(BasketDetailScreen());
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.bag,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  // top: -5,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColors.red2,
                                    child: Center(
                                      child: Text(
                                        "3",
                                        style: AppTextStyle.boldWhite10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.75,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            child: Container(
                              height: h * 0.2,
                              width: w,
                              child: CachedNetworkImage(
                                imageUrl: "${ApiConsts.hostUrl}${item.img}",
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            item.title ?? "",
                            style: AppTextStyle.boldBlack18.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: new TextSpan(
                              text: item.description ?? "",
                              style: AppTextStyle.boldBlack12.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text:
                                        item.packageInclude.length.toString() +
                                            " " +
                                            "Tests",
                                    style: AppTextStyle.boldBlack12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.teal,
                                        decoration: TextDecoration.underline)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.coin,
                                height: 30,
                                width: 30,
                              ),
                              Text(
                                item.price ?? "0.0",
                                style: AppTextTheme.b(25)
                                    .copyWith(color: AppColors.grey),
                              ),
                              Spacer(),
                              item.discount == "0" || item.discount == null
                                  ? SizedBox()
                                  : Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              AppColors.red2.withOpacity(0.1),
                                          border: Border.all(
                                              color: AppColors.red2
                                                  .withOpacity(0.1))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "%${item.discount ?? 0} OFF",
                                            style: AppTextTheme.b(10).copyWith(
                                              color: AppColors.red2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Spacer(),
                              item.discount == "0" || item.discount == null
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        Image.asset(
                                          AppImages.coin,
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(
                                          item.rrp ?? "0.0",
                                          style: AppTextTheme.b(25).copyWith(
                                              color: AppColors.grey
                                                  .withOpacity(0.5),
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),
                          // Row(
                          //   children: [
                          //     SvgPicture.asset(AppImages.calender1,
                          //         width: 24, height: 24),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text(
                          //       "slot_available".tr,
                          //       style: AppTextStyle.mediumBlack12,
                          //     ),
                          //     Text(
                          //       " 06:00 AM, Today",
                          //       style: AppTextStyle.boldBlack12,
                          //     )
                          //   ],
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.clock1,
                                  width: 24, height: 24),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"report_text".tr} ${item.duration}",
                                style: AppTextStyle.mediumBlack12,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.arrow,
                                  width: 24, height: 24),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "sample_type".tr,
                                style: AppTextStyle.mediumBlack12,
                              ),
                              Spacer(),
                              Container(
                                width: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.red2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      "",
                                      style: AppTextTheme.b(10).copyWith(
                                        color: AppColors.red2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.red2.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      "${item.sampleType ?? ""}",
                                      style: AppTextTheme.b(10).copyWith(
                                        color: AppColors.red2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.cap,
                                  width: 24, height: 24),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "fasting_required".tr,
                                style: AppTextStyle.mediumBlack12,
                              ),
                              Spacer(),
                              Container(
                                width: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.red2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      "",
                                      style: AppTextTheme.b(10).copyWith(
                                        color: AppColors.red2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.red2.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      "${item.fastingRequired ?? ""}",
                                      style: AppTextTheme.b(10).copyWith(
                                        color: AppColors.red2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          item.packageInclude.isEmpty
                              ? SizedBox()
                              : Row(
                                  children: [
                                    SvgPicture.asset(AppImages.box,
                                        width: 24,
                                        height: 24,
                                        color: AppColors.black6),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "pack_includes".tr,
                                      style: AppTextStyle.mediumBlack12,
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: AppColors.red2,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "",
                                            style: AppTextTheme.b(10).copyWith(
                                              color: AppColors.red2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: AppColors.red2.withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "show_all".tr,
                                            style: AppTextTheme.b(10).copyWith(
                                              color: AppColors.red2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          item.packageInclude.isEmpty
                              ? SizedBox()
                              : SizedBox(
                                  height: 5,
                                ),
                          item.packageInclude.isEmpty
                              ? SizedBox()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      item.packageInclude.length,
                                      (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          // width: Get.width * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.blue,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: AppColors.white,
                                                    size: 7,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    item.packageInclude[index]
                                                        .testTitle,
                                                    style: AppTextTheme.b(10)
                                                        .copyWith(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.blue,
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 5, horizontal: 10),
                          //           child: Center(
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.circle,
                          //                   color: AppColors.white,
                          //                   size: 7,
                          //                 ),
                          //                 Spacer(),
                          //                 Text(
                          //                   "FBS",
                          //                   style: AppTextTheme.b(10).copyWith(
                          //                     color: AppColors.white,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.blue,
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 5, horizontal: 10),
                          //           child: Center(
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.circle,
                          //                   color: AppColors.white,
                          //                   size: 7,
                          //                 ),
                          //                 Spacer(),
                          //                 Text(
                          //                   "Amylase",
                          //                   style: AppTextTheme.b(10).copyWith(
                          //                     color: AppColors.white,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.blue,
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 5, horizontal: 10),
                          //           child: Center(
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.circle,
                          //                   color: AppColors.white,
                          //                   size: 7,
                          //                 ),
                          //                 Spacer(),
                          //                 Text(
                          //                   "Ferritian",
                          //                   style: AppTextTheme.b(10).copyWith(
                          //                     color: AppColors.white,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.blue,
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 5, horizontal: 10),
                          //           child: Center(
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.circle,
                          //                   color: AppColors.white,
                          //                   size: 7,
                          //                 ),
                          //                 Spacer(),
                          //                 Text(
                          //                   "FBS",
                          //                   style: AppTextTheme.b(10).copyWith(
                          //                     color: AppColors.white,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.circleInfo,
                                  width: 24,
                                  height: 24,
                                  color: AppColors.black6),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "decription".tr,
                                style: AppTextStyle.mediumBlack12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.black6, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ExpandableText(
                                "${item.description}",
                                expandText: 'Read more',
                                collapseText: 'Read less',
                                maxLines: 3,
                                linkColor: AppColors.primary,
                                style: AppTextStyle.boldPrimary12.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black6,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    "${ApiConsts.hostUrl}${item.observerImg}",
                                height: 10,
                                width: 13,
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Check by ${item.byObservation}",
                                style: AppTextStyle.mediumBlack12,
                              ),
                              // Text(
                              //   " (Cardiology)",
                              //   style: AppTextStyle.mediumBlack12
                              //       .copyWith(color: AppColors.teal),
                              // ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(BookingInfoScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.teal,
                                  border: Border.all(color: AppColors.teal)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 10),
                                child: Center(
                                  child: Text(
                                    "book1".tr,
                                    style: AppTextTheme.b(15).copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BottomBarView(
                  isHomeScreen: false,
                ))
          ],
        ),
      ),
    );
  }
}
