import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/AppTheme.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/spacialAppBar.dart';
import '../controllers/profile_update_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  ProfileUpdateView() {
    if (controller != null) {
      //! this line is neccecery or duplicate global key will apear in widget tree
      controller.formKey = GlobalKey<FormState>();
    }
    // controller.refresh();
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // FirebaseCrashlytics.instance.crash();
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/png/bg_blue2.png"), fit: BoxFit.fill)),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   actions: [
        //     TextButton.icon(
        //       onLongPress: () {
        //         // if (ApiConsts.hostUrl == ApiConsts.liveHostUrl) {
        //         //   Utils.showSnackBar(context, "Switched to local server");
        //         //   // ApiConsts.hostUrl = ApiConsts.localHostUrl;
        //         // } else {
        //         //   Utils.showSnackBar(context, "Switched to live server");
        //         // }
        //         // Utils.restartBeta(
        //         //   context,
        //         //   onInit: () {
        //         //     AppDioService.switchServer();
        //         //   },
        //         // );
        //       },
        //       onPressed: () {
        //         AuthController.to
        //             .signOut()
        //             .then((value) => Utils.whereShouldIGo());
        //       },
        //       icon: Icon(Icons.logout),
        //       label: Text("logout".tr),
        //     ).paddingHorizontal(10),
        //   ],
        // ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('update_profile'.tr),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              )),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                AppImages.bellwhite,
                height: 24,
              ),
            )
          ],
        ),

        body: Obx(() {
          return Container(
            height: h,
            child: Stack(
              children: [
                SingleChildScrollView(
                    child: Center(
                        child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // physics: BouncingScrollPhysics(),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: h * 0.73,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: h * 0.1,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: h * 0.02,
                                      child: Container(
                                        height: h * 0.15,
                                        width: h * 0.15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "${ApiConsts.hostUrl}${SettingsController.savedUserProfile?.photo}",
                                              ),
                                              onError: (exception, stackTrace) {
                                                return _profilePlaceHolder();
                                              },
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      left: w * 0.25,
                                      top: h * 0.123,
                                      child: Container(
                                        height: h * 0.05,
                                        width: h * 0.05,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Container(
                                            height: h * 0.04,
                                            width: h * 0.04,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    AppImages.noteEdit)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h * 0.08,
                                ),
                                Text(
                                  "user_ids".tr,
                                  style: AppTextStyle.boldGrey12.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey1),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              AppColors.black.withOpacity(0.2)),
                                      color: AppColors.grey2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      "${SettingsController.savedUserProfile?.patientID ?? ""}",
                                      style: AppTextStyle.boldGrey12.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Form(
                                    key: controller.formKey,
                                    // onWillPop: () async {
                                    //   controler.formKey = GlobalKey<FormState>();
                                    // },
                                    // autovalidateMode: AutovalidateMode.always,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "full_name".tr,
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                              Text(
                                                "*",
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.red3),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            onChanged: (_) =>
                                                controller.validateForm(),
                                            validator: Utils.nameValidator,
                                            style: AppTextStyle.mediumPrimary12
                                                .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.5)),
                                            cursorColor: AppColors.primary,
                                            // maxLength: 6,
                                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            keyboardType: TextInputType.name,
                                            controller: controller.teName,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "please_enter_name".tr,
                                                hintStyle: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                          left: 10, right: 10),
                                                  child: SvgPicture.asset(
                                                    AppImages.editName,
                                                  ),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                  child: SvgPicture.asset(
                                                    AppImages.editPen,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                "eMail".tr,
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                              Text(
                                                "*",
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.red3),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            onChanged: (_) =>
                                                controller.validateForm(),
                                            validator: Utils.nameValidator,
                                            cursorColor: AppColors.primary,
                                            style: AppTextStyle.mediumPrimary12
                                                .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.5)),
                                            // maxLength: 6,
                                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: controller.email,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "please_enter_email".tr,
                                                hintStyle: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                          left: 10, right: 10),
                                                  child: SvgPicture.asset(
                                                    AppImages.mail,
                                                  ),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                  child: SvgPicture.asset(
                                                    AppImages.editPen,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                "Phone_number".tr,
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            onChanged: (_) =>
                                                controller.validateForm(),
                                            validator: Utils.numberValidator,
                                            cursorColor: AppColors.primary,
                                            style: AppTextStyle.mediumPrimary12
                                                .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.5)),
                                            // maxLength: 6,
                                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            keyboardType: TextInputType.phone,
                                            controller: controller.teNewNumber,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "please_enter_email".tr,
                                                hintStyle: AppTextStyle
                                                    .mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                          left: 10, right: 10),
                                                  child: SvgPicture.asset(
                                                    AppImages.mobile,
                                                  ),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                  child: SvgPicture.asset(
                                                    AppImages.editPen,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            onChanged: (_) =>
                                                controller.validateForm(),
                                            validator: (age) =>
                                                Utils.ageValidatore(age,
                                                    minAge: 12, maxAge: 120),
                                            cursorColor: AppColors.primary,
                                            style: AppTextStyle.mediumPrimary12
                                                .copyWith(
                                                    color: AppColors.primary
                                                        .withOpacity(0.5)),
                                            // maxLength: 6,
                                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            keyboardType: TextInputType.number,
                                            controller: controller.teAge,
                                            decoration: InputDecoration(
                                                hintText: "please_enter_age".tr,
                                                hintStyle: AppTextStyle.mediumPrimary12
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
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
                                                          left: 10, right: 10),
                                                  child: SvgPicture.asset(
                                                    AppImages.gift,
                                                  ),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                  child: SvgPicture.asset(
                                                    AppImages.editPen,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        10),
                                                    borderSide: BorderSide(
                                                        color: AppColors.primary
                                                            .withOpacity(0.4),
                                                        strokeAlign: 2,
                                                        width: 2)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: BorderSide(color: AppColors.red, strokeAlign: 2, width: 2)),
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
                                                "your_city_selection".tr,
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                              Text(
                                                "*",
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.red3),
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
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: AppColors.primary
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                color: AppColors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: SvgPicture.asset(
                                                      AppImages.map,
                                                      color: AppColors.primary
                                                          .withOpacity(0.4),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w * 0.7,
                                                    child:
                                                        DropdownButton<String>(
                                                      underline: SizedBox(),
                                                      value: controller
                                                              .selectedLocation
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
                                                          "Please_select_city"
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
                                                          .locations
                                                          .map((String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value,
                                                              style: AppTextStyle
                                                                  .mediumPrimary12
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5))),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        controller
                                                            .selectedLocation
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "gender".tr,
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.primary),
                                              ),
                                              Text(
                                                "*",
                                                style: AppTextStyle.boldGrey12
                                                    .copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.red3),
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
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: AppColors.primary
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                color: AppColors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: SvgPicture.asset(
                                                      AppImages.user,
                                                      color: AppColors.primary
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        DropdownButton<String>(
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
                                                          .map((String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value,
                                                              style: AppTextStyle
                                                                  .mediumPrimary12
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.5))),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                              thickness: 2,
                              color: AppColors.white.withOpacity(0.5))),
                      // Obx(
                      //   () => Container(
                      //       child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Container(child: () {
                      //         String _userProfile =
                      //             SettingsController.savedUserProfile?.photo;
                      //         Widget _paceHolderImage = _userProfile == null
                      //             ? _profilePlaceHolder()
                      //             :
                      //             // Image.network(
                      //             //     "${ApiConsts.hostUrl}$_userProfile",
                      //             //     width: 150,
                      //             //     height: 150,
                      //             //     // cacheHeight: 150,
                      //             //     // cacheWidth: 150,
                      //             //     fit: BoxFit.cover,
                      //             //   ).radiusAll(24);
                      //             CachedNetworkImage(
                      //                 imageUrl: "${ApiConsts.hostUrl}$_userProfile",
                      //                 height: 150,
                      //                 width: 150,
                      //                 placeholder: (_, __) {
                      //                   return _profilePlaceHolder();
                      //                 },
                      //                 errorWidget: (_, __, ___) {
                      //                   return _profilePlaceHolder();
                      //                 },
                      //               ).radiusAll(24);
                      //         //
                      //         var _imageFromFile = (File file) {
                      //           return Image.file(
                      //             file,
                      //             width: 150,
                      //             height: 150,
                      //             fit: BoxFit.cover,
                      //           ).radiusAll(24);
                      //         };
                      //         //* logic
                      //         if (controller.imagePicked()) {
                      //           if (controller.uploadHadError()) {
                      //             if (controller.lastUploadedImagePath() != "") {
                      //               return _imageFromFile(
                      //                   File(controller.lastUploadedImagePath()));
                      //             }
                      //             return _paceHolderImage;
                      //           }
                      //           return _imageFromFile(controller.image.value);
                      //         }
                      //         return _paceHolderImage;
                      //       }()),
                      //
                      //       //* Loading Overly
                      //       controller.isUploadingImage()
                      //           ? Container(
                      //               color: Colors.black.withOpacity(0.7),
                      //               width: 150,
                      //               height: 150,
                      //               padding: EdgeInsets.all(50),
                      //               child: CircularProgressIndicator(
                      //                 backgroundColor: Colors.white,
                      //                 // backgroundColor: Colors.white,
                      //                 valueColor: AlwaysStoppedAnimation<Color>(
                      //                   AppColors.easternBlue,
                      //                 ),
                      //                 value: controller.uploadProgress.value,
                      //               ),
                      //             ).radiusAll(24)
                      //           : Container(),
                      //     ],
                      //   )).radiusCircular(24).paddingOnly(bottom: 20),
                      // ),
                      // //*
                      // if (SettingsController.savedUserProfile != null)
                      //   Text(
                      //     "user_id".trArgs(
                      //         [SettingsController.savedUserProfile?.patientID ?? ""]),
                      //   ),
                      // SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     // _button(
                      //     //   "change_language".tr,
                      //     //   icon: Icons.language,
                      //     //   color: Get.theme.primaryColor,
                      //     //   onTap: () {
                      //     //     AppGetDialog.showChangeLangDialog();
                      //     //   },
                      //     // ),
                      //     // SizedBox(width: 20),
                      //     _button(
                      //       "change_profile".tr,
                      //       icon: Icons.edit,
                      //       color: Get.theme.primaryColor,
                      //       onTap: () {
                      //         controller.pickImage();
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // if (SettingsController.isUserProfileComplete)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       //TODO check if this is ok with new page
                      //       // _button(
                      //       //   'my_doctors'.tr,
                      //       //   icon: FontAwesome.stethoscope,
                      //       //   color: Get.theme.primaryColor,
                      //       //   onTap: () {
                      //       //     //
                      //       //     Get.to(
                      //       //       () => DoctorsView(
                      //       //         action: DOCTORS_LOAD_ACTION.myDoctors,
                      //       //       ),
                      //       //     );
                      //       //   },
                      //       // ),
                      //       // SizedBox(width: 20),
                      //       // _button(
                      //       //   'reports'.tr,
                      //       //   icon: Ionicons.md_document,
                      //       //   color: Get.theme.primaryColor,
                      //       //   onTap: () {
                      //       //     Get.to(() => TabDocsView());
                      //       //   },
                      //       // ),
                      //     ],
                      //   ),
                      // //
                      // Theme(
                      //   data: AppTheme.secondaryTheme().copyWith(
                      //     primaryColor: AppColors.lgt2,
                      //     // accentColor: Colors.red,
                      //     hintColor: AppColors.lgt2,
                      //     // inputDecorationTheme:  Get.theme.inputDecorationTheme.copyWith(
                      //
                      //     // )
                      //   ),
                      //   child: Form(
                      //     key: controller.formKey,
                      //     // onWillPop: () async {
                      //     //   controler.formKey = GlobalKey<FormState>();
                      //     // },
                      //     // autovalidateMode: AutovalidateMode.always,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         SizedBox(
                      //           width: MediaQuery.of(context).size.width < 300
                      //               ? double.infinity
                      //               : 300,
                      //           child: TextFormField(
                      //             onChanged: (_) => controller.validateForm(),
                      //             validator: Utils.nameValidator,
                      //             style: TextStyle(color: AppColors.black2),
                      //             // maxLength: 6,
                      //             // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      //             keyboardType: TextInputType.name,
                      //             controller: controller.teName,
                      //             decoration: InputDecoration(
                      //               // errorText: controller.nameLastError() == ""
                      //               //     ? null
                      //               //     : controller.nameLastError(),
                      //               labelText: 'full_name'.tr,
                      //               // labelStyle: TextStyle(color: Colors.white),
                      //               // fillColor: Colors.white,
                      //               // focusColor: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(height: 20),
                      //         SizedBox(
                      //           width: MediaQuery.of(context).size.width < 300
                      //               ? double.infinity
                      //               : 300,
                      //           child: TextFormField(
                      //             onChanged: (_) => controller.validateForm(),
                      //             validator: (age) => Utils.ageValidatore(age,
                      //                 minAge: 12, maxAge: 120),
                      //             style: TextStyle(color: AppColors.black2),
                      //             // maxLength: 6,
                      //             // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      //             keyboardType: TextInputType.number,
                      //             controller: controller.teAge,
                      //             decoration: InputDecoration(
                      //               labelText: 'age'.tr,
                      //               // labelStyle: TextStyle(color: Colors.white),
                      //               // fillColor: Colors.white,
                      //               // focusColor: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(height: 20),
                      //         SizedBox(
                      //           width: MediaQuery.of(context).size.width < 300
                      //               ? double.infinity
                      //               : 300,
                      //           child: TextFormField(
                      //             onChanged: (_) => controller.validateForm(),
                      //             validator: Utils.numberValidator,
                      //             style: TextStyle(color: AppColors.black2),
                      //             // maxLength: 6,
                      //             // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      //             keyboardType: TextInputType.phone,
                      //             controller: controller.teNewNumber,
                      //             decoration: InputDecoration(
                      //               labelText: 'phone_number'.tr,
                      //               // labelStyle: TextStyle(color: Colors.white),
                      //               // fillColor: Colors.white,
                      //               // focusColor: Colors.white,
                      //             ),
                      //             // onChanged: (s) =>
                      //             //     controller.onAgeChange(s),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )).onTap(() {})),
                Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: BottomBarView(
                      isHomeScreen: false,
                      isBlueBackground: true,
                    ))
              ],
            ),
          );
        }),
        // bottomNavigationBar: Container(
        //   height: 140,
        //   child: Hero(
        //     tag: "bot_but",
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       // mainAxisSize: MainAxisSize.min,
        //       children: [
        //         CustomRoundedButton(
        //             disabledColor: AppColors.easternBlue.withOpacity(.2),
        //             color: AppColors.easternBlue,
        //             textDisabledColor: Colors.white,
        //             textColor: Colors.white,
        //             splashColor: AppColors.easternBlue.withAlpha(0),
        //             text: "save".tr,
        //             width: 300,
        //             onTap: () {
        //               if (controller.formKey.currentState.validate()) {
        //                 Get.focusScope.unfocus();
        //                 controller.updateProfile();
        //               } else {
        //                 print("ssssssss");
        //                 // Utils.restartApp();
        //               }
        //             }
        //             //  () {
        //             //   AuthController.to
        //             //       .signOut()
        //             //       .then((value) => Utils.whereShouldIGo());
        //             // },
        //             ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Text("design_and_develop_by".tr),
        //             Text(
        //               "Microcis",
        //               style:
        //                   AppTextTheme.b(14).copyWith(color: AppColors.primary),
        //             ).paddingAll(8).onTap(() {
        //               try {
        //                 launch("https://microcis.net");
        //               } catch (e) {}
        //             })
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget _profilePlaceHolder() {
    return Image.asset(
      "assets/png/person-placeholder.jpg",
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    ).radiusAll(24);
  }

  _button(String text,
      {Color color, VoidCallback onTap, @required IconData icon}) {
    return Container(
      color: color ?? Get.theme.primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 12,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: AppTextTheme.m(10).copyWith(color: Colors.white),
          ),
        ],
      ).paddingSymmetric(vertical: 8, horizontal: 12),
    ).radiusAll(14).paddingOnly(bottom: 20).onTap(onTap ?? () {});
  }
}
