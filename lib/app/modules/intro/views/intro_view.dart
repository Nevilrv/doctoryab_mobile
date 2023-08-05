import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';

import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  final bool splashScreenMode;
  IntroView({this.splashScreenMode = true}) {
    controller.splahScreenMode = this.splashScreenMode;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('IntroView'),
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
            Hero(
              tag: "heading",
              child: Text(
                'welcome_to_doctoryab_app'.tr,
                style: AppTextTheme.h1().copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 1),
            Hero(
              tag: "info_text",
              child: Text(
                'intro_info_text'.tr,
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 60),
            ),
            Spacer(flex: controller.splahScreenMode ? 4 : 1),
            controller.splahScreenMode
                ? Hero(
                    tag: "button",
                    child: CustomRoundedButton(
                      text: "start".tr,
                      width: 190,
                      onTap: () => Get.toNamed(Routes.LANG_SELECT),
                    ).paddingOnly(bottom: 40),
                  )
                : Expanded(
                    child: Column(
                      // mainAxisSize: m,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            "please_wait".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        CircularProgressIndicator(
                          backgroundColor: Get.theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
            if (!controller.splahScreenMode) Spacer()
          ],
        ),
      ),
    );
  }
}
