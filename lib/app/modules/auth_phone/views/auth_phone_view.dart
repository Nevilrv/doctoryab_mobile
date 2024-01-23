import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/modules/auth_phone/controllers/auth_phone_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthPhoneView extends GetView<AuthPhoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthPhoneView'),
      //   centerTitle: true,
      // ),
      body: SpecialAppBackground(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            // Hero(
            //     tag: "doctor_svg",
            //     child: SvgPicture.asset("assets/svg/d2.svg")),
            // SizedBox(height: 20),
            Text(
              'Phone_number'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),

            Hero(
              tag: "info_text",
              child: Text(
                'please_enter_your_phone_number'.tr,
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: Get.width,
              child: Theme(
                data: Get.theme.copyWith(
                  primaryColor: Colors.white,
                  // accentColor: Colors.red,
                  hintColor: Colors.white,
                ),
                child: Obx(
                  () => TextField(
                    style: TextStyle(color: Colors.white),
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    cursorColor: AppColors.white,
                    controller: controller.textEditingController,
                    decoration: InputDecoration(
                      errorText: controller.phoneValidationError() == ""
                          ? null
                          : controller.phoneValidationError(),
                      labelText: 'phone_number'.tr,
                      labelStyle: TextStyle(color: Colors.white),
                      // labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                    onChanged: (n) => controller.verfyPhoneNumber(n),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Hero(
              tag: "button",
              child: Obx(
                () => CustomRoundedButton(
                  text: "confirm".tr,
                  width: Get.width,
                  radius: 5,
                  onTap: !controller.phoneValid.value
                      ? null
                      : () => controller.signInWithPhone(),
                ).paddingOnly(bottom: 40),
              ),
            ),
            Hero(
              tag: "tmp",
              child: CustomRoundedButton(
                text: "other_sign_in_option".tr,
                width: 220,
                onTap: () => Get.back(),
              ).paddingOnly(bottom: 40),
            ),
            Spacer(),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
