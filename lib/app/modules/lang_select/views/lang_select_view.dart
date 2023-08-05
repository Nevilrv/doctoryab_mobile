import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/services/LocalizationServices.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';

import '../controllers/lang_select_controller.dart';

class LangSelectView extends GetView<LangSelectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('LangSelectView'),
      //   centerTitle: true,
      // ),
      body: SpecialAppBackground(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(flex: 4),
            Hero(
                tag: "doctor_svg",
                child: SvgPicture.asset("assets/svg/d2.svg")),
            SizedBox(height: 20),
            Text(
              'language_selection'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 1),
            Hero(
              tag: "info_text",
              child: Text(
                'please_select_language'.tr,
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 60),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: LocalizationService.langs.map<Widget>((languageName) {
                return Obx(() {
                  var isCurentLangSelected =
                      controller.selectedLang.value == languageName;
                  return CustomRoundedButton(
                    elevation: 0.0,
                    text: languageName,
                    width: 220,
                    color: isCurentLangSelected ? null : Colors.transparent,
                    textColor: isCurentLangSelected ? null : Colors.white,
                    showBorder: isCurentLangSelected ? false : true,
                    onTap: () {
                      controller.selectedLang.value = languageName;
                    },
                  ).paddingExceptBottom(8);
                });
              }).toList(),
            ),
            Spacer(flex: 4),
            Hero(
              tag: "button",
              child: Obx(
                () => CustomRoundedButton(
                  text: "confirm".tr,
                  width: 220,
                  onTap: controller.selectedLang.value == ''
                      ? null
                      : () {
                          SettingsController.appLanguge =
                              controller.selectedLang();
                          Get.toNamed(Routes.AUTH_PHONE);
                        },
                ).paddingOnly(bottom: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
