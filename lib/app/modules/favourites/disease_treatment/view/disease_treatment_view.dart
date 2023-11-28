import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseTreatmentView extends GetView<DiseaseTreatmentController> {
  DiseaseTreatmentView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("call---screen");
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(title: "all_diseases".tr),
      backgroundColor: AppColors.lightGrey,
      // bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: GetBuilder<DiseaseTreatmentController>(
        builder: (controller) {
          return controller.isLoading == true
              ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
              : Container(
                  height: h,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 80),
                        child: Container(
                          child: Column(
                            children: [
                              // BannerView(),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: controller.category.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(top: 18),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          controller.selectedCategory =
                                              controller.category[index];
                                          controller.dieaseDataList(controller
                                              .category[index].eTitle);
                                        });
                                        Get.toNamed(
                                          Routes.DISEASE_DETAILS,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(11)
                                            .copyWith(bottom: 0),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: h * 0.108,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                // color: AppColors.boxPink3,
                                                color: Color(int.parse(
                                                    "0xff${controller.category[index].background.replaceFirst("#", "")}")),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                  child: CachedNetworkImage(
                                                height: 52,
                                                width: 52,
                                                imageUrl:
                                                    "${ApiConsts.hostUrl}${controller.category[index].photo}",
                                                fit: BoxFit.cover,
                                                placeholder: (_, __) {
                                                  return Image.asset(
                                                    "assets/png/placeholder_hospital.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                                errorWidget: (_, __, ___) {
                                                  return Image.asset(
                                                    "assets/png/placeholder_hospital.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  SettingsController
                                                              .appLanguge ==
                                                          "English"
                                                      ? controller
                                                          .category[index]
                                                          .eTitle
                                                      : SettingsController
                                                                  .appLanguge ==
                                                              "فارسی"
                                                          ? controller
                                                              .category[index]
                                                              .fTitle
                                                          : controller
                                                              .category[index]
                                                              .pTitle,
                                                  style: AppTextStyle
                                                      .boldPrimary12
                                                      .copyWith(height: 1.2),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
        },
      ),
    );
  }
}
