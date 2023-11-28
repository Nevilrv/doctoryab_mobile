import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BookingOtherInfoScreen extends GetView<CheckupPackagesController> {
  String selectedDate;
  String packageId;
  BookingOtherInfoScreen({Key key, this.selectedDate, this.packageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 45, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.back2,
                                    height: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "confirmation".tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.boldWhite20,
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(BasketDetailScreen());
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.history,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   right: 0,
                                //   // top: -5,
                                //   child: CircleAvatar(
                                //     radius: 8,
                                //     backgroundColor: AppColors.red2,
                                //     child: Center(
                                //       child: Text(
                                //         "3",
                                //         style: AppTextStyle.boldWhite10,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        // height: 220,

                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Container(
                          height: h * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          'appointment_details'.tr,
                                          style: AppTextTheme.b(11).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Container(
                                            width: w * 0.2,
                                            child: Divider(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              height: 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Utils.openPhoneDialer(context, item.phone);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColors.lightGrey,
                                            border: Border.all(
                                                color: AppColors.primary),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.calendar,
                                                height: 15,
                                                width: 15,
                                                color: AppColors.primary,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "${formatedDate}",
                                                  style: AppTextTheme.m(10)
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary),
                                                ),
                                              ),
                                              Spacer(),
                                              SvgPicture.asset(
                                                AppImages.clock,
                                                height: 15,
                                                width: 15,
                                                color: AppColors.primary,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "${formatedTime}",
                                                  style: AppTextTheme.m(12)
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.015,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              controller.isCheckBox.value =
                                                  !controller.isCheckBox.value;
                                            },
                                            child: SvgPicture.asset(
                                                controller.isCheckBox.value ==
                                                        false
                                                    ? AppImages.Checkbox
                                                    : AppImages.Checkbox1)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "i_m_patient".tr,
                                          style: AppTextTheme.m(10).copyWith(
                                              color: AppColors.primary),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.isCheckBox.value == true
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "full_name".tr,
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                  Text(
                                                    "*",
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColors.red3),
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
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                cursorColor: AppColors.primary,
                                                // maxLength: 6,
                                                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                keyboardType:
                                                    TextInputType.name,
                                                controller: controller.teName,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "please_enter_name".tr,
                                                    hintStyle: AppTextStyle.mediumPrimary12.copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    // prefixIconConstraints:
                                                    //     BoxConstraints.expand(
                                                    //   height: 30,
                                                    //   width: 30,
                                                    // ),
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: SvgPicture.asset(
                                                        AppImages.editName,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                        borderSide: BorderSide(
                                                            color: AppColors.primary.withOpacity(0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
                                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
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
                                              Row(
                                                children: [
                                                  Text(
                                                    "Phone_number".tr,
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                // onChanged: (_) =>
                                                //     controller.validateForm(),
                                                validator:
                                                    Utils.numberValidator,
                                                cursorColor: AppColors.primary,
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                // maxLength: 6,
                                                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller:
                                                    controller.teNewNumber,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "please_enter_phone".tr,
                                                    hintStyle: AppTextStyle.mediumPrimary12.copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    // prefixIconConstraints:
                                                    //     BoxConstraints.expand(
                                                    //   height: 30,
                                                    //   width: 30,
                                                    // ),
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: SvgPicture.asset(
                                                        AppImages.mobile,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: AppColors.primary.withOpacity(0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
                                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
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
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "age".tr,
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                // onChanged: (_) =>
                                                //     controller.validateForm(),
                                                validator: (age) =>
                                                    Utils.ageValidatore(age,
                                                        minAge: 12,
                                                        maxAge: 120),
                                                cursorColor: AppColors.primary,
                                                style: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                // maxLength: 6,
                                                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: controller.teAge,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "please_enter_age".tr,
                                                    hintStyle: AppTextStyle.mediumPrimary12.copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    // prefixIconConstraints:
                                                    //     BoxConstraints.expand(
                                                    //   height: 30,
                                                    //   width: 30,
                                                    // ),
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: SvgPicture.asset(
                                                        AppImages.gift,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: AppColors.primary.withOpacity(0.4),
                                                            strokeAlign: 2,
                                                            width: 2)),
                                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
                                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
                                                    contentPadding: EdgeInsets.zero
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
                                              Row(
                                                children: [
                                                  Text(
                                                    "gender".tr,
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                  Text(
                                                    "*",
                                                    style: AppTextStyle
                                                        .boldGrey12
                                                        .copyWith(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                AppColors.red3),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
                                                        width: 2),
                                                    color: AppColors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 10,
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: SvgPicture.asset(
                                                          AppImages.user,
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: DropdownButton<
                                                            String>(
                                                          underline: SizedBox(),
                                                          value: controller
                                                                  .selectedGender
                                                                  .value ??
                                                              "",
                                                          icon: Icon(
                                                              Icons.expand_more,
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.4)),
                                                          isDense: true,
                                                          hint: Text(
                                                              "Please_select_gender"
                                                                  .tr,
                                                              style: AppTextStyle
                                                                  .mediumPrimary12
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5))),
                                                          isExpanded: true,
                                                          items: controller
                                                              .genderList
                                                              .map((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(value,
                                                                  style: AppTextStyle
                                                                      .mediumPrimary12
                                                                      .copyWith(
                                                                          color: AppColors
                                                                              .primary
                                                                              .withOpacity(0.5))),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            controller
                                                                .selectedGender
                                                                .value = value;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height:
                                          controller.isCheckBox.value == true
                                              ? h * 0.02
                                              : h * 0.4,
                                    ),
                                    Container(
                                      height: 70,
                                      width: w,
                                      child: Center(
                                        child: CustomRoundedButton(
                                          color: AppColors.primary,
                                          textColor: Colors.white,
                                          splashColor:
                                              Colors.white.withOpacity(0.2),
                                          disabledColor: AppColors.easternBlue
                                              .withOpacity(0.2),
                                          // height: 50,
                                          width: w,
                                          text: "c_appointment".tr,
                                          textStyle: AppTextStyle.boldWhite14
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          onTap: () {
                                            if (controller.isCheckBox.value ==
                                                true) {
                                              if (controller
                                                  .teName.text.isEmpty) {
                                                Utils.commonSnackbar(
                                                    text:
                                                        "please_enter_name".tr,
                                                    context: context);
                                              } else if (controller
                                                  .teNewNumber.text.isEmpty) {
                                                Utils.commonSnackbar(
                                                    text:
                                                        "please_enter_phone".tr,
                                                    context: context);
                                              } else if (controller
                                                  .teAge.text.isEmpty) {
                                                Utils.commonSnackbar(
                                                    text: "please_enter_age".tr,
                                                    context: context);
                                              } else {
                                                controller.bookNow(
                                                    packageId: packageId);
                                              }
                                            } else {
                                              controller.bookNow(
                                                  packageId: packageId);
                                            }
                                          },
                                        ),
                                      ),
                                    ).paddingOnly(bottom: 20, top: 8)
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BottomBarView(
                  isHomeScreen: false,
                ))
          ],
        ));
  }

  String get formatedDate {
    var _str = DateTime.parse(selectedDate)
        .toPersianDateStr(useAfghaniMonthName: true);

    return _str.split(" ")[0] + " " + _str.split(" ")[1];
  }

  String get formatedTime {
    var _tmp = DateTime.parse(selectedDate).toLocal();

    return "${DateFormat('hh:mm').format(_tmp)} ${DateFormat("hh:mm a").format(_tmp).toString().contains("AM") ? "am".tr : "pm".tr}";
  }
}
