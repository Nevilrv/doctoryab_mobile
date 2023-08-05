import 'dart:developer';

import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';

import '../../../components/spacialAppBar.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/AppTheme.dart';
import '../../../theme/TextTheme.dart';
import '../../../utils/utils.dart';
import '../controllers/find_blood_donor_controller.dart';

class FindBloodDonorView extends GetView<FindBloodDonorController> {
  const FindBloodDonorView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        "find_blood_donor".tr,
        showLeading: false,
      ),
      body: Theme(
        data: AppTheme.newTheme().copyWith(
          primaryColor: AppColors.lgt2,
          // accentColor: Colors.red,
          hintColor: AppColors.lgt2,
          // inputDecorationTheme:  Get.theme.inputDecorationTheme.copyWith(

          // )
        ),
        child: Form(
          key: controller.formKey,
          child: CustomScrollView(
            slivers: [
              _buildDropdownWithTitle(
                "requested_blood_group".tr,
                () {
                  AppGetDialog.showSelectDialog(
                      "blood_group".tr, controller.selectGroup, (selected) {
                    controller.selectedBloodGroupIndex.value = selected;
                  });
                },
                controller.selectedBloodGroupIndex,
                controller.selectGroup,
                dropdownValuePrefix: "${'blood_group'.tr}: ",
              ),
              SizedBox(height: 20).sliverBox,

              //*
              _buildDropdownWithTitle(
                "blood_units_required".tr,
                () {
                  AppGetDialog.showSelectDialog(
                      "blood_group".tr, controller.bloodUnits, (selected) {
                    controller.selectedBloodUnitsIndex.value = selected;
                  });
                },
                controller.selectedBloodUnitsIndex,
                controller.bloodUnits,
                dropdownValueSuffix: " ${'units'.tr} ",
              ),
              SizedBox(height: 20).sliverBox,

              //*
              Container(
                child: Material(
                  // color: Colors.transparent,
                  child: TextFormField(
                    onChanged: (_) => controller.validateForm(),

                    validator: Utils.nameValidator,
                    style: TextStyle(color: AppColors.primary),
                    // maxLength: 6,
                    // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.name,
                    controller: controller.teName,
                    decoration: InputDecoration(
                      labelText: 'full_name'.tr,
                      // labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.white,
                      // focusColor: Colors.white,
                    ),
                    // onChanged: (s) =>
                    //     controller.onAgeChange(s),
                  ),
                ),
              ).sliverBox,
              SizedBox(height: 20).sliverBox,
              //*
              //*
              Container(
                child: Material(
                  child: TextFormField(
                    onChanged: (_) => controller.validateForm(),

                    validator: Utils.numberValidator,
                    style: TextStyle(color: AppColors.primary),
                    // maxLength: 6,
                    // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    controller: controller.teNewNumber,
                    decoration: InputDecoration(
                      labelText: 'phone_number'.tr,
                      // labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.white,
                      // focusColor: Colors.white,
                    ),
                    // onChanged: (s) =>
                    //     controller.onAgeChange(s),
                  ),
                ),
              ).sliverBox,
              SizedBox(height: 20).sliverBox,
              //*

              _buildChangeLocationButton(),
              SizedBox(height: 30).sliverBox,
              //*
              CustomRoundedButton(
                  radius: 4,
                  disabledColor: AppColors.primary.withOpacity(.2),
                  color: AppColors.primary,
                  textDisabledColor: Colors.white,
                  textColor: Colors.white,
                  splashColor: AppColors.primary.withAlpha(0),
                  text: "search".tr,
                  // width: 200,
                  onTap: () {
                    if (controller.formKey.currentState.validate()) {
                      Get.focusScope.unfocus();
                      controller.search();
                    } else {}
                  }
                  //  () {
                  //   AuthController.to
                  //       .signOut()
                  //       .then((value) => Utils.whereShouldIGo());
                  // },
                  ).sliverBox,
            ],
          ).paddingAll(16).paddingOnly(top: 16),
        ),
      ),
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
