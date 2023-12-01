import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
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
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/paging_indicators/dotdot_nomore_items.dart';
import '../../../../components/paging_indicators/no_item_list.dart';
import '../../../../components/paging_indicators/paging_error_view.dart';
import '../../../../components/shimmer/categories_grid_shimmer.dart';
import '../../../../components/shimmer/drugs_shimmer.dart';
import '../../../../data/models/checkupPackages_res_model.dart';

class CheckupPackagesView extends GetView<CheckupPackagesController> {
  CheckupPackagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<CheckupPackagesController>(
        builder: (controller) {
          return Container(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "health_packages_list".tr,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.boldWhite16,
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
                                          AppImages.history,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   right: 0,
                                  //   // top: -5,
                                  //   child: CircleAvatar(
                                  //     radius: 8,
                                  //     backgroundColor: AppColors.red2,
                                  //     child: Center(
                                  //       child: Text(
                                  //         "3",
                                  //         style: AppTextStyle.boldWhite10,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
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
                                onChanged: (s) async {
                                  if (s.isEmpty) {
                                    controller.search(s);
                                    controller.pagingController.itemList
                                        .clear();
                                    controller.fetchCheckUpPackages(
                                      controller.pagingController.firstPageKey,
                                    );
                                  } else {
                                    controller.search(s);
                                    controller.pagingController.itemList
                                        .clear();
                                    controller.fetchCheckUpPackages(
                                      controller.pagingController.firstPageKey,
                                    );
                                  }
                                },
                                onSubmitted: (v) async {
                                  controller.search(v);
                                  controller.pagingController.itemList.clear();
                                  controller.fetchCheckUpPackages(
                                    controller.pagingController.firstPageKey,
                                  );
                                },
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
                            GestureDetector(
                              onTap: () {
                                controller.start();
                              },
                              child: Container(
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
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        controller.isListening
                            ? Center(
                                child: Text(
                                  'Listening...',
                                  style: AppTextStyle.boldWhite14,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 10, horizontal: 20),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "health_packages_list".tr,
                  //         style: AppTextStyle.boldPrimary18,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: h * 0.62,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: PagedGridView(
                          pagingController: controller.pagingController,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          // padding:
                          //                       //     EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          physics: BouncingScrollPhysics(),

                          // itemCount: 9,
                          // primary: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            // childAspectRatio: 132 / 169,
                            // mainAxisExtent: 2,
                            mainAxisExtent: h * 0.32,

                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 9,
                          ),
                          // SliverGridDelegateWithMaxCrossAxisExtent(
                          //   // childAspectRatio: 1,
                          //   mainAxisSpacing: 40,
                          //   crossAxisSpacing: 20,
                          //   maxCrossAxisExtent: 120,
                          // ),
                          builderDelegate: PagedChildBuilderDelegate<Package>(
                            itemBuilder: (BuildContext context, item, int i) {
                              // var item = controller.dummyData[i];
                              // print("vvvvvvvvvvvvv" + context.size.height.toString());
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedTest = 0;

                                  controller.update();
                                  controller.packageReview(packageId: item.id);
                                  Get.to(CheckUpDetailScreen(item));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.grey5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                "${ApiConsts.hostUrl}${item.img}",
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
                                        "${item.title}",
                                        style: AppTextStyle.boldPrimary10
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      item.totalTests == "" ||
                                              item.totalTests == null
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                buildShowModalBottomSheet(
                                                    context,
                                                    h,
                                                    item.packageInclude);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${item.totalTests}",
                                                    style: AppTextStyle
                                                        .boldPrimary10
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8,
                                                            color:
                                                                AppColors.teal,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
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
                                            "${item.byObservation}",
                                            style: AppTextStyle.boldPrimary10
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8,
                                              color: AppColors.darkBlue1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
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
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 12,
                                            initialRating: double.parse(
                                                item.averageRatings == null
                                                    ? "0"
                                                    : item.averageRatings
                                                        .toString()),
                                            // minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
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
                                              '(${item.countOfPatient}) ${"booked".tr}',
                                              style: AppTextTheme.b(6).copyWith(
                                                  color: AppColors.grey4),
                                            ),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            item.price,
                                            style: AppTextTheme.b(12).copyWith(
                                                color: AppColors.grey),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            item.rrp,
                                            style: AppTextTheme.b(12).copyWith(
                                                color: AppColors.grey
                                                    .withOpacity(0.5),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                                decorationThickness: 2),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                AppColors.red2.withOpacity(0.1),
                                            border: Border.all(
                                                color: AppColors.red2
                                                    .withOpacity(0.1))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 10),
                                          child: Center(
                                            child: Text(
                                              "${item.discount} ${"OFF".tr}",
                                              style:
                                                  AppTextTheme.b(13).copyWith(
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
                                          Get.to(CheckUpDetailScreen(item));
                                          // Get.to(BookingInfoScreen());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.primary)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Center(
                                              child: Text(
                                                "book1".tr,
                                                style:
                                                    AppTextTheme.b(10).copyWith(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "${item.duration}",
                                          style: AppTextTheme.b(10).copyWith(
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                PackageGridShimmer(yCount: 2, xCount: 2
                                    // linesCount: 4,
                                    ),
                            newPageProgressIndicatorBuilder: (_) => Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primary,
                            )),
                          ),
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
          );
        },
      ),
    );
  }

  Future<void> buildShowModalBottomSheet(
      BuildContext context, double h, List<PackageInclude> item) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          "Package Includes ${item.length} Tests",
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
                          children: List.generate(item.length, (index) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item[index].testTitle,
                                      style: AppTextStyle.boldGrey12.copyWith(
                                          color: AppColors.grey6,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: Get.width * 0.72,
                                      child: Html(
                                          data: item[index].testDesc,
                                          defaultTextStyle:
                                              AppTextStyle.boldGrey10.copyWith(
                                                  color: AppColors.grey6,
                                                  fontWeight: FontWeight.w400)),
                                    ),
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
        );
      },
    );
  }
}
