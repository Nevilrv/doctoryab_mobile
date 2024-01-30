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
            Spacer(),
            // Hero(
            //     tag: "doctor_svg",
            //     child: SvgPicture.asset("assets/svg/d2.svg")),
            SizedBox(height: Get.height * 0.1),
            Text(
              'select_language'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            // Spacer(flex: 1),
            // Hero(
            //   tag: "info_text",
            //   child: Text(
            //     'please_select_language'.tr,
            //     style: AppTextTheme.r(14).copyWith(color: Colors.white),
            //     textAlign: TextAlign.center,
            //   ).paddingSymmetric(horizontal: 60),
            // ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: LocalizationService.langs.map<Widget>((languageName) {
                  return Obx(() {
                    var isCurentLangSelected =
                        controller.selectedLang.value == languageName;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CustomRoundedButton(
                        elevation: 0.0,
                        radius: 5,
                        text: languageName,
                        width: Get.width,
                        color: isCurentLangSelected ? null : Colors.transparent,
                        textColor: isCurentLangSelected ? null : Colors.white,
                        showBorder: isCurentLangSelected ? false : true,
                        onTap: () {
                          controller.selectedLang.value = languageName;
                        },
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Hero(
              tag: "button",
              child: Obx(
                () => CustomRoundedButton(
                  text: "continue".tr,
                  width: Get.width,
                  onTap: controller.selectedLang.value == ''
                      ? null
                      : () {
                          SettingsController.appLanguge =
                              controller.selectedLang();
                          Get.toNamed(Routes.AUTH_OPTION);
                        },
                ).paddingOnly(bottom: 40, right: 20, left: 20),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
