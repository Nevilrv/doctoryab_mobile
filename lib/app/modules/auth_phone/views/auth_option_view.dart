import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/auth_phone_controller.dart';
import 'dart:math' as math;

class AuthView extends GetView<AuthPhoneController> {
  AuthPhoneController controller = Get.put(AuthPhoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthPhoneView'),
      //   centerTitle: true,
      // ),
      body: Obx(() {
        return SpecialAppBackground(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              // Hero(
              //     tag: "doctor_svg",
              //     child: SvgPicture.asset("assets/svg/d2.svg")),
              // SizedBox(height: 20),
              Text(
                'sign_in'.tr,
                style: AppTextTheme.h1().copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                'sign_description'.tr,
                style: AppTextTheme.r(15).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.AUTH_PHONE);
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SettingsController.appLanguge != "English"
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: SvgPicture.asset(AppImages.phone,
                                    color: AppColors.primary),
                              )
                            : SvgPicture.asset(AppImages.phone,
                                color: AppColors.primary),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "sign_phone".tr,
                          style: AppTextTheme.b(16)
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER_GUEST_USER);
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.userCircle),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "guest_user".tr,
                          style: AppTextTheme.b(16)
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: AppColors.white,
                    ))
                  : GestureDetector(
                      onTap: () {
                        controller.signInWithGoogle(context);
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.google),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "sign_google".tr,
                                style: AppTextTheme.b(16)
                                    .copyWith(color: AppColors.primary),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.facebook),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "sign_Facebook".tr,
                        style: AppTextTheme.b(16)
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  )),
                ),
              ),
              Spacer(),
            ],
          ).paddingSymmetric(horizontal: 20),
        );
      }),
    );
  }
}
