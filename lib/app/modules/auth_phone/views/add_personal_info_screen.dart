import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/modules/auth_phone/controllers/personal_detail_add_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/auth_phone_controller.dart';

class AddPersonalInfoScreen extends GetView<AddPersonalInfoController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthPhoneView'),
      //   centerTitle: true,
      // ),
      body: Obx(() {
        return SpecialAppBackground(
            child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height * 0.064,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
              ),
              Spacer(),
              // Hero(
              //     tag: "doctor_svg",
              //     child: SvgPicture.asset("assets/svg/d2.svg")),
              // SizedBox(height: 20),
              Text(
                'enter_personal_info'.tr,
                style: AppTextTheme.h1().copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "full_name".tr,
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                  Text(
                    "*",
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.red3),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                // onChanged: (_) =>
                //     controller.validateForm(),
                validator: Utils.nameValidator,
                style: AppTextStyle.mediumPrimary12
                    .copyWith(color: AppColors.primary),
                cursorColor: AppColors.primary,

                // maxLength: 6,
                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                keyboardType: TextInputType.name,
                controller: controller.teName,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: "please_enter_name".tr,
                    hintStyle: AppTextStyle.mediumPrimary12
                        .copyWith(color: AppColors.primary),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.white,
                        )),
                    // prefixIconConstraints:
                    //     BoxConstraints.expand(
                    //   height: 30,
                    //   width: 30,
                    // ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SvgPicture.asset(
                        AppImages.editName,
                        color: AppColors.primary,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: SvgPicture.asset(
                        AppImages.editPenBlue,
                        color: AppColors.primary,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.white)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.red)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0)
                    // errorText: controller.nameLastError() == ""
                    //     ? null
                    //     : controller.nameLastError(),

                    // labelStyle: TextStyle(color: Colors.white),
                    // fillColor: Colors.white,
                    // focusColor: Colors.white,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              controller.loginType == ""
                  ? Row(
                      children: [
                        Text(
                          "Phone_number".tr,
                          style: AppTextStyle.boldGrey12.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white),
                        ),
                      ],
                    )
                  : SizedBox(),
              controller.loginType == ""
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              controller.loginType == ""
                  ? TextFormField(
                      // onChanged: (_) =>
                      //     controller.validateForm(),
                      validator: Utils.numberValidator,
                      cursorColor: AppColors.primary,
                      style: AppTextStyle.mediumPrimary12
                          .copyWith(color: AppColors.primary),
                      // maxLength: 6,
                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.phone,
                      controller: controller.teNewNumber,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          hintText: "please_enter_phone".tr,
                          hintStyle: AppTextStyle.mediumPrimary12,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.white,
                              )),
                          // prefixIconConstraints:
                          //     BoxConstraints.expand(
                          //   height: 30,
                          //   width: 30,
                          // ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SvgPicture.asset(
                              AppImages.mobile,
                              color: AppColors.primary,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: SvgPicture.asset(
                              AppImages.editPenBlue,
                              color: AppColors.primary,
                              width: 16,
                              height: 16,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.white,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.red,
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.red,
                              )),
                          contentPadding: EdgeInsets.zero
                          // errorText: controller.nameLastError() == ""
                          //     ? null
                          //     : controller.nameLastError(),

                          // labelStyle: TextStyle(color: Colors.white),
                          // fillColor: Colors.white,
                          // focusColor: Colors.white,
                          ),
                      // onChanged: (s) =>
                      //     controller.onAgeChange(s),
                    )
                  : SizedBox(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "your_city_selection".tr,
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                  Text(
                    "*",
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.red3),
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.white),
                    color: AppColors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 10, bottom: 10, left: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          AppImages.map,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        width: w * 0.75,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          // value: controller.selectedLocation.value ?? "",
                          icon:
                              Icon(Icons.expand_more, color: AppColors.primary),
                          isDense: true,
                          hint: Text(
                              controller.selectedLocation.value == ""
                                  ? "Please_select_city".tr
                                  : controller.selectedLocation.value,
                              style: AppTextStyle.mediumPrimary12
                                  .copyWith(color: AppColors.primary)),
                          isExpanded: true,
                          items: controller.locations.map((City value) {
                            return DropdownMenuItem<String>(
                              value: value.sId,
                              child: Text(value.eName,
                                  style: AppTextStyle.mediumPrimary12
                                      .copyWith(color: AppColors.primary)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.locations.forEach((element) {
                              if (value == element.sId) {
                                controller.selectedLocation.value =
                                    element.eName;
                                SettingsController.auth.savedCity = element;
                              }
                            });

                            controller.selectedLocationId.value = value;
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
                    "gender".tr,
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                  Text(
                    "*",
                    style: AppTextStyle.boldGrey12.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.red3),
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary),
                    color: AppColors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 10, bottom: 10, left: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          AppImages.user,
                          color: AppColors.primary,
                        ),
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: controller.selectedGender.value ?? "",
                          icon:
                              Icon(Icons.expand_more, color: AppColors.primary),
                          isDense: true,
                          hint: Text("Please_select_gender".tr,
                              style: AppTextStyle.mediumPrimary12
                                  .copyWith(color: AppColors.primary)),
                          isExpanded: true,
                          items: controller.genderList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: AppTextStyle.mediumPrimary12
                                      .copyWith(color: AppColors.primary)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedGender.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.white,
                      )),
                    )
                  : CustomRoundedButton(
                      text: "continue".tr,
                      width: Get.width,
                      radius: 10,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      onTap: () {
                        if (controller.formKey.currentState.validate()) {
                          if (controller.selectedLocationId.value == "") {
                            Utils.showSnackBar(
                                context, "Please_select_city".tr);
                          } else {
                            controller.addPersonalInfo();
                          }
                        }
                      },
                    ).paddingOnly(bottom: 40, top: 20),
              Spacer(),
            ],
          ).paddingSymmetric(horizontal: 20),
        ));
      }),
    );
  }
}
