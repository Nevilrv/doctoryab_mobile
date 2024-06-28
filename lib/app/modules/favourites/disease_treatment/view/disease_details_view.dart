import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../controllers/settings_controller.dart';

class DiseaseDetailsView extends GetView<DiseaseTreatmentController> {
  DiseaseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<DiseaseTreatmentController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppAppBar.primaryAppBar(
                title: SettingsController.appLanguge == "English"
                    ? controller.selectedCategory?.eTitle ?? ''
                    : SettingsController.appLanguge == "فارسی"
                        ? controller.selectedCategory?.fTitle
                        : controller.selectedCategory?.pTitle),
            backgroundColor: AppColors.lightGrey,
            // bottomNavigationBar: BottomBarView(isHomeScreen: false),
            body: controller.isLoadingList == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                : Container(
                    height: h,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 70),
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                controller.isLoadAd == false
                                    ? SizedBox()
                                    : Container(
                                        height: Get.height * 0.154,
                                        width: controller.bannerAd?.size.width.toDouble(),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: AdWidget(
                                            ad: controller.bannerAd!,
                                          ),
                                        ),
                                      ),
                                // Container(
                                //   height: h * 0.154,
                                //   margin: EdgeInsets.only(top: 15),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     image: DecorationImage(
                                //       image: AssetImage(AppImages.adBanner),
                                //       fit: BoxFit.cover,
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  margin: EdgeInsets.only(top: 23, bottom: 15),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: h * 0.119,
                                        width: w * 0.305,
                                        decoration: BoxDecoration(
                                          color: Color(controller.selectedCategory?.background == null
                                              ? 0xffFFFFFF
                                              : int.parse("0xff${controller.selectedCategory?.background?.replaceFirst("#", "")}")),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            height: h * 0.067,
                                            width: w * 0.146,
                                            imageUrl: "${ApiConsts.hostUrl}${controller.selectedCategory?.photo}",
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
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${SettingsController.appLanguge == "English" ? controller.selectedCategory?.eTitle ?? "" : SettingsController.appLanguge == "فارسی" ? controller.selectedCategory?.fTitle ?? "" : controller.selectedCategory?.pTitle ?? ""}",
                                              style: AppTextStyle.boldPrimary11,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              controller.selectedCategory?.detail ?? "",
                                              style: AppTextStyle.mediumPrimary8.copyWith(height: 1.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ...List.generate(
                                  controller.diaseaList.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      controller.selectedDieases = controller.diaseaList[index];
                                      Get.toNamed(
                                        Routes.DISEASE_SUB_DETAILS,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      margin: EdgeInsets.only(bottom: 7),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 34,
                                            width: 34,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.grey.withOpacity(0.1),
                                                image: DecorationImage(
                                                    image: NetworkImage("${ApiConsts.hostUrl}${controller.diaseaList[index].img}"))),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: Get.width * 0.65,
                                            child: Text(
                                              SettingsController.appLanguge == "English"
                                                  ? controller.diaseaList[index].title.toString() ?? ""
                                                  : SettingsController.appLanguge == "فارسی"
                                                      ? controller.diaseaList[index].dariTitle.toString()
                                                      : controller.diaseaList[index].pashtoTitle.toString(),
                                              style: AppTextStyle.boldPrimary11,
                                            ),
                                          ),
                                          Spacer(),
                                          RotatedBox(
                                            quarterTurns: SettingsController.appLanguge == "English" ? 2 : 0,
                                            child: SvgPicture.asset(
                                              AppImages.back,
                                              height: 13,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
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
                  ));
      },
    );
  }
}
