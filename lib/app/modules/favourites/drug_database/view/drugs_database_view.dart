import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/drugs_shimmer.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/drug_database_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/controller/drugs_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/paging_indicators/dotdot_nomore_items.dart';

class DrugsDatabaseView extends GetView<DrugsController> {
  DrugsDatabaseView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar:
          AppAppBar.primaryAppBar(title: "drug_database".tr, savedIcon: true),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<DrugsController>(
              builder: (controller) {
                return Column(
                  children: [
                    searchTextField(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 18,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                                Divider(color: AppColors.primary, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Text(
                              "what_we_found".tr,
                              style: AppTextStyle.mediumPrimary11,
                            ),
                          ),
                          Expanded(
                            child:
                                Divider(color: AppColors.primary, thickness: 1),
                          ),
                        ],
                      ),
                    ),
                    BannerView(),
                    Expanded(
                      child: PagedListView.separated(
                        pagingController: controller.pageController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (c, i) {
                          return SizedBox(height: 15);
                        },
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, item, index) {
                            return drugsData(h, w, context, item);
                          },
                          noMoreItemsIndicatorBuilder: (_) =>
                              DotDotPagingNoMoreItems(),
                          noItemsFoundIndicatorBuilder: (_) =>
                              PagingNoItemFountList(),
                          firstPageErrorIndicatorBuilder: (context) =>
                              PagingErrorView(
                            controller: controller.pageController,
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
                    ),
                    /*   Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.medicinesNames.length,
                        itemBuilder: (context, index) {
                          if (!controller.medicinesNames[index]
                              .toUpperCase()
                              .trim()
                              .contains(
                                  controller.filterSearch.toUpperCase())) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              index == 0 ? BannerView() : SizedBox(),
                              PagedListView.separated(
                                pagingController: controller.pageController,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (c, i) {
                                  return SizedBox(height: 15);
                                },
                                builderDelegate: PagedChildBuilderDelegate(
                                  itemBuilder: (context, item, index) {
                                    return drugsData(h, w, context, item);
                                  },
                                  noMoreItemsIndicatorBuilder: (_) =>
                                      DotDotPagingNoMoreItems(),
                                  noItemsFoundIndicatorBuilder: (_) =>
                                      PagingNoItemFountList(),
                                  firstPageErrorIndicatorBuilder: (context) =>
                                      PagingErrorView(
                                    controller: controller.pageController,
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
                            ],
                          );
                        },
                      ),
                    ),*/
                    const SizedBox(
                      height: 80.0,
                    ),
                  ],
                );
              },
            ),
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
    );
  }

  Widget drugsData(
    double h,
    double w,
    context,
    Datum item,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DRUGS_DETAILS, arguments: item);
      },
      child: Container(
        height: h * 0.23,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: h * 0.119,
                    width: w * 0.327,
                    decoration: BoxDecoration(
                      color: AppColors.lightYellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConsts.hostUrl}${item.img}",
                      height: h * 0.082,
                      width: w * 0.178,
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Image.asset(
                          AppImages.vitamin,
                          height: h * 0.082,
                          width: w * 0.178,
                        );
                      },
                      errorWidget: (_, __, ___) {
                        return Image.asset(
                          AppImages.vitamin,
                          height: h * 0.082,
                          width: w * 0.178,
                        );
                      },
                    )

                    // Center(
                    //   child: Image.asset(
                    //     AppImages.vitamin,
                    //     height: h * 0.082,
                    //     width: w * 0.178,
                    //   ),
                    // ),
                    ),
                Container(
                  height: h * 0.023,
                  width: w * 0.327,
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple2,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          5,
                          (subIndex) {
                            return SvgPicture.asset(
                              subIndex == 4
                                  ? AppImages.favGrey
                                  : AppImages.favGolden,
                              height: 10,
                              width: 10,
                            ).paddingOnly(right: subIndex == 4 ? 0 : 6);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: w * 0.327,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: h * 0.023,
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple2,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages.circleInfo,
                            height: 10,
                            width: 10,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          SettingsController.drugData = [item];
                          controller.update();
                        },
                        child: Container(
                          height: h * 0.023,
                          width: w * 0.24,
                          decoration: BoxDecoration(
                            color: SettingsController.drugData.any(
                                    (element) => element.id.contains(item.id))
                                ? AppColors.primary
                                : AppColors.lightPurple2,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "add_to_list".tr,
                                style: SettingsController.drugData.any(
                                        (element) =>
                                            element.id.contains(item.id))
                                    ? AppTextStyle.boldWhite8
                                    : AppTextStyle.boldPrimary8,
                              ),
                              SizedBox(
                                width: w * 0.005,
                              ),
                              SettingsController.drugData.any(
                                      (element) => element.id.contains(item.id))
                                  ? Icon(
                                      Icons.favorite,
                                      size: w * 0.02,
                                      color: AppColors.white,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: w * 0.02,
                                      color: AppColors.primary,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.englishName}",
                    style: AppTextStyle.boldPrimary12.copyWith(height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${item.persianName}",
                    style: AppTextStyle.boldPrimary12.copyWith(height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${item.company}",
                    style: AppTextStyle.regularPrimary9.copyWith(height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 7,
                      top: 7,
                      right: 20,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (subIndex) => Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: h * 0.04,
                              width: h * 0.04,
                              padding: EdgeInsets.all(3),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: AppColors.lightPurple,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.asset(
                                controller.data[subIndex]["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.data[subIndex]["title"]
                                      .toString()
                                      .tr,
                                  style: AppTextStyle.boldPrimary9
                                      .copyWith(height: 1.2),
                                ),
                                Container(
                                  width: w * 0.35,
                                  child: Text(
                                    subIndex == 1
                                        ? item.pack
                                        : subIndex == 2
                                            ? controller.data[2]["text"]
                                                .toString()
                                                .trArgs([item.packsAndPrices])
                                            : item.drugType ?? "None",
                                    style: AppTextStyle.regularPrimary9
                                        .copyWith(height: 1),
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextField(
        controller: controller.searchController,
        onChanged: (s) async {
          controller.search(s);
          if (s.isEmpty) {
            controller.pageController.itemList.clear();
            controller.drugData(
              controller.pageController.firstPageKey,
            );
          }
        },
        onSubmitted: (v) async {
          controller.pageController.itemList.clear();
          controller.drugData(
            controller.pageController.firstPageKey,
          );
        },
        style: AppTextStyle.mediumPrimary11,
        cursorColor: AppColors.primary,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: "search_drugs".tr,
          hintStyle: AppTextStyle.mediumPrimary11,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(
              AppImages.search,
              color: AppColors.primary,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(AppImages.mic),
          ),
          filled: true,
          fillColor: AppColors.lightPurple2,
          constraints: BoxConstraints(maxHeight: 46),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.lightWhite,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.lightWhite,
            ),
          ),
        ),
      ),
    );
  }
}
