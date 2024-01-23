import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../controllers/settings_controller.dart';
import '../controllers/auth_otp_controller.dart';

class AuthOtpView extends GetView<AuthOtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthOtpView'),
      //   centerTitle: true,
      // ),
      body: SpecialAppBackground(
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
                child: RotatedBox(
                  quarterTurns:
                      SettingsController.appLanguge == "English" ? 0 : 2,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            Spacer(),
            // Spacer(flex: 2),
            // Hero(
            //     tag: "doctor_svg",
            //     child: SvgPicture.asset("assets/svg/d2.svg"),),
            SizedBox(height: 20),
            Text(
              'security_validation'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            // Spacer(flex: 1),
            Hero(
              tag: "info_text",
              //TODO handle [Get.arguments] for web
              child: Text(
                'please_enter_otp_code_sent_to_your_phone'
                    .trArgs(["${controller.arg}"]),
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Obx(() {
              return () {
                return Theme(
                  data: Get.theme.copyWith(
                    primaryColor: Colors.white,
                    // accentColor: Colors.red,
                    hintColor: Colors.white,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 400
                        ? double.infinity
                        : 400,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      maxLength: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.white,
                      controller: controller.textEditingController,
                      decoration: InputDecoration(
                        errorText: controller.otpValidationError() == ""
                            ? null
                            : controller.otpValidationError(),
                        labelText: 'otp_code'.tr,
                        labelStyle: TextStyle(color: Colors.white),
                        // labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                      ),
                      onChanged: (s) => controller.validateOtpFormat(s),
                    ),
                  ),
                );
              }();
            }),
            SizedBox(height: 20),
            Hero(
              tag: "button",
              child: Obx(
                () => CustomRoundedButton(
                  text: "confirm".tr,
                  width: Get.width,
                  radius: 5,
                  onTap: !controller.otpFormatValid.value
                      ? null
                      : () => controller.verfyOtp(),
                ).paddingOnly(bottom: 40),
              ),
            ),
            if (!GetPlatform.isWeb) //TODO cand handle resend sms for now
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Container(
                      child: controller.waitingForFirebasToResendOtp.value
                          ? CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                          : Countdown(
                              controller: controller.countDountController,
                              seconds: 60,
                              build: (BuildContext context, double time) =>
                                  Text(
                                '${(time.toInt().toString())}',
                                style: TextStyle(color: Colors.white),
                              ),
                              onFinished: () {
                                print('Timer is done!');
                                controller.countDownFinished(true);
                                // isFinished = true;
                              },
                            ),
                    ),
                  ),
                  Obx(() => TextButton(
                        onPressed: controller.countDownFinished.value
                            ? controller.resendOtp
                            : null,
                        child: Text(
                          "resend_code".tr,
                          style: TextStyle(
                            color: !controller.countDownFinished.value
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            Spacer(),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
