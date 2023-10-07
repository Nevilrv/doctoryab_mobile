import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/views/tab_docs_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_meeting_time_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: () {
        // double h;

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              // physics: BouncingScrollPhysics(),
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: () {
                  String _userProfile =
                      SettingsController.savedUserProfile?.photo;
                  Widget w = _userProfile == null
                      ? _profilePlaceHolder()
                      : CachedNetworkImage(
                          imageUrl: "${ApiConsts.hostUrl}$_userProfile",
                          height: 150,
                          width: 150,
                          placeholder: (_, __) {
                            return _profilePlaceHolder();
                          },
                          errorWidget: (_, __, ___) {
                            return _profilePlaceHolder();
                          },
                        );
                  return w;
                }())
                    .radiusAll(24),
                //*
                if (SettingsController.savedUserProfile != null)
                  Text(SettingsController.savedUserProfile?.name ?? ""
                          // "user_id".trArgs(
                          //   [SettingsController.savedUserProfile?.patientID ?? ""],
                          // ),
                          )
                      .paddingExceptBottom(10),
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
                      "update_profile".tr,
                      icon: Icons.edit,
                      color: Get.theme.primaryColor,
                      onTap: () {
                        Get.to(() => ProfileUpdateView());
                      },
                    ),
                  ],
                ).paddingExceptBottom(10),
                ..._buildSettings(),
              ]).paddingVertical(40),
        );
      }(),
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
