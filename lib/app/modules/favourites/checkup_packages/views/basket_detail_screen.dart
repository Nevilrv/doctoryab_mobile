import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BasketDetailScreen extends StatelessWidget {
  const BasketDetailScreen({Key key}) : super(key: key);
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
                                  "basket_details".tr,
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
                      Container(
                        color: AppColors.darkBlue2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.map,
                                color: AppColors.grey2,
                              ),
                              Spacer(),
                              Text(
                                "Türkiye, Ankara",
                                style: AppTextStyle.boldGrey12.copyWith(
                                    color: AppColors.grey2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              Icon(
                                Icons.expand_more_outlined,
                                color: AppColors.grey2.withOpacity(0.8),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.76,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                                4,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: AppColors.grey3)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: w * 0.7,
                                                        child: Text(
                                                          "Full Body Checkup With Essentials Markers",
                                                          style: AppTextStyle
                                                              .boldBlack16
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.red2,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                              Icons.delete,
                                                              color: AppColors
                                                                  .white,
                                                              size: 22),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Full Body Checkup With Essentials Markers",
                                                        style: AppTextStyle
                                                            .boldBlack12
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "+100 Tests",
                                                        style: AppTextStyle
                                                            .boldBlack12
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .teal,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: w * 0.4,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: AppColors.red2
                                                            .withOpacity(0.1),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .red2
                                                                .withOpacity(
                                                                    0.1))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 10),
                                                      child: Center(
                                                        child: Text(
                                                          "%59 OFF",
                                                          style:
                                                              AppTextTheme.b(10)
                                                                  .copyWith(
                                                            color:
                                                                AppColors.red2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '345\$',
                                                        style: AppTextTheme.b(
                                                                25)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .grey),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '945\$',
                                                        style: AppTextTheme.b(
                                                                25)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: AppColors.grey3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.clock1,
                                                      width: 24,
                                                      height: 24,
                                                      color: AppColors.grey4),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${"report_text".tr} 15 Hours",
                                                    style: AppTextStyle
                                                        .mediumBlack12
                                                        .copyWith(
                                                            color: AppColors
                                                                .grey4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.grey3)),
                              child: Row(
                                children: [
                                  Container(
                                    width: w * 0.6,
                                    decoration: BoxDecoration(
                                        color: AppColors.teal,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8))),
                                    child: Center(
                                      child: Text(
                                        "proceed".tr,
                                        style: AppTextStyle.boldWhite15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '345\$',
                                            style: AppTextTheme.b(15).copyWith(
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            "view".tr,
                                            style: AppTextStyle.mediumWhite11
                                                .copyWith(
                                                    color: AppColors.teal,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
