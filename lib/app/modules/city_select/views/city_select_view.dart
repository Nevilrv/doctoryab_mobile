import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/city_select_controller.dart';

class CitySelectView extends GetView<CitySelectController> {
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
            // Spacer(flex: 2),
            // Hero(
            //     tag: "doctor_svg",
            //     child: SvgPicture.asset("assets/svg/d2.svg")),
            Spacer(),
            SizedBox(height: 20),
            Text(
              'select_city'.tr,
              style: AppTextTheme.h1().copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),

            Hero(
              tag: "info_text",
              child: Text(
                'please_select_city_you_live_in'.tr,
                style: AppTextTheme.r(14).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  AppGetDialog.showSelctCityDialog(
                    saveInstantlyAfterClick: false,
                    cityChangedCallBack: (c) => controller.selectedCity(c),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          controller.selectedCity().sId == null
                              ? "select_city".tr
                              : controller.selectedCity().getMultiLangName(),
                          style: TextStyle(color: AppColors.primary),
                          overflow: TextOverflow.fade,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            // Theme(
            //   data: Get.theme.copyWith(
            //     primaryColor: Colors.white,
            //     // accentColor: Colors.red,
            //     hintColor: Colors.white,
            //   ),
            //   child: SizedBox(
            //     width: Get.width,
            //     child: OutlinedButton.icon(
            //       //TODO change this with row
            //       icon: Obx(
            //         () => Text(
            //           controller.selectedCity().sId == null
            //               ? "select_city".tr
            //               : controller.selectedCity().getMultiLangName(),
            //           style: TextStyle(color: AppColors.lgt),
            //           overflow: TextOverflow.fade,
            //         ).paddingSymmetric(horizontal: 4, vertical: 10),
            //       ),
            //       onPressed: () {
            //         AppGetDialog.showSelctCityDialog(
            //           saveInstantlyAfterClick: false,
            //           cityChangedCallBack: (c) => controller.selectedCity(c),
            //         );
            //       },
            //       label: Icon(
            //         Icons.arrow_drop_down,
            //         color: AppColors.lgt,
            //       ),
            //       style: OutlinedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12.0),
            //           // side: BorderSide(color: Colors.white, width:),
            //         ),
            //         side: BorderSide(color: AppColors.lgt),
            //         // side: BorderSide(width: 2,),
            //       ),
            //       // style: ButtonStyle(),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),

            Hero(
              tag: "button",
              child: Obx(
                () => CustomRoundedButton(
                  text: "confirm".tr,
                  width: Get.width, radius: 5,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  onTap: controller.selectedCity().sId == null
                      ? null
                      : controller.confirmSelectedCity,
                  // onTap: !controller.phoneValid.value
                  //     ? null
                  //     : () => controller.signInWithPhone(),
                ).paddingOnly(bottom: 20),
              ),
            ),
            Spacer(),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
