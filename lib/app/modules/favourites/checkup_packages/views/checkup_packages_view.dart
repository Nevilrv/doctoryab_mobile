import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/booking_info_screen.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/checkup_detail_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckupPackagesView extends GetView<CheckupPackagesController> {
  CheckupPackagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: h,
        child: Stack(
          children: [
            Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(20).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 45, bottom: 15),
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
                                "checkup_lists".tr,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.searchController,
                            // onChanged: (s) => controller.search(s),
                            style: AppTextStyle.mediumPrimary11,
                            cursorColor: AppColors.primary,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "search...".tr,
                              hintStyle: AppTextStyle.boldGrey16.copyWith(
                                  fontSize: 15,
                                  color: AppColors.grey4,
                                  fontWeight: FontWeight.w400),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  AppImages.search,
                                  color: AppColors.grey4,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.lightPurple2,
                              constraints: BoxConstraints(maxHeight: 46),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.lightWhite,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColors.lightWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightPurple2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 13,
                            ),
                            child: SvgPicture.asset(AppImages.mic),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "location".tr,
                      style: AppTextStyle.boldGrey12
                          .copyWith(color: AppColors.grey2.withOpacity(0.7)),
                    ),
                    Row(
                      children: [
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
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "health_packages_list".tr,
                      style: AppTextStyle.boldPrimary18,
                    ),
                    Spacer(),
                    Text(
                      "view_all".tr,
                      style: AppTextStyle.boldLightGrey12.copyWith(
                          color: AppColors.grey4,
                          fontSize: 13,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: h * 0.57,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: GridView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 9,
                          mainAxisExtent: h * 0.32),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(CheckUpDetailScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.grey5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  child: Container(
                                    height: h * 0.1,
                                    width: w,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
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
                                Text(
                                  "Fasting Blood Sugar (FBS) Lorem Ipsum Test Text Text",
                                  style: AppTextStyle.boldPrimary10
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    buildShowModalBottomSheet(context, h);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Includes 90 tests",
                                        style: AppTextStyle.boldPrimary10
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8,
                                                color: AppColors.teal,
                                                decoration:
                                                    TextDecoration.underline),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: AppColors.teal,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "by Turkish Doctors",
                                      style:
                                          AppTextStyle.boldPrimary10.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color: AppColors.darkBlue1,
                                      ),
                                    ),
                                    Image.asset(
                                      AppImages.turkey1,
                                      height: 10,
                                      width: 13,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 12,
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
                                      onTap: () {},
                                      child: Text(
                                        '(10) ${"booked".tr}',
                                        style: AppTextTheme.b(6)
                                            .copyWith(color: AppColors.grey4),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      '345\$',
                                      style: AppTextTheme.b(12)
                                          .copyWith(color: AppColors.grey),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '945\$',
                                      style: AppTextTheme.b(12).copyWith(
                                          color:
                                              AppColors.grey.withOpacity(0.5),
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.red2.withOpacity(0.1),
                                      border: Border.all(
                                          color:
                                              AppColors.red2.withOpacity(0.1))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "%59 OFF",
                                        style: AppTextTheme.b(10).copyWith(
                                          color: AppColors.red2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(BookingInfoScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.primary)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "book1".tr,
                                          style: AppTextTheme.b(10).copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${"report_text".tr} 24-48 Hours",
                                    style: AppTextTheme.b(8).copyWith(
                                        color: AppColors.grey.withOpacity(0.5),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ]),
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

  Future<void> buildShowModalBottomSheet(BuildContext context, double h) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: Container(
            height: h * 0.72,
            decoration: BoxDecoration(
                color: AppColors.grey5,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 5,
                        width: 188,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.black3),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImages.box,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Package Includes 102 Tests",
                            style: AppTextStyle.boldPrimary15,
                          ),
                          Spacer(),
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
                                child: Icon(Icons.cancel_outlined,
                                    color: AppColors.primary, size: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: List.generate(6, (index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: AppColors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Immature Granulocyte Percentage",
                                        style: AppTextStyle.boldGrey12.copyWith(
                                            color: AppColors.grey6,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ...List.generate(5, (index) {
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: AppColors.blue,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Immature Granulocyte Percentage",
                                              style: AppTextStyle.boldGrey10
                                                  .copyWith(
                                                      color: AppColors.grey6,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ],
                                        );
                                      }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
