import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/modules/favourites/treatment_abroad/controllers/treatment_abroad_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TreatmentAbroadView extends GetView<TreatmentAbroadController> {
  TreatmentAbroadView({Key key}) : super(key: key);

  List question = [
    "do_you_need_support".tr,
    "do_you_need_airport".tr,
    "do_you_need_translator".tr,
    "do_you_need_accomization".tr
  ];
  TreatmentAbroadController treatmentAbroadController = Get.find()
    ..getAllCountries();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('treatment_abroad'.tr, style: AppTextStyle.boldPrimary16),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primary,
              )),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                AppImages.blackBell,
                height: 24,
              ),
            )
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: controller.isLoading.value == true
                ? Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.3),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primary,
                    )),
                  )
                : Container(
                    height: h * 0.89,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                            height: h * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'choose_country'.tr,
                                          style: AppTextTheme.b(11).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: w,
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //       offset: Offset(0, 4),
                                              //       blurRadius: 4,
                                              //       color: AppColors.black
                                              //           .withOpacity(0.25))
                                              // ],
                                              border: Border.all(
                                                  color: AppColors.primary
                                                      .withOpacity(0.4),
                                                  width: 2)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    controller.countries.length,
                                                    (index) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15,
                                                                  top: 5),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                      .selectedCountry
                                                                      .value =
                                                                  controller
                                                                      .countries[
                                                                          index]
                                                                      .name;
                                                            },
                                                            child: Container(
                                                              width: 50,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height: 45,
                                                                    width: 45,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: controller.selectedCountry.value == controller.countries[index].name
                                                                              ? AppColors.primary
                                                                              : AppColors.primary.withOpacity(0.4),
                                                                          width: 2),
                                                                    ),
                                                                    child:
                                                                        ClipOval(
                                                                      clipBehavior:
                                                                          Clip.antiAliasWithSaveLayer,
                                                                      child: SvgPicture.network(
                                                                          controller
                                                                              .countries[index]
                                                                              .flag,
                                                                          fit: BoxFit.cover),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Center(
                                                                    child: Text(
                                                                      controller
                                                                              .countries[index]
                                                                              .name ??
                                                                          "",
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: AppTextStyle
                                                                          .mediumPrimary10
                                                                          .copyWith(
                                                                              color: controller.selectedCountry.value == controller.countries[index].name ? AppColors.primary : AppColors.primary.withOpacity(0.4)),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: -7.5,
                                          child: Container(
                                            color: AppColors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Text(
                                                "countries".tr,
                                                style: AppTextTheme.h(11)
                                                    .copyWith(
                                                        color: AppColors
                                                            .lightPurple4,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'details'.tr,
                                          style: AppTextTheme.b(11).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      maxLines: 3,
                                      cursorColor: AppColors.primary,
                                      controller: controller.tellAbout,
                                      style: AppTextTheme.b(12).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                      decoration: InputDecoration(
                                          labelText: "tell_about".tr,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 15),
                                          labelStyle: AppTextTheme.b(12).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary
                                                      .withOpacity(0.4),
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide:
                                                  BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2))),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.attachmentFile.value != ""
                                        ? Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: Get.width * 0.6,
                                                  child: Text(
                                                    "${controller.attachmentFile.value.split("/").last}",
                                                    style: AppTextStyle
                                                        .boldPrimary12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.attachmentFile
                                                        .value = "";
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: AppColors.primary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              controller.pickAttachment();
                                            },
                                            child: Container(
                                              width: w * 0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.primary,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 4,
                                                        color: AppColors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          AppImages.attachment,
                                                          height: 21,
                                                          width: 21),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "add_attachment".tr,
                                                        style: AppTextStyle
                                                            .boldWhite10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'description'.tr,
                                      textAlign: TextAlign.center,
                                      style: AppTextTheme.b(11).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'other_details'.tr,
                                          style: AppTextTheme.b(11).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ...List.generate(question.length, (index) {
                                      return Column(
                                        children: [
                                          Text(
                                            question[index],
                                            style: AppTextStyle.boldPrimary14
                                                .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.8),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (index == 0) {
                                                    if (controller.visaSupport
                                                            .value ==
                                                        "NO") {
                                                      controller.visaSupport
                                                          .value = "YES";
                                                    } else {
                                                      controller.visaSupport
                                                          .value = "YES";
                                                    }
                                                  } else if (index == 1) {
                                                    if (controller
                                                            .airportService
                                                            .value ==
                                                        "NO") {
                                                      controller.airportService
                                                          .value = "YES";
                                                    } else {
                                                      controller.airportService
                                                          .value = "YES";
                                                    }
                                                  } else if (index == 2) {
                                                    if (controller
                                                            .translator.value ==
                                                        "NO") {
                                                      controller.translator
                                                          .value = "YES";
                                                    } else {
                                                      controller.translator
                                                          .value = "YES";
                                                    }
                                                  } else {
                                                    if (controller.accomization
                                                            .value ==
                                                        "NO") {
                                                      controller.accomization
                                                          .value = "YES";
                                                    } else {
                                                      controller.accomization
                                                          .value = "YES";
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: index == 0
                                                          ? controller.visaSupport
                                                                      .value ==
                                                                  "YES"
                                                              ? AppColors.green2
                                                              : AppColors.green2
                                                                  .withOpacity(
                                                                      0.2)
                                                          : index == 1
                                                              ? controller.airportService
                                                                          .value ==
                                                                      "YES"
                                                                  ? AppColors
                                                                      .green2
                                                                  : AppColors
                                                                      .green2
                                                                      .withOpacity(
                                                                          0.2)
                                                              : index == 2
                                                                  ? controller.translator.value ==
                                                                          "YES"
                                                                      ? AppColors
                                                                          .green2
                                                                      : AppColors
                                                                          .green2
                                                                          .withOpacity(
                                                                              0.2)
                                                                  : index == 3
                                                                      ? controller.accomization.value ==
                                                                              "YES"
                                                                          ? AppColors
                                                                              .green2
                                                                          : AppColors.green2.withOpacity(
                                                                              0.2)
                                                                      : AppColors
                                                                          .green2
                                                                          .withOpacity(
                                                                              0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppImages.like,
                                                            color: index == 0
                                                                ? controller.visaSupport
                                                                            .value ==
                                                                        "YES"
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .green2
                                                                : index == 1
                                                                    ? controller.airportService.value ==
                                                                            "YES"
                                                                        ? AppColors
                                                                            .white
                                                                        : AppColors
                                                                            .green2
                                                                    : index == 2
                                                                        ? controller.translator.value ==
                                                                                "YES"
                                                                            ? AppColors
                                                                                .white
                                                                            : AppColors
                                                                                .green2
                                                                        : index ==
                                                                                3
                                                                            ? controller.accomization.value == "YES"
                                                                                ? AppColors.white
                                                                                : AppColors.green2
                                                                            : AppColors.green2),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'yes'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: AppTextStyle
                                                              .boldBlack12
                                                              .copyWith(
                                                            color: index == 0
                                                                ? controller.visaSupport
                                                                            .value ==
                                                                        "YES"
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .green2
                                                                : index == 1
                                                                    ? controller.airportService.value ==
                                                                            "YES"
                                                                        ? AppColors
                                                                            .white
                                                                        : AppColors
                                                                            .green2
                                                                    : index == 2
                                                                        ? controller.translator.value ==
                                                                                "YES"
                                                                            ? AppColors
                                                                                .white
                                                                            : AppColors
                                                                                .green2
                                                                        : index ==
                                                                                3
                                                                            ? controller.accomization.value == "YES"
                                                                                ? AppColors.white
                                                                                : AppColors.green2
                                                                            : AppColors.green2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (index == 0) {
                                                    if (controller.visaSupport
                                                            .value ==
                                                        "YES") {
                                                      controller.visaSupport
                                                          .value = "NO";
                                                    } else {
                                                      controller.visaSupport
                                                          .value = "NO";
                                                    }
                                                  } else if (index == 1) {
                                                    if (controller
                                                            .airportService
                                                            .value ==
                                                        "YES") {
                                                    } else {
                                                      controller.airportService
                                                          .value = "NO";
                                                    }
                                                  } else if (index == 2) {
                                                    if (controller
                                                            .translator.value ==
                                                        "YES") {
                                                      controller.translator
                                                          .value = "NO";
                                                    } else {
                                                      controller.translator
                                                          .value = "NO";
                                                    }
                                                  } else {
                                                    if (controller.accomization
                                                            .value ==
                                                        "YES") {
                                                      controller.accomization
                                                          .value = "NO";
                                                    } else {
                                                      controller.accomization
                                                          .value = "NO";
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: index == 0
                                                          ? controller.visaSupport
                                                                      .value ==
                                                                  "NO"
                                                              ? AppColors.red
                                                              : AppColors.red
                                                                  .withOpacity(
                                                                      0.2)
                                                          : index == 1
                                                              ? controller.airportService
                                                                          .value ==
                                                                      "NO"
                                                                  ? AppColors
                                                                      .red
                                                                  : AppColors
                                                                      .red
                                                                      .withOpacity(
                                                                          0.2)
                                                              : index == 2
                                                                  ? controller.translator
                                                                              .value ==
                                                                          "NO"
                                                                      ? AppColors
                                                                          .red
                                                                      : AppColors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.2)
                                                                  : index == 3
                                                                      ? controller.accomization.value ==
                                                                              "NO"
                                                                          ? AppColors
                                                                              .red
                                                                          : AppColors.red.withOpacity(
                                                                              0.2)
                                                                      : AppColors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppImages.dislike,
                                                          color: index == 0
                                                              ? controller.visaSupport
                                                                          .value ==
                                                                      "NO"
                                                                  ? AppColors
                                                                      .white
                                                                  : AppColors
                                                                      .red
                                                              : index == 1
                                                                  ? controller.airportService
                                                                              .value ==
                                                                          "NO"
                                                                      ? AppColors
                                                                          .white
                                                                      : AppColors
                                                                          .red
                                                                  : index == 2
                                                                      ? controller.translator.value ==
                                                                              "NO"
                                                                          ? AppColors
                                                                              .white
                                                                          : AppColors
                                                                              .red
                                                                      : index ==
                                                                              3
                                                                          ? controller.accomization.value == "NO"
                                                                              ? AppColors.white
                                                                              : AppColors.red
                                                                          : AppColors.red,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'no'.tr.toUpperCase(),
                                                          style: AppTextStyle
                                                              .boldBlack12
                                                              .copyWith(
                                                            color: index == 0
                                                                ? controller.visaSupport
                                                                            .value ==
                                                                        "NO"
                                                                    ? AppColors
                                                                        .white
                                                                    : AppColors
                                                                        .red
                                                                : index == 1
                                                                    ? controller.airportService.value ==
                                                                            "NO"
                                                                        ? AppColors
                                                                            .white
                                                                        : AppColors
                                                                            .red
                                                                    : index == 2
                                                                        ? controller.translator.value ==
                                                                                "NO"
                                                                            ? AppColors
                                                                                .white
                                                                            : AppColors
                                                                                .red
                                                                        : index ==
                                                                                3
                                                                            ? controller.accomization.value == "NO"
                                                                                ? AppColors.white
                                                                                : AppColors.red
                                                                            : AppColors.red,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    }),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                      color: AppColors.red),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 4,
                                                        color: AppColors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "cancel".tr,
                                                        style: AppTextStyle
                                                            .boldWhite14
                                                            .copyWith(
                                                                color: Color(
                                                                    0xFFFF2B1E)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (controller
                                                      .selectedCountry.value ==
                                                  "") {
                                                Utils.commonSnackbar(
                                                    context: context,
                                                    text:
                                                        "please_select_country");
                                              } else if (controller
                                                  .tellAbout.text.isEmpty) {
                                                Utils.commonSnackbar(
                                                    context: context,
                                                    text:
                                                        "please_enter_your_problem");
                                              } else {
                                                controller.abroadApi(context);
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.primary,
                                                  border: Border.all(
                                                      color: AppColors.primary),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 4),
                                                        blurRadius: 4,
                                                        color: AppColors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Center(
                                                  child: controller.apiLoading
                                                              .value ==
                                                          true
                                                      ? CircularProgressIndicator(
                                                          color:
                                                              AppColors.white,
                                                        )
                                                      : Text(
                                                          "submit".tr,
                                                          style: AppTextStyle
                                                              .boldWhite14,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          child: BottomBarView(
                            isHomeScreen: false,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
