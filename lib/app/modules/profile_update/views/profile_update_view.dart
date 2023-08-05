import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppTheme.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';

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
    // FirebaseCrashlytics.instance.crash();
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
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
      appBar: AppAppBar.specialAppBar("update_profile".tr),

      body: () {
        // double h;

        return SingleChildScrollView(
            child: Center(
          child: Column(
            // physics: BouncingScrollPhysics(),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(child: () {
                      String _userProfile =
                          SettingsController.savedUserProfile?.photo;
                      Widget _paceHolderImage = _userProfile == null
                          ? _profilePlaceHolder()
                          :
                          // Image.network(
                          //     "${ApiConsts.hostUrl}$_userProfile",
                          //     width: 150,
                          //     height: 150,
                          //     // cacheHeight: 150,
                          //     // cacheWidth: 150,
                          //     fit: BoxFit.cover,
                          //   ).radiusAll(24);
                          CachedNetworkImage(
                              imageUrl: "${ApiConsts.hostUrl}$_userProfile",
                              height: 150,
                              width: 150,
                              placeholder: (_, __) {
                                return _profilePlaceHolder();
                              },
                              errorWidget: (_, __, ___) {
                                return _profilePlaceHolder();
                              },
                            ).radiusAll(24);
                      //
                      var _imageFromFile = (File file) {
                        return Image.file(
                          file,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ).radiusAll(24);
                      };
                      //* logic
                      if (controller.imagePicked()) {
                        if (controller.uploadHadError()) {
                          if (controller.lastUploadedImagePath() != "") {
                            return _imageFromFile(
                                File(controller.lastUploadedImagePath()));
                          }
                          return _paceHolderImage;
                        }
                        return _imageFromFile(controller.image.value);
                      }
                      return _paceHolderImage;
                    }()),

                    //* Loading Overly
                    controller.isUploadingImage()
                        ? Container(
                            color: Colors.black.withOpacity(0.7),
                            width: 150,
                            height: 150,
                            padding: EdgeInsets.all(50),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              // backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.easternBlue,
                              ),
                              value: controller.uploadProgress.value,
                            ),
                          ).radiusAll(24)
                        : Container(),
                  ],
                )).radiusCircular(24).paddingOnly(bottom: 20),
              ),
              //*
              if (SettingsController.savedUserProfile != null)
                Text(
                  "user_id".trArgs(
                      [SettingsController.savedUserProfile?.patientID ?? ""]),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _button(
                  //   "change_language".tr,
                  //   icon: Icons.language,
                  //   color: Get.theme.primaryColor,
                  //   onTap: () {
                  //     AppGetDialog.showChangeLangDialog();
                  //   },
                  // ),
                  // SizedBox(width: 20),
                  _button(
                    "change_profile".tr,
                    icon: Icons.edit,
                    color: Get.theme.primaryColor,
                    onTap: () {
                      controller.pickImage();
                    },
                  ),
                ],
              ),
              if (SettingsController.isUserProfileComplete)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO check if this is ok with new page
                    // _button(
                    //   'my_doctors'.tr,
                    //   icon: FontAwesome.stethoscope,
                    //   color: Get.theme.primaryColor,
                    //   onTap: () {
                    //     //
                    //     Get.to(
                    //       () => DoctorsView(
                    //         action: DOCTORS_LOAD_ACTION.myDoctors,
                    //       ),
                    //     );
                    //   },
                    // ),
                    // SizedBox(width: 20),
                    // _button(
                    //   'reports'.tr,
                    //   icon: Ionicons.md_document,
                    //   color: Get.theme.primaryColor,
                    //   onTap: () {
                    //     Get.to(() => TabDocsView());
                    //   },
                    // ),
                  ],
                ),
              //
              Theme(
                data: AppTheme.secondaryTheme().copyWith(
                  primaryColor: AppColors.lgt2,
                  // accentColor: Colors.red,
                  hintColor: AppColors.lgt2,
                  // inputDecorationTheme:  Get.theme.inputDecorationTheme.copyWith(

                  // )
                ),
                child: Form(
                  key: controller.formKey,
                  // onWillPop: () async {
                  //   controler.formKey = GlobalKey<FormState>();
                  // },
                  // autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 300
                            ? double.infinity
                            : 300,
                        child: TextFormField(
                          onChanged: (_) => controller.validateForm(),
                          validator: Utils.nameValidator,
                          style: TextStyle(color: AppColors.black2),
                          // maxLength: 6,
                          // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.name,
                          controller: controller.teName,
                          decoration: InputDecoration(
                            // errorText: controller.nameLastError() == ""
                            //     ? null
                            //     : controller.nameLastError(),
                            labelText: 'full_name'.tr,
                            // labelStyle: TextStyle(color: Colors.white),
                            // fillColor: Colors.white,
                            // focusColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 300
                            ? double.infinity
                            : 300,
                        child: TextFormField(
                          onChanged: (_) => controller.validateForm(),
                          validator: (age) =>
                              Utils.ageValidatore(age, minAge: 12, maxAge: 120),
                          style: TextStyle(color: AppColors.black2),
                          // maxLength: 6,
                          // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.number,
                          controller: controller.teAge,
                          decoration: InputDecoration(
                            labelText: 'age'.tr,
                            // labelStyle: TextStyle(color: Colors.white),
                            // fillColor: Colors.white,
                            // focusColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 300
                            ? double.infinity
                            : 300,
                        child: TextFormField(
                          onChanged: (_) => controller.validateForm(),
                          validator: Utils.numberValidator,
                          style: TextStyle(color: AppColors.black2),
                          // maxLength: 6,
                          // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.phone,
                          controller: controller.teNewNumber,
                          decoration: InputDecoration(
                            labelText: 'phone_number'.tr,
                            // labelStyle: TextStyle(color: Colors.white),
                            // fillColor: Colors.white,
                            // focusColor: Colors.white,
                          ),
                          // onChanged: (s) =>
                          //     controller.onAgeChange(s),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 30),
        ).onTap(() {}));
      }(),
      bottomNavigationBar: Container(
        height: 140,
        child: Hero(
          tag: "bot_but",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: [
              CustomRoundedButton(
                  disabledColor: AppColors.easternBlue.withOpacity(.2),
                  color: AppColors.easternBlue,
                  textDisabledColor: Colors.white,
                  textColor: Colors.white,
                  splashColor: AppColors.easternBlue.withAlpha(0),
                  text: "save".tr,
                  width: 300,
                  onTap: () {
                    if (controller.formKey.currentState.validate()) {
                      Get.focusScope.unfocus();
                      controller.updateProfile();
                    } else {
                      print("ssssssss");
                      // Utils.restartApp();
                    }
                  }
                  //  () {
                  //   AuthController.to
                  //       .signOut()
                  //       .then((value) => Utils.whereShouldIGo());
                  // },
                  ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("design_and_develop_by".tr),
                  Text(
                    "Microcis",
                    style:
                        AppTextTheme.b(14).copyWith(color: AppColors.primary),
                  ).paddingAll(8).onTap(() {
                    try {
                      launch("https://microcis.net");
                    } catch (e) {}
                  })
                ],
              ),
            ],
          ),
        ),
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
