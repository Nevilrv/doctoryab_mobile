import 'dart:developer';

import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/blood_donor_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';

class BloodDonorView extends GetView<BloodDonorController> {
  BloodDonorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Background(
      isPrimary: true,
      isSecond: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.whiteAppBar(title: "blood_donor".tr, bloodIcon: true),
        // bottomNavigationBar:
        //     BottomBarView(isHomeScreen: false, isBlueBackground: true),
        body: Container(
          height: h,
          child: Stack(
            children: [
              IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 25)
                                    .copyWith(bottom: 0),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.darkBlue.withOpacity(0.5),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      color: AppColors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: _buildRows(controller.selectGroup),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: -4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: Colors.white,
                                  child: Text(
                                    'select_blood_group'.tr,
                                    style: AppTextStyle.boldBlack13.copyWith(
                                      color: AppColors.lightPurple4,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).paddingHorizontal(25),
                          Text(
                            "location".tr,
                            style: AppTextStyle.regularBlack11
                                .copyWith(color: AppColors.lightPurple4),
                          ).paddingOnly(top: 15, left: 40,right: 40),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.LOCATION_PICKER,
                                    preventDuplicates: true,
                                    arguments: controller.locationResult())
                                .then((v) {
                              if (v != null && v is LocationResult) {
                                controller.locationResult.value = v;
                                var x = v;
                                log(x.locality);
                              }
                            }),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.darkBlue.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFFBEC2DD),
                                    size: 15,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.locationResult()?.locality ??
                                          'select_location'.tr,
                                      style:
                                          AppTextStyle.mediumBlack12.copyWith(
                                        color:
                                            AppColors.darkBlue.withOpacity(0.5),
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).paddingHorizontal(25),
                          Text(
                            "gender".tr,
                            style: AppTextStyle.regularBlack11
                                .copyWith(color: AppColors.lightPurple4),
                          ).paddingOnly(top: 15, left: 40,right: 40),
                          _buildGenderRow().paddingHorizontal(25),
                          _buildCheckbox(),
                          SizedBox(height: 40),
                          _buildSaveButton(context),
                          SizedBox(height: 10),
                          _buildCancelButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
        ),
      ),
    );
  }

  // Widget _tmp() {
  //   return CustomScrollView(
  //     physics: BouncingScrollPhysics(),
  //     slivers: [
  //       _buildTitle("select_blood_group".tr),
  //       SliverList(
  //         delegate: SliverChildListDelegate(
  //           _buildRows(controller.selectGroup),
  //         ),
  //       ),
  //       _buildTitle("location".tr),
  //       _buildChangeLocationButton(),
  //       _buildTitle("gender".tr),
  //       SizedBox(height: 10),
  //       _buildGenderRow(),
  //       _buildCheckbox(),
  //       _buildSaveButton(),
  //
  //     ],
  //   );
  // }

  // Widget _buildTitle(String text) {
  //   return Text(
  //     text,
  //     style: AppTextTheme.m(16).copyWith(color: AppColors.disabledButtonColor),
  //   ).paddingHorizontal(30).paddingOnly(top: 16, bottom: 8).sliverBox;
  // }

  // Widget _buildChangeLocationButton() {
  //   return SliverToBoxAdapter(
  //     child: OutlinedButton.icon(
  //       style: ButtonStyle(
  //         padding: MaterialStateProperty.all(
  //             const EdgeInsets.symmetric(vertical: 9, horizontal: 8)),
  //       ),
  //       onPressed: () => Get.toNamed(Routes.LOCATION_PICKER,
  //               preventDuplicates: true, arguments: controller.locationResult())
  //           .then((v) {
  //         if (v != null && v is LocationResult) {
  //           controller.locationResult.value = v;
  //           var x = v;
  //           log(x.locality);
  //         }
  //       }),
  //       icon: Icon(
  //         Icons.location_pin,
  //         color: AppColors.primary,
  //       ),
  //       label: Obx(() => Text(
  //             controller.locationResult()?.locality ?? 'select_location'.tr,
  //             style: TextStyle(color: AppColors.primary),
  //           )),
  //     ).paddingOnly(top: 10).paddingHorizontal(22),
  //   );
  // }

  Widget _buildGenderRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(child: _buildGenderItem("male".tr, 0)),
        SizedBox(width: 5),
        Flexible(child: _buildGenderItem("female".tr, 1)),
      ],
    );
  }

  Widget _buildCheckbox() {
    return Transform.scale(
      scale: 0.91,
      child: Obx(
        () => CheckboxListTile(
          title: Text(
            'i_am_over_18y_and_50kg'.tr,
            style: AppTextTheme.m(12).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: BorderSide(
            color: AppColors.darkBlue.withOpacity(0.5),
            width: 2,
          ),
          value: controller.iAmOver18(),
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          activeColor: AppColors.darkBlue.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          onChanged: (newValue) {
            controller.iAmOver18.value = newValue;
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: GestureDetector(
        onTap: () {
          if (controller.locationResult()?.locality == null) {
            Utils.commonSnackbar(context: context, text: "please_select_loc");
          } else if (!controller.iAmOver18.value) {
            Utils.commonSnackbar(context: context, text: "please_check");
          } else {
            controller.save();
          }
          // controller.iAmOver18.value &&
          //     controller.locationResult()?.locality != null
          //     ? () => controller.save()
          //     : null
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primary,
              border: Border.all(color: AppColors.primary),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black.withOpacity(0.25))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "reg".tr,
                style: AppTextStyle.boldWhite14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: () => Get.back(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Color(0xFFFF2B1E),
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "cancel".tr,
            style: AppTextStyle.boldWhite14.copyWith(color: Color(0xFFFF2B1E)),
          ),
        ),
      ),
    ).paddingHorizontal(40);
  }

  List<Widget> _buildRows(List<String> items) {
    List<Widget> rows = [];
    int itemCount = items.length;
    int rowCount = (itemCount / 4).ceil();
    for (int i = 0; i < rowCount; i++) {
      int startIndex = i * 4;
      int endIndex = startIndex + 4;
      if (endIndex > itemCount) {
        endIndex = itemCount;
      }

      List<String> rowItems = items.sublist(startIndex, endIndex);
      List<Widget> rowChildren = [];

      for (int j = 0; j < rowItems.length; j++) {
        // iterate with index
        String label = rowItems[j];
        int index = items.indexOf(label); // get the index of the item
        rowChildren.add(_buildItem(label, index));
      }

      rows.add(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        ),
      );
    }
    return rows;
  }

  Widget _buildItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        print(index); // print the index when tapped
        controller.changeSelectedBloodDonorGroupItem(index);
      },
      child: Obx(() => Container(
            decoration: BoxDecoration(
              color: controller.isThisTheSelectedOne(index)
                  ? AppColors.primary
                  : Colors.white,
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            width: 50,
            height: 50,
            margin: EdgeInsets.only(bottom: 18),
            child: Center(
              child: Text(
                label.length <= 3 ? label : label.substring(0, 3),
                textAlign: TextAlign.center,
                style: AppTextTheme.b(20).copyWith(
                    height: 0,
                    color: !controller.isThisTheSelectedOne(index)
                        ? AppColors.primary
                        : Colors.white),
              ),
            ),
          )),
    );
  }

  Widget _buildGenderItem(String text, int value) {
    return Obx(
      () {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: controller.selectedGender() == value
                ? AppColors.darkBlue.withOpacity(0.5)
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
              text,
              textAlign: TextAlign.center,
              style: AppTextTheme.b(12).copyWith(
                height: 0,
                color: controller.selectedGender() != value
                    ? AppColors.darkBlue.withOpacity(0.5)
                    : Colors.white,
              ),
            ),
          ),
        ).onTap(
          () {
            controller.selectedGender(value);
          },
        );
      },
    );
  }
}
