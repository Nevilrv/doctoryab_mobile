import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/controller/drugs_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrugDetailsView extends GetView<DrugsController> {
  DrugDetailsView({Key key}) : super(key: key) {
    print('==controller.argumentsData==>${Get.arguments}');
    controller.setData(Get.arguments);
    log("controller.argumentsData.id--------------> ${controller.argumentsData.id}");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.drugReview(drugId: controller.argumentsData.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(
        title: SettingsController.appLanguge == 'English'
            ? controller.argumentsData.englishDrugName
            : controller.argumentsData.localLanguageDrugName,
      ),
      backgroundColor: AppColors.lightGrey,
      body: GetBuilder<DrugsController>(
        builder: (controller) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: h * 0.149,
                          // width: double.infinity,
                          // margin: EdgeInsets.only(top: 14),
                          // decoration: BoxDecoration(
                          //   color: AppColors.lightYellow,
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                // color: AppColors.red,
                                child: Center(
                                  child: CachedNetworkImage(
                                    height: 250,
                                    width: 250,
                                    imageUrl:
                                        "${ApiConsts.hostUrl}${controller.argumentsData.img}",
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) {
                                      return Image.asset(
                                        AppImages.vitamin,
                                      );
                                    },
                                    errorWidget: (_, __, ___) {
                                      return Image.asset(
                                        AppImages.vitamin,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Center(child: Image.asset(AppImages.vitamins)),
                              Positioned(
                                bottom: -8,
                                child: IntrinsicWidth(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.white,
                                    ),
                                    child: Row(
                                      children: List.generate(
                                        5,
                                        (subIndex) {
                                          return SvgPicture.asset(
                                            subIndex == 4
                                                ? AppImages.favGrey
                                                : AppImages.favGolden,
                                            height: 9,
                                            width: 9,
                                          ).paddingOnly(
                                              right: subIndex == 4 ? 0 : 3);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              3,
                              (index) => Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h * 0.04,
                                    width: h * 0.04,
                                    padding: EdgeInsets.all(3),
                                    // margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightPurple,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image.asset(
                                      controller.data[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.data[index]["title"]
                                            .toString()
                                            .tr,
                                        style: AppTextStyle.boldPrimary9
                                            .copyWith(height: 1.2),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.003,
                                      ),
                                      Container(
                                        width: w * 0.17,
                                        child: Text(
                                          index == 1
                                              ? controller
                                                  .argumentsData.packsAndPrices
                                              : index == 2
                                                  ? controller.data[2]["text"]
                                                      .toString()
                                                      .trArgs([
                                                      controller.argumentsData
                                                          .packsAndPrices
                                                    ])
                                                  : SettingsController
                                                              .appLanguge ==
                                                          'English'
                                                      ? controller.argumentsData
                                                              .drugTypeEnglish ??
                                                          "None"
                                                      : SettingsController
                                                                  .appLanguge ==
                                                              'پشتو'
                                                          ? controller
                                                                  .argumentsData
                                                                  .drugTypePashto ??
                                                              "None"
                                                          : controller
                                                                  .argumentsData
                                                                  .drugTypeDari ??
                                                              "None",
                                          style: AppTextStyle.regularPrimary9
                                              .copyWith(height: 1),
                                          maxLines: 4,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.01,
                        ),
                        commonTitleBox(text: "drug_name".tr),
                        commonTextBox(SettingsController.appLanguge == 'English'
                            ? controller.argumentsData.englishDrugName ?? ''
                            : controller.argumentsData.localLanguageDrugName ??
                                ''
                                    "${controller.argumentsData.englishDrugName}"),
                        controller.argumentsData.genericName == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(text: "gen_name".tr),
                                  commonTextBox(
                                      "${controller.argumentsData.genericName}"),
                                ],
                              ),

                        controller.argumentsData.usageEnglish == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(
                                    text: "usage".tr,
                                    color: AppColors.boxGreen3,
                                    textColor: Colors.green,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      SettingsController.appLanguge == 'English'
                                          ? controller
                                                  .argumentsData.usageEnglish ??
                                              ''
                                          : SettingsController.appLanguge ==
                                                  'پشتو'
                                              ? controller.argumentsData
                                                      .usagePashto ??
                                                  ''
                                              : controller.argumentsData
                                                      .usageDari ??
                                                  '',
                                      style: AppTextStyle.mediumPrimary10
                                          .copyWith(height: 2),
                                    ),
                                  ),
                                ],
                              ),

                        controller.argumentsData.sideEffectsEnglish == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(
                                    text: "side_effects".tr,
                                    color: AppColors.lightYellow,
                                    textColor: Colors.yellow.shade700,
                                  ),
                                  commonTextBox(
                                    SettingsController.appLanguge == 'English'
                                        ? controller.argumentsData
                                                .sideEffectsEnglish ??
                                            ''
                                        : SettingsController.appLanguge ==
                                                'پشتو'
                                            ? controller.argumentsData
                                                    .sideEffectsPashto ??
                                                ''
                                            : controller.argumentsData
                                                    .sideEffectsDari ??
                                                '',
                                  ),
                                ],
                              ),

                        controller.argumentsData.warningsEnglish == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(
                                    text: "warnings".tr,
                                    color: AppColors.boxRed,
                                    textColor: Colors.red,
                                  ),
                                  commonTextBox(
                                    SettingsController.appLanguge == 'English'
                                        ? controller.argumentsData
                                                .warningsEnglish ??
                                            ''
                                        : SettingsController.appLanguge ==
                                                'پشتو'
                                            ? controller.argumentsData
                                                    .warningsPashto ??
                                                ''
                                            : controller.argumentsData
                                                    .warningsDari ??
                                                '',
                                  ),
                                ],
                              ),
                        // commonTitleBox(text: "drug_type".tr),
                        // commonTextBox("Lorem Ipsum is simply dummy text."),

                        // commonTitleBox(text: "packaging".tr),
                        // commonTextBox("Lorem Ipsum is simply dummy text."),
                        controller.argumentsData.dosagesEnglish == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(text: "dosages".tr),
                                  commonTextBox(
                                    SettingsController.appLanguge == 'English'
                                        ? controller
                                                .argumentsData.dosagesEnglish ??
                                            ''
                                        : SettingsController.appLanguge ==
                                                'پشتو'
                                            ? controller.argumentsData
                                                    .dosagesPashto ??
                                                ''
                                            : controller.argumentsData
                                                    .dosagesDari ??
                                                '',
                                  ),
                                ],
                              ),

                        controller.argumentsData.origin == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(text: "origin".tr),
                                  commonTextBox(
                                      "${controller.argumentsData.origin}"),
                                ],
                              ),

                        controller.argumentsData.company == ""
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTitleBox(text: "comp".tr),
                                  commonTextBox(
                                      "${controller.argumentsData.company}")
                                ],
                              ),

                        SizedBox(height: 10),
                        // commonTitleBox(
                        //   text: "price".tr,
                        //   color: AppColors.lightYellow,
                        //   textColor: Colors.yellow.shade700,
                        // ),
                        // commonTextBox("drug_price".trArgs(["1000"])),
                        commonTitleBox(text: "comm_ratings".tr),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: 265,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        children: [
                                          Text(
                                            "give_feedback".tr,
                                            style:
                                                AppTextStyle.regularPrimary16,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.lightPurple,
                                            ),
                                            child: RatingBar.builder(
                                              itemSize: 30,
                                              initialRating: controller.ratings,
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
                                                controller.ratings = rating;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: addCommentsTextField(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (controller
                                                  .comment.text.isEmpty) {
                                                Utils.commonSnackbar(
                                                    context: context,
                                                    text:
                                                        "please_add_review".tr);
                                              } else {
                                                controller.addDrugFeedback(
                                                  rating: controller.ratings
                                                      .toString(),
                                                  drugId: controller
                                                      .argumentsData.id,
                                                );
                                              }
                                              Get.back();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 23, vertical: 10),
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 20, right: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: AppColors.primary,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "send".tr,
                                                  style:
                                                      AppTextStyle.boldWhite8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 23, vertical: 8),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                "give_feedback".tr,
                                style: AppTextStyle.boldWhite8,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        controller.isLoading == true
                            ? Center(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: List.generate(
                                  controller.drugFeedback.length,
                                  (index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 8,
                                        right: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: AppColors.lightPurple),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // CachedNetworkImage(
                                          //   imageUrl: "${ApiConsts.hostUrl}${  controller
                                          //       .drugFeedback[index].photo}",
                                          //   height: h * 0.045,
                                          //   width: h * 0.045,
                                          //   fit: BoxFit.cover,
                                          //   placeholder: (_, __) {
                                          //     return Image.asset(
                                          //       "assets/png/person-placeholder.jpg",
                                          //       fit: BoxFit.cover,
                                          //     );
                                          //   },
                                          //   errorWidget: (_, __, ___) {
                                          //     return Image.asset(
                                          //       "assets/png/person-placeholder.jpg",
                                          //       fit: BoxFit.cover,
                                          //     );
                                          //   },
                                          // )

                                          Container(
                                            height: h * 0.045,
                                            width: h * 0.045,
                                            margin: EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${ApiConsts.hostUrl}${controller.drugFeedback[index].photo}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                              .drugFeedback[
                                                                  index]
                                                              .whoPosted ??
                                                          "",
                                                      style: AppTextStyle
                                                          .regularPrimary9,
                                                    ),
                                                    Spacer(),
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      itemSize: 15,
                                                      initialRating: double
                                                          .parse(controller
                                                                      .drugFeedback[
                                                                          index]
                                                                      .rating ==
                                                                  null
                                                              ? "0"
                                                              : controller
                                                                      .drugFeedback[
                                                                          index]
                                                                      .rating ??
                                                                  "0.0"),
                                                      // minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        // size: 10,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  controller.drugFeedback[index]
                                                          .comment ??
                                                      '',
                                                  style: AppTextStyle
                                                      .regularPrimary7
                                                      .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.6),
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BottomBarView(isHomeScreen: false),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget commonTitleBox({
    String text,
    Color color = AppColors.lightPurple,
    Color textColor = AppColors.primary,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.regularPrimary10.copyWith(color: textColor),
      ),
    );
  }

  Widget commonTextBox(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: CircleAvatar(
              radius: 1.2,
              backgroundColor: AppColors.primary,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.boldPrimary10.copyWith(height: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget addCommentsTextField() {
    return TextField(
      style: AppTextStyle.mediumPrimary10,
      cursorColor: AppColors.primary,
      maxLines: 4,
      controller: controller.comment,
      decoration: InputDecoration(
        hintText: "add_comm".tr,
        hintStyle: AppTextStyle.mediumLightPurple3_10,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
      ),
    );
  }
}
