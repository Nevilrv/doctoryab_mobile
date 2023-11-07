import 'dart:developer';

import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/find_blood_donor_controller.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/view/donor_list_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/AppTheme.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';

class FindBloodDonorView extends GetView<FindBloodDonorController> {
  const FindBloodDonorView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isPrimary: true,
      isSecond: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.whiteAppBar(
            title: "find_blood_donor".tr, bloodIcon: true),
        // appBar: AppAppBar.specialAppBar(
        //   "find_blood_donor".tr,
        //   showLeading: false,
        // ),
        // bottomNavigationBar: BottomBarView(isHomeScreen: false),
        body: Obx(() {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: h * 0.89,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          height: h * 0.71,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "requested_blood_group".tr,
                                          style: AppTextStyle.boldGrey12
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: w,
                                      // height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(0.4),
                                              width: 2),
                                          color: AppColors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                            left: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButton<String>(
                                                underline: SizedBox(),
                                                value: controller
                                                        .selectedGroup.value ??
                                                    "",
                                                icon: Icon(Icons.expand_more,
                                                    color: AppColors.primary
                                                        .withOpacity(0.4)),
                                                isDense: true,
                                                isExpanded: true,
                                                items: controller.selectGroup
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value,
                                                        style: AppTextStyle
                                                            .mediumPrimary12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5))),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  controller.selectedGroup
                                                      .value = value;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "blood_units_required".tr,
                                          style: AppTextStyle.boldGrey12
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: w,
                                      // height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(0.4),
                                              width: 2),
                                          color: AppColors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                            left: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButton<String>(
                                                underline: SizedBox(),
                                                value: controller
                                                        .selectedUnit.value ??
                                                    "",
                                                icon: Icon(Icons.expand_more,
                                                    color: AppColors.primary
                                                        .withOpacity(0.4)),
                                                isDense: true,
                                                isExpanded: true,
                                                items: controller.bloodUnits
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value,
                                                        style: AppTextStyle
                                                            .mediumPrimary12
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.5))),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  controller.selectedUnit
                                                      .value = value;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "about_condition".tr,
                                          style: AppTextStyle.boldGrey12
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      cursorColor: AppColors.primary,
                                      style: AppTextTheme.b(12).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                      controller: controller.condition,
                                      decoration: InputDecoration(
                                          labelText: "enter_your_condition".tr,

                                          // floatingLabelBehavior:
                                          //     FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          labelStyle: AppTextTheme.b(12)
                                              .copyWith(
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
                                              borderSide: BorderSide(
                                                  color: AppColors.primary
                                                      .withOpacity(0.4),
                                                  width: 2))),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "its_is_critical?".tr,
                                          style: AppTextStyle.boldGrey12
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                            child: _buildCriticalItem(
                                                "yes".tr, 0)),
                                        SizedBox(width: 5),
                                        Flexible(
                                            child:
                                                _buildCriticalItem("no".tr, 1)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      cursorColor: AppColors.primary,
                                      validator: Utils.nameValidator,
                                      style: AppTextTheme.b(12).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                      controller: controller.fullname,
                                      decoration: InputDecoration(
                                          labelText: "your_full_name".tr,
                                          // floatingLabelBehavior:
                                          //     FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          labelStyle: AppTextTheme.b(12)
                                              .copyWith(
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
                                              borderSide: BorderSide(
                                                  color: AppColors.primary
                                                      .withOpacity(0.4),
                                                  width: 2))),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      cursorColor: AppColors.primary,
                                      style: AppTextTheme.b(12).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                      controller: controller.phoneNumber,
                                      validator: Utils.numberValidator,
                                      decoration: InputDecoration(
                                          labelText: "mobile_number".tr,
                                          // floatingLabelBehavior:
                                          //     FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          labelStyle: AppTextTheme.b(12)
                                              .copyWith(
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
                                              borderSide: BorderSide(
                                                  color: AppColors.primary
                                                      .withOpacity(0.4),
                                                  width: 2))),
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
                                          'choose_one'.tr,
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
                                    Row(
                                      children: [
                                        Text(
                                          "near_by_hospital".tr,
                                          style: AppTextStyle.boldGrey12
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.nearByHospitalList.isEmpty
                                        ? SizedBox()
                                        : Container(
                                            width: w,
                                            // height: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: AppColors.primary
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                color: AppColors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5,
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: DropdownButton(
                                                      underline: SizedBox(),
                                                      // value: controller
                                                      //         .selectedNearByHospital
                                                      //         .value ??
                                                      //     "",
                                                      hint: Text(
                                                          controller.selectedNearByHospital
                                                                      .value ==
                                                                  ""
                                                              ? "Please select hospital"
                                                                  .tr
                                                              : controller
                                                                  .selectedNearByHospital
                                                                  .value,
                                                          style: AppTextStyle
                                                              .mediumPrimary12
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5))),
                                                      icon: Icon(
                                                          Icons.expand_more,
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(
                                                                  0.4)),
                                                      isDense: true,
                                                      isExpanded: true,
                                                      items: controller
                                                          .nearByHospitalList
                                                          .map(
                                                              (Hospital value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value.name,
                                                          child: Text(
                                                              value.name,
                                                              style: AppTextStyle
                                                                  .mediumPrimary12
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5))),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .selectedNearByHospital
                                                            .value = value;
                                                        controller
                                                            .nearByHospitalList
                                                            .forEach((element) {
                                                          if (element.name ==
                                                              value) {
                                                            controller
                                                                    .selectedNearByHospitalData =
                                                                element;
                                                            log("selectedNearByHospitalData--------------> ${controller.selectedNearByHospitalData}");
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    controller.nearByHospitalList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 3,
                                          ),
                                    controller.nearByHospitalList.isEmpty
                                        ? SizedBox()
                                        : Text(
                                            'or'.tr,
                                            style: AppTextTheme.b(14).copyWith(
                                                color: AppColors.primary
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.bold),
                                          ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.LOCATION_PICKER,
                                                    preventDuplicates: true,
                                                    arguments: controller
                                                        .locationResult())
                                                .then((v) {
                                              if (v != null &&
                                                  v is LocationResult) {
                                                log("v--------------> ${v}");

                                                controller
                                                    .locationResult.value = v;
                                                var x = v;
                                                log(x.locality);
                                              }
                                            });
                                          },
                                          child: Container(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      controller
                                                              .locationResult()
                                                              ?.name ??
                                                          'select_location'.tr,
                                                      // "current_location".tr,
                                                      style: AppTextStyle
                                                          .mediumPrimary12
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: AppColors.primary
                                                        .withOpacity(0.4),
                                                    size: 25,
                                                  )
                                                ],
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
                                                "location".tr,
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
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.formKey.currentState
                                            .validate()) {
                                          log("controller.locationResult()--------------> ${controller.locationResult().name}");
                                          if (controller
                                                      .selectedNearByHospitalData ==
                                                  null &&
                                              controller.locationResult() ==
                                                  null) {
                                            Utils.commonSnackbar(
                                                text: "Please select location",
                                                context: context);
                                          } else {
                                            Get.focusScope.unfocus();
                                            controller.search();
                                          }
                                        } else {}

                                        // Get.toNamed(Routes.DONOR_LIST);
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "find_blood_donor".tr,
                                                  style:
                                                      AppTextStyle.boldWhite14,
                                                ),
                                                Image.asset(AppImages.blood1)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                            width: w * 0.6,
                            child: Divider(
                              color: AppColors.white.withOpacity(0.5),
                              thickness: 1,
                              height: 3,
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: BottomBarView(
                      isHomeScreen: false,
                      isBlueBackground: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        // body: Theme
        // (
        //   data: AppTheme.newTheme().copyWith(
        //     primaryColor: AppColors.lgt2,
        //     // accentColor: Colors.red,
        //     hintColor: AppColors.lgt2,
        //     // inputDecorationTheme:  Get.theme.inputDecorationTheme.copyWith(
        //
        //     // )
        //   ),
        //   child: Form(
        //     key: controller.formKey,
        //     child: CustomScrollView(
        //       slivers: [
        //         _buildDropdownWithTitle(
        //           "requested_blood_group".tr,
        //           () {
        //             AppGetDialog.showSelectDialog(
        //                 "blood_group".tr, controller.selectGroup, (selected) {
        //               controller.selectedBloodGroupIndex.value = selected;
        //             });
        //           },
        //           controller.selectedBloodGroupIndex,
        //           controller.selectGroup,
        //           dropdownValuePrefix: "${'blood_group'.tr}: ",
        //         ),
        //         SizedBox(height: 20).sliverBox,
        //
        //         //*
        //         _buildDropdownWithTitle(
        //           "blood_units_required".tr,
        //           () {
        //             AppGetDialog.showSelectDialog(
        //                 "blood_group".tr, controller.bloodUnits, (selected) {
        //               controller.selectedBloodUnitsIndex.value = selected;
        //             });
        //           },
        //           controller.selectedBloodUnitsIndex,
        //           controller.bloodUnits,
        //           dropdownValueSuffix: " ${'units'.tr} ",
        //         ),
        //         SizedBox(height: 20).sliverBox,
        //
        //         //*
        //         Container(
        //           child: Material(
        //             // color: Colors.transparent,
        //             child: TextFormField(
        //               onChanged: (_) => controller.validateForm(),
        //
        //               validator: Utils.nameValidator,
        //               style: TextStyle(color: AppColors.primary),
        //               // maxLength: 6,
        //               // maxLengthEnforcement: MaxLengthEnforcement.enforced,
        //               keyboardType: TextInputType.name,
        //               controller: controller.teName,
        //               decoration: InputDecoration(
        //                 labelText: 'full_name'.tr,
        //                 // labelStyle: TextStyle(color: Colors.white),
        //                 // fillColor: Colors.white,
        //                 // focusColor: Colors.white,
        //               ),
        //               // onChanged: (s) =>
        //               //     controller.onAgeChange(s),
        //             ),
        //           ),
        //         ).sliverBox,
        //         SizedBox(height: 20).sliverBox,
        //         //*
        //         //*
        //         Container(
        //           child: Material(
        //             child: TextFormField(
        //               onChanged: (_) => controller.validateForm(),
        //
        //               validator: Utils.numberValidator,
        //               style: TextStyle(color: AppColors.primary),
        //               // maxLength: 6,
        //               // maxLengthEnforcement: MaxLengthEnforcement.enforced,
        //               keyboardType: TextInputType.phone,
        //               controller: controller.teNewNumber,
        //               decoration: InputDecoration(
        //                 labelText: 'phone_number'.tr,
        //                 // labelStyle: TextStyle(color: Colors.white),
        //                 // fillColor: Colors.white,
        //                 // focusColor: Colors.white,
        //               ),
        //               // onChanged: (s) =>
        //               //     controller.onAgeChange(s),
        //             ),
        //           ),
        //         ).sliverBox,
        //         SizedBox(height: 20).sliverBox,
        //         //*
        //
        //         _buildChangeLocationButton(),
        //         SizedBox(height: 30).sliverBox,
        //         //*
        //         CustomRoundedButton(
        //             radius: 4,
        //             disabledColor: AppColors.primary.withOpacity(.2),
        //             color: AppColors.primary,
        //             textDisabledColor: Colors.white,
        //             textColor: Colors.white,
        //             splashColor: AppColors.primary.withAlpha(0),
        //             text: "search".tr,
        //             // width: 200,
        //             onTap: () {
        //               if (controller.formKey.currentState.validate()) {
        //                 Get.focusScope.unfocus();
        //                 controller.search();
        //               } else {}
        //             }
        //             //  () {
        //             //   AuthController.to
        //             //       .signOut()
        //             //       .then((value) => Utils.whereShouldIGo());
        //             // },
        //             ).sliverBox,
        //       ],
        //     ).paddingAll(16).paddingOnly(top: 16),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildCriticalItem(String text, int value) {
    return Obx(
      () {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: controller.selectedCritical() == value
                ? AppColors.darkBlue.withOpacity(0.3)
                : Colors.white,
            border: Border.all(
                color: AppColors.darkBlue.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextTheme.b(12).copyWith(
                height: 0,
                color: controller.selectedCritical() != value
                    ? AppColors.darkBlue.withOpacity(0.5)
                    : Colors.white,
              ),
            ),
          ),
        ).onTap(
          () {
            controller.selectedCritical(value);
          },
        );
      },
    );
  }

  Widget _buildDropdownWithTitle(String title, VoidCallback onTap,
      RxInt selectedDropdownItem, List<dynamic> dropDownList,
      {String dropdownValuePrefix, String dropdownValueSuffix}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style:
              AppTextTheme.r(16).copyWith(height: 0, color: AppColors.primary),
        ),
        SizedBox(height: 10),
        Container(
          child: Obx(
            () => _buildGenderItem(
              "${dropDownList[selectedDropdownItem()]}",
              onTap,
              dropdownValuePrefix: dropdownValuePrefix,
              dropdownValueSuffix: dropdownValueSuffix,
            ),
          ),
        ),
      ],
    ).sliverBox;
  }

  Widget _buildGenderItem(String text, VoidCallback onTap,
      {String dropdownValuePrefix, String dropdownValueSuffix}) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   border: Border.all(
      //     color: AppColors.primary,
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(4),
      // ),
      height: 50,
      child: Material(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () => onTap(),
          // splashColor: Colors.red,
          // highlightColor: Colors.red,
          child: Row(
            children: [
              SizedBox(width: 16),
              if (dropdownValuePrefix != null)
                Text(
                  dropdownValuePrefix,
                  // textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.b(16).copyWith(
                    height: 0,
                    color: AppColors.primary,
                  ),
                ),
              Text(
                text,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: AppTextTheme.b(16).copyWith(
                  height: 0,
                  color: AppColors.primary,
                ),
              ),
              if (dropdownValueSuffix != null)
                Text(
                  dropdownValueSuffix,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.b(16).copyWith(
                    height: 0,
                    color: AppColors.primary,
                  ),
                ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeLocationButton() {
    return SliverToBoxAdapter(
      child: OutlinedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 9, horizontal: 8)),
        ),
        onPressed: () => Get.toNamed(Routes.LOCATION_PICKER,
                preventDuplicates: true, arguments: controller.locationResult())
            .then((v) {
          if (v != null && v is LocationResult) {
            controller.locationResult.value = v;
            var x = v;
            log(x.locality);
          }
        }),
        icon: Icon(
          Icons.location_pin,
          color: AppColors.primary,
        ),
        label: Obx(() => Text(
              controller.locationResult()?.locality ?? 'select_location'.tr,
              style: TextStyle(color: AppColors.primary),
            )),
      ).paddingOnly(top: 10).paddingHorizontal(22),
    );
  }
}
