import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppTheme.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import '../controllers/patient_info_controller.dart';

class PatientInfoView extends GetView<PatientInfoController> {
  @override
  Widget build(BuildContext context) {
    final _node = FocusScope.of(context);
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        "patient_info".tr,
      ),
      //TODO use this kind of scrollview to update profile as well
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ListTile(
              leading: Transform.scale(
                scale: 1.11,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    // color: Colors.black,
                    // height: 65,
                    // width: 65,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${ApiConsts.hostUrl}${controller.doctor().photo}",
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Image.asset(
                          "assets/png/person-placeholder.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (_, __, ___) {
                        return Image.asset(
                          "assets/png/person-placeholder.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    // Image.network(
                    //   "${ApiConsts.hostUrl}${controller.doctor().photo}",
                    //   fit: BoxFit.cover,
                    // ),
                  ).radiusAll(20),
                ),
              ),
              title: Text(
                "${controller.doctor().name ?? ""} ${controller.doctor().lname ?? ""}",
                style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
              ).paddingOnly(top: 8),
              subtitle: Text(
                controller.doctor()?.category?.title ?? "",
                style: AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
              ),
            ),
            SizedBox(height: 30),
            //* End
            Text(
              "booking_time:".tr,
              style: AppTextTheme.b(15).copyWith(color: AppColors.black2),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.formatedDate,
                  style: AppTextTheme.h(20).copyWith(
                    color: Get.theme.primaryColor,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  controller.formatedTime,
                  style: AppTextTheme.h(20).copyWith(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            //*
            SizedBox(height: 20),
            Obx(() => CheckboxListTile(
                  value: controller.iamIll.value,
                  onChanged: (value) => controller.iamIll(!controller.iamIll()),
                  title: Text("i_am_patient".tr),
                  // dense: true,
                  // tristate: false,
                )),
            SizedBox(height: 20),

            Obx(
              () => SizedBox(
                height: controller.iamIll() ? 0 : null,
                child: Opacity(
                  opacity: controller.iamIll() ? 0 : 1,

                  child: Wrap(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "patient_info".tr + ":",
                            style: AppTextTheme.b(15)
                                .copyWith(color: AppColors.black2),
                          ),
                          SizedBox(height: 20),
                          Theme(
                            data: AppTheme.secondaryTheme().copyWith(
                              primaryColor: AppColors.lgt2,
                              // accentColor: Colors.red,
                              hintColor: AppColors.lgt2,

                              // inputDecorationTheme:  Get.theme.inputDecorationTheme.copyWith(

                              // )
                            ),
                            child: Center(
                              child: Form(
                                key: controller.formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width < 300
                                      ? double.infinity
                                      : 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        onChanged: (_) =>
                                            controller.validateForm(),
                                        validator: Utils.nameValidator,
                                        style: AppTextTheme.b(15).copyWith(
                                          color: AppColors.black2,
                                        ),
                                        keyboardType: TextInputType.name,
                                        controller: controller.teName,
                                        decoration: InputDecoration(
                                          labelText: 'full_name'.tr,
                                        ),
                                        onFieldSubmitted: (v) =>
                                            _node.nextFocus(),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(height: 30),
                                      TextFormField(
                                        onChanged: (_) =>
                                            controller.validateForm(),
                                        validator: Utils.ageValidatore,
                                        style:
                                            TextStyle(color: AppColors.black2),
                                        keyboardType: TextInputType.number,
                                        controller: controller.teAge,
                                        decoration: InputDecoration(
                                          labelText: 'age'.tr,
                                        ),
                                        onFieldSubmitted: (v) =>
                                            _node.nextFocus(),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(height: 30),
                                      TextFormField(
                                        onChanged: (_) =>
                                            controller.validateForm(),
                                        validator: Utils.numberValidator,
                                        style:
                                            TextStyle(color: AppColors.black2),
                                        keyboardType: TextInputType.phone,
                                        controller: controller.tePhoneNumber,
                                        decoration: InputDecoration(
                                          labelText: 'phone_number'.tr,
                                        ),
                                        // onEditingComplete: () => Get.focusScope.nextFocus(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //*end
                ),
              ),
            )
          ],
        ).paddingHorizontal(20),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Hero(
          tag: "bot_but",
          child: Center(
            child: Obx(
              () => CustomRoundedButton(
                color: AppColors.easternBlue,
                textColor: Colors.white,
                splashColor: Colors.white.withOpacity(0.2),
                disabledColor: AppColors.easternBlue.withOpacity(0.2),
                // height: 50,
                width: 250,
                text: "confirm".tr,
                onTap: controller.formValid() ? controller.bookNow : null,
                // onTap: controller.isTimePicked()
                //     ? () {
                //         BookingController.to.selectedDate(
                //             DateTime.tryParse(controller.selectedTime()));
                //         // Get.toNamed(Routes.PATIENT_INFO);
                //       }
                //     : null,
              ),
            ),
          ),
        ),
      ).paddingOnly(bottom: 20, top: 8),
    );
  }
}
