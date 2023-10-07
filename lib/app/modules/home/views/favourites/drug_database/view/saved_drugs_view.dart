import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/drug_database/controller/drugs_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavedDrugsView extends GetView<DrugsController> {
  SavedDrugsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(title: "saved_drugs".tr),
      backgroundColor: AppColors.lightGrey,
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: Padding(
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
                        child: Divider(color: AppColors.primary, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          "saved_drugs".tr,
                          style: AppTextStyle.mediumPrimary11,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: AppColors.primary, thickness: 1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.medicinesNames.length,
                    itemBuilder: (context, index) {
                      if (!controller.medicinesNames[index]
                          .toUpperCase()
                          .trim()
                          .contains(controller.filterSearch.toUpperCase())) {
                        return const SizedBox();
                      }
                      return drugsData(h, w, index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget drugsData(double h, double w, int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DRUGS_DETAILS,
            arguments: controller.medicinesNames[index]);
      },
      child: Container(
        height: h * 0.216,
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
                  child: Center(
                    child: Image.asset(
                      AppImages.vitamin,
                      height: h * 0.082,
                      width: w * 0.178,
                    ),
                  ),
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
                        index == 0
                            ? Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text(
                                  "(${"reviews_count".trArgs(["5"])})",
                                  style: AppTextStyle.boldPrimary6,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
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
                        SvgPicture.asset(
                          AppImages.circleInfo,
                          height: 10,
                          width: 10,
                          color: AppColors.primary,
                        ).paddingOnly(right: 2),
                        Text(
                          "more_details".tr,
                          style: AppTextStyle.boldPrimary8,
                        )
                      ],
                    ),
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
                    controller.medicinesNames[index],
                    style: AppTextStyle.boldPrimary12.copyWith(height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "company".tr,
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
                                Text(
                                  subIndex == 1
                                      ? controller.data[1]["text"]
                                          .toString()
                                          .trArgs(["30"])
                                      : subIndex == 2
                                          ? controller.data[2]["text"]
                                              .toString()
                                              .trArgs(["1000"])
                                          : controller.data[subIndex]["text"]
                                              .toString()
                                              .tr,
                                  style: AppTextStyle.regularPrimary9
                                      .copyWith(height: 1),
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
        onChanged: (s) => controller.search(s),
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
