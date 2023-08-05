import 'dart:developer';

import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';

import '../../../components/spacialAppBar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/blood_donor_controller.dart';

class BloodDonorView extends GetView<BloodDonorController> {
  BloodDonorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        "blood_donor".tr,
        showLeading: false,
      ),
      body: Container(
        child: _tmp(),
      ),
    );
  }

  Widget _tmp() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        _buildTitle("select_blood_group".tr),
        SliverList(
          delegate: SliverChildListDelegate(
            _buildRows(controller.selectGroup),
          ),
        ),
        _buildTitle("location".tr),
        _buildChangeLocationButton(),
        _buildTitle("gender".tr),
        SizedBox(height: 10).sliverBox,
        _buildGenderRow(),
        _buildCheckbox(),
        _buildSaveButton(),
      ],
    ).paddingHorizontal(40);
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: AppTextTheme.m(16).copyWith(color: AppColors.disabledButtonColor),
    ).paddingHorizontal(30).paddingOnly(top: 16, bottom: 8).sliverBox;
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

  Widget _buildGenderRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(child: _buildGenderItem("male".tr, 0)),
        SizedBox(width: 20),
        Flexible(child: _buildGenderItem("female".tr, 1)),
      ],
    ).paddingHorizontal(22).sliverBox;
  }

  Widget _buildCheckbox() {
    return Transform.scale(
      scale: 0.9,
      child: Obx(() => CheckboxListTile(
            title: Text(
              'i_am_over_18y_and_50kg'.tr,
              style: AppTextTheme.m(14).copyWith(
                color: AppColors.primary,
              ),
            ),
            value: controller.iAmOver18(),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            onChanged: (newValue) {
              controller.iAmOver18.value = newValue;
            },
          )),
    ).sliverBox;
  }

  Widget _buildSaveButton() {
    return Obx(
      () => CustomRoundedButton(
        text: "save".tr,
        onTap: controller.iAmOver18.value &&
                controller.locationResult()?.locality != null
            ? () => controller.save()
            : null,
        color: AppColors.primary,
        textColor: Colors.white,
        radius: 6,
      ).paddingHorizontal(16).paddingVertical(20).sliverBox,
    );
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

      rows.add(Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowChildren,
          )));
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
    ).paddingSymmetric(horizontal: 8, vertical: 8);
  }

  Widget _buildGenderItem(String text, int value) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: controller.selectedGender() == value
              ? AppColors.primary
              : Colors.white,
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        height: 40,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextTheme.b(16).copyWith(
                height: 0,
                color: controller.selectedGender() != value
                    ? AppColors.primary
                    : Colors.white),
          ),
        ),
      ).onTap(
        () {
          controller.selectedGender(value);
        },
      );
    });
  }
}
