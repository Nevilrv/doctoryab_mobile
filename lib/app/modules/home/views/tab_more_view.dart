import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/views/tab_docs_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_meeting_time_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../data/ApiConsts.dart';
import '../../../data/models/city_model.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/TextTheme.dart';
import '../../../utils/AppGetDialog.dart';
import '../../../utils/utils.dart';
import '../../doctors/controllers/doctors_controller.dart';
import '../../doctors/views/doctors_view.dart';
import '../../profile_update/views/profile_update_view.dart';
import '../controllers/tab_home_main_controller.dart';

class TabMoreView extends GetView {
  const TabMoreView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpecialAppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('profile'.tr),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                AppImages.bellwhite,
                height: 24,
                color: AppColors.white,
              ),
            )
          ],
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: () {
          // double h;

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  // physics: BouncingScrollPhysics(),
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileUpdateView());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  offset: Offset(0, 4))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              SettingsController.savedUserProfile?.photo == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: _profilePlaceHolder(),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${ApiConsts.hostUrl}${SettingsController.savedUserProfile?.photo}",
                                        height: 52,
                                        width: 52,
                                        placeholder: (_, __) {
                                          return _profilePlaceHolder();
                                        },
                                        errorWidget: (_, __, ___) {
                                          return _profilePlaceHolder();
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    SettingsController.savedUserProfile?.name ??
                                        "",
                                    style: AppTextStyle.boldPrimary14
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Patient",
                                    style: AppTextStyle.boldPrimary14.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.primary.withOpacity(0.5)),
                                  )
                                ],
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.primary,
                                child: Icon(Icons.navigate_next_rounded,
                                    color: AppColors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Container(child: () {
                    //   String _userProfile =
                    //       SettingsController.savedUserProfile?.photo;
                    //   Widget w = _userProfile == null
                    //       ? _profilePlaceHolder()
                    //       : CachedNetworkImage(
                    //           imageUrl: "${ApiConsts.hostUrl}$_userProfile",
                    //           height: 150,
                    //           width: 150,
                    //           placeholder: (_, __) {
                    //             return _profilePlaceHolder();
                    //           },
                    //           errorWidget: (_, __, ___) {
                    //             return _profilePlaceHolder();
                    //           },
                    //         );
                    //   return w;
                    // }())
                    //     .radiusAll(24),
                    // //*
                    // if (SettingsController.savedUserProfile != null)
                    //   Text(SettingsController.savedUserProfile?.name ?? ""
                    //           // "user_id".trArgs(
                    //           //   [SettingsController.savedUserProfile?.patientID ?? ""],
                    //           // ),
                    //           )
                    //       .paddingExceptBottom(10),
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
                    //       "update_profile".tr,
                    //       icon: Icons.edit,
                    //       color: Get.theme.primaryColor,
                    //       onTap: () {
                    //         Get.to(() => ProfileUpdateView());
                    //       },
                    //     ),
                    //   ],
                    // ).paddingExceptBottom(10),
                    SizedBox(
                      height: 10,
                    ),
                    ..._buildSettings(),
                  ]),
            ),
          );
        }(),
      ),
    );
  }

  List<Widget> _buildSettings() {
    return [
      _buildSettingsItem(
        "${'select_city'.tr} - ${Get.find<TabHomeMainController>().selectedCity().getMultiLangName()}",
        Icons.language,
        () => AppGetDialog.showSelctCityDialog(
            cityChangedCallBack: (City city) =>
                Get.find<TabHomeMainController>().cityChanged(city)),
      ),
      _buildSettingsItem(
        "change_language".tr,
        MaterialCommunityIcons.translate,
        () => AppGetDialog.showChangeLangDialog(),
      ),
      // _buildSettingsItem(
      //   'blog'.tr,
      //   FontAwesome.firefox,
      //   () => Get.to(
      //     () => TabChatView(url: "https://www.doctoryab.info/blog"),
      //   ),
      // ),
      _buildSettingsItem(
        'my_doctors'.tr,
        FontAwesome.stethoscope,
        () => Get.to(
          () => DoctorsView(
            action: DOCTORS_LOAD_ACTION.myDoctors,
          ),
        ),
      ),
      _buildSettingsItem(
        'checkup_time'.tr,
        FontAwesome.stethoscope,
        () => Get.to(
          () => TabMeetingTimeView(),
        ),
      ),
      _buildSettingsItem(
        'reports'.tr,
        Ionicons.md_document,
        () => Get.to(() => TabDocsView()),
      ),

      _buildSettingsItem(
        'blood_donor'.tr,
        Ionicons.md_heart,
        () {},
      ),

      _buildSettingsItem(
        'find_blood_donor'.tr,
        AntDesign.medicinebox,
        // () => Get.to(() => TabDocsView()),
        () {},
      ),

      //
      _buildSettingsItem(
        "logout".tr,
        Icons.logout,
        () =>
            AuthController.to.signOut().then((value) => Utils.whereShouldIGo()),
      ),
    ];
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
      leading: Icon(icon, color: AppColors.black2),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.black2,
        ),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    ).bgColor(Colors.white60).radiusAll(8).basicShadow().paddingHorizontal(10);
  }

  Widget _profilePlaceHolder() {
    return Image.asset(
      "assets/png/person-placeholder.jpg",
      width: 52,
      height: 52,
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
