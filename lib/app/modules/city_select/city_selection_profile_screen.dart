import 'dart:convert';

import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/city_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/modules/city_select/controllers/city_select_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CitySelectProfileView extends GetView<CitySelectController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SpecialAppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'city_selection'.tr,
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: RotatedBox(
                  quarterTurns:
                      SettingsController.appLanguge == "English" ? 0 : 2,
                  child:
                      Icon(Icons.arrow_back_ios_new, color: AppColors.white))),
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(Routes.NOTIFICATION);
          //       },
          //       child: SvgPicture.asset(
          //         AppImages.bellwhite,
          //         height: 24,
          //         width: 24,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Obx(() {
          return Container(
            height: h,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: h * 0.6,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: PagedListView.separated(
                            separatorBuilder: (c, i) {
                              return SizedBox(height: 15);
                            },
                            pagingController: controller.pagedController,
                            physics: BouncingScrollPhysics(),
                            builderDelegate: PagedChildBuilderDelegate<City>(
                              itemBuilder: (context, item, index) {
                                // var item = controller.latestVideos[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedCityItem.value = item;

                                    // Get.find<TabHomeMainController>()
                                    //     .cityChanged(item);
                                    // Get.offAllNamed(Routes.HOME,
                                    //     arguments: {'id': 4});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            controller.selectedCityItem.value ==
                                                    item
                                                ? AppColors.primary
                                                : AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              color: AppColors.grey,
                                              blurRadius: 5)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Center(
                                        child: Text(
                                          item.getMultiLangName(),
                                          style: controller
                                                      .selectedCityItem.value ==
                                                  item
                                              ? AppTextStyle.boldWhite14
                                              : AppTextStyle.boldPrimary14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              // noMoreItemsIndicatorBuilder: (_) => PagingNoMoreItemList(),
                              noItemsFoundIndicatorBuilder: (_) =>
                                  PagingNoItemFountList(),
                              firstPageErrorIndicatorBuilder: (context) =>
                                  PagingErrorView(
                                controller: controller.pagedController,
                              ),
                              firstPageProgressIndicatorBuilder: (_) =>
                                  CityShimmer(
                                linesCount: 4,
                                baseColor: AppColors.white.withOpacity(0.4),
                              ),
                              newPageProgressIndicatorBuilder: (_) =>
                                  CityShimmer(
                                linesCount: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.03),
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedCityItem.value.sId != null) {
                            Get.back();

                            SettingsController.auth.savedCity = City.fromJson(
                                jsonDecode(jsonEncode(
                                    controller.selectedCityItem.value)));
                            Get.find<TabHomeMainController>()
                                .cityChanged(SettingsController.auth.savedCity);
                            Get.offAllNamed(Routes.HOME, arguments: {'id': 4});
                          } else {
                            Utils.showSnackBar(context, "Please select city");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(0.2)),
                                color: controller.selectedCityItem.value.sId !=
                                        null
                                    ? AppColors.white
                                    : AppColors.primary),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Center(
                                child: Text(
                                  "save_city_selection".tr,
                                  style: AppTextStyle.boldWhite12.copyWith(
                                      fontSize: 11,
                                      color: controller
                                                  .selectedCityItem.value.sId !=
                                              null
                                          ? AppColors.primary
                                          : AppColors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.03),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                              thickness: 2,
                              color: AppColors.white.withOpacity(0.5))),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: BottomBarView(
                      isHomeScreen: false,
                      isBlueBackground: true,
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
