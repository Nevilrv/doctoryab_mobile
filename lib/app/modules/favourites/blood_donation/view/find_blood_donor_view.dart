import 'dart:developer';

import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/find_blood_donor_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: h * 0.89,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "requested_blood_group".tr,
                                  style: AppTextStyle.boldGrey12.copyWith(
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
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(0.4),
                                      width: 2),
                                  color: AppColors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 7, bottom: 7, left: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        underline: SizedBox(),
                                        value: controller.selectedGroup.value ??
                                            "",
                                        icon: Icon(Icons.expand_more,
                                            color: AppColors.primary
                                                .withOpacity(0.4)),
                                        isDense: true,
                                        isExpanded: true,
                                        items: controller.selectGroup
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5))),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.selectedGroup.value =
                                              value;
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
                                  "requested_blood_group".tr,
                                  style: AppTextStyle.boldGrey12.copyWith(
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
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(0.4),
                                      width: 2),
                                  color: AppColors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 7, bottom: 7, left: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        underline: SizedBox(),
                                        value:
                                            controller.selectedUnit.value ?? "",
                                        icon: Icon(Icons.expand_more,
                                            color: AppColors.primary
                                                .withOpacity(0.4)),
                                        isDense: true,
                                        isExpanded: true,
                                        items: controller.bloodUnits
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5))),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.selectedUnit.value = value;
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
                                  style: AppTextStyle.boldGrey12.copyWith(
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
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(0.4),
                                      width: 2),
                                  color: AppColors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 7, bottom: 7, left: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        underline: SizedBox(),
                                        value: controller
                                                .selectedAboutCondition.value ??
                                            "",
                                        icon: Icon(Icons.expand_more,
                                            color: AppColors.primary
                                                .withOpacity(0.4)),
                                        isDense: true,
                                        isExpanded: true,
                                        items: controller.aboutConditionList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5))),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.selectedAboutCondition
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
                                  "its_is_critical".tr,
                                  style: AppTextStyle.boldGrey12.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primary),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                    child: _buildCriticalItem("yes".tr, 0)),
                                SizedBox(width: 5),
                                Flexible(child: _buildCriticalItem("no".tr, 1)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: BottomBarView(
                        isHomeScreen: false,
                        isBlueBottomBar: true,
                      ),
                    ),
                  ],
                ),
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
