import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/auth_phone_controller.dart';

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
            Spacer(flex: 2),
            Hero(
                tag: "doctor_svg",
                child: SvgPicture.asset("assets/svg/d2.svg")),
            SizedBox(height: 20),
            Text(
              'phone_number'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 1),
            Hero(
              tag: "info_text",
              child: Text(
                'please_enter_your_phone_number'.tr,
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Theme(
              data: Get.theme.copyWith(
                primaryColor: Colors.white,
                // accentColor: Colors.red,
                hintColor: Colors.white,
              ),
              child: Obx(
                () => SizedBox(
                  width: MediaQuery.of(context).size.width < 400
                      ? double.infinity
                      : 400,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    controller: controller.textEditingController,
                    decoration: InputDecoration(
                      errorText: controller.phoneValidationError() == ""
                          ? null
                          : controller.phoneValidationError(),
                      labelText: 'phone_number'.tr,
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
                  width: 220,
                  onTap: !controller.phoneValid.value
                      ? null
                      : () => controller.signInWithPhone(),
                ).paddingOnly(bottom: 40),
              ),
            ),
            Spacer(flex: 4),
          ],
        ).paddingSymmetric(horizontal: 80),
      ),
    );
  }
}
