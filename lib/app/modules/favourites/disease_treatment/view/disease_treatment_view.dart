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

  final List diseaseData = [
    {
      "image": AppImages.commonDiseases,
      "title": "com_diseases".tr,
      "color": AppColors.boxPurple
    },
    {
      "image": AppImages.healthCare,
      "title": "health_care".tr,
      "color": AppColors.boxRed
    },
    {
      "image": AppImages.viruses,
      "title": "viruses".tr,
      "color": AppColors.boxGreen
    },
    {
      "image": AppImages.mentalHealth,
      "title": "mental_health".tr,
      "color": AppColors.lightYellow
    },
    {
      "image": AppImages.humanHead,
      "title": "ear".tr,
      "color": AppColors.boxBlue
    },
    {
      "image": AppImages.cancer,
      "title": "cancer".tr,
      "color": AppColors.boxPink
    },
    {
      "image": AppImages.poison,
      "title": "infection".tr,
      "color": AppColors.boxGreen2
    },
    {
      "image": AppImages.injuries,
      "title": "injuries".tr,
      "color": AppColors.boxGreen3
    },
    {
      "image": AppImages.pregnancy,
      "title": "pregnancy".tr,
      "color": AppColors.boxYellow
    },
    {
      "image": AppImages.eyes,
      "title": "eyes".tr,
      "color": AppColors.boxPurple2
    },
    {
      "image": AppImages.muscles,
      "title": "muscles".tr,
      "color": AppColors.boxPink2
    },
    {
      "image": AppImages.nails,
      "title": "skins".tr,
      "color": AppColors.boxYellow2
    },
    {
      "image": AppImages.stomach,
      "title": "stomach".tr,
      "color": AppColors.boxYellow3
    },
    {
      "image": AppImages.immuneSystem,
      "title": "immune".tr,
      "color": AppColors.boxPink3
    },
    {
      "image": AppImages.glands,
      "title": "glands".tr,
      "color": AppColors.boxBlue2
    },
    {
      "image": AppImages.kidney,
      "title": "kidney".tr,
      "color": AppColors.boxPurple3
    },
  ];

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
              ? Center(child: CircularProgressIndicator())
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
                                        controller.dieaseDataList(
                                            controller.category[index].eTitle);
                                        controller.selectedCategory =
                                            controller.category[index];
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
