import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/reports_controller.dart';
import 'package:doctor_yab/app/modules/notification/controllers/notification_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/settings_controller.dart';
import '../../../../data/ApiConsts.dart';
import '../../../../theme/AppColors.dart';
import '../../../../theme/TextTheme.dart';
import '../../../../utils/AppGetDialog.dart';
import '../../../profile_update/views/profile_update_view.dart';
import '../../controllers/tab_home_main_controller.dart';

class TabMoreView extends GetView {
  TabMoreView({Key? key}) : super(key: key);
  NotificationController notificationController =
      Get.put(NotificationController())..loadNotification();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/png/bg_blue2.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'profile'.tr,
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATION);
                        },
                        child: Image.asset(
                          AppImages.bell,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: CircleAvatar(
                          backgroundColor: notificationController.notification
                                  .any((element) => element.status == "unread")
                              ? AppColors.red2
                              : Colors.transparent,
                          radius: 4,
                        ),
                      ),
                    ],
                  ),
                ),
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
                                    "patient".tr,
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: AppColors.white, height: 3),
                    ),
                    SizedBox(
                      height: 20,
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
      commonprofilemenu(
          onTap: () {
            Get.toNamed(Routes.CITY_SELECT_PROFILE);
          },
          icon: AppImages.map,
          title: "change_city".tr +
              " - " +
              "${Get.find<TabHomeMainController>().selectedCity().getMultiLangName()}"),
      commonprofilemenu(
          onTap: () {
            Get.toNamed(Routes.My_DOCTOR);
          },
          icon: AppImages.doctor,
          title: 'my_doctors'.tr),
      commonprofilemenu(
          onTap: () {
            ReportsController repo = Get.put(ReportsController());
            repo.tabIndex.value = 0;
            Get.toNamed(Routes.REPORT_MEDICAL);
          },
          icon: AppImages.frame,
          title: "reports".tr),
      commonprofilemenu(
          onTap: () {
            Get.toNamed(Routes.APPOINTMENT_HISTORY);
          },
          icon: AppImages.history,
          title: "appointment_history".tr),
      commonprofilemenu(
          onTap: () {
            AppGetDialog.showChangeLangDialog(notificationController);
          },
          icon: AppImages.frame,
          title: "change_language".tr),

      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.COMPLAINT);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Text(
                      "complaint".tr,
                      style: AppTextStyle.boldPrimary14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SUGGESTION);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Text(
                      "suggestion".tr,
                      style: AppTextStyle.boldPrimary14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      GestureDetector(
        onTap: () {
          AuthController.to.signOut().then((value) => Utils.whereShouldIGo());
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.red, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "logout".tr,
                  style: AppTextStyle.boldWhite14,
                ),
                Icon(
                  Icons.logout,
                  color: AppColors.white,
                )
              ],
            )),
          ),
        ),
      )
      // _buildSettingsItem(
      //   "${'select_city'.tr} - ${Get.find<TabHomeMainController>().selectedCity().getMultiLangName()}",
      //   Icons.language,
      //   () => AppGetDialog.showSelctCityDialog(
      //       cityChangedCallBack: (City city) =>
      //           Get.find<TabHomeMainController>().cityChanged(city)),
      // ),
      // _buildSettingsItem(
      //   "change_language".tr,
      //   MaterialCommunityIcons.translate,
      //   () => AppGetDialog.showChangeLangDialog(),
      // ),
      // // _buildSettingsItem(
      // //   'blog'.tr,
      // //   FontAwesome.firefox,
      // //   () => Get.to(
      // //     () => TabChatView(url: "https://www.doctoryab.info/blog"),
      // //   ),
      // // ),
      // _buildSettingsItem(
      //   'my_doctors'.tr,
      //   FontAwesome.stethoscope,
      //   () => Get.to(
      //     () => DoctorsView(
      //       action: DOCTORS_LOAD_ACTION.myDoctors,
      //     ),
      //   ),
      // ),
      // _buildSettingsItem(
      //   'checkup_time'.tr,
      //   FontAwesome.stethoscope,
      //   () => Get.to(
      //     () => TabMeetingTimeView(),
      //   ),
      // ),
      // _buildSettingsItem(
      //   'reports'.tr,
      //   Ionicons.md_document,
      //   () => Get.to(() => TabDocsView()),
      // ),
      //
      // _buildSettingsItem(
      //   'blood_donor'.tr,
      //   Ionicons.md_heart,
      //   () {},
      // ),
      //
      // _buildSettingsItem(
      //   'find_blood_donor'.tr,
      //   AntDesign.medicinebox,
      //   // () => Get.to(() => TabDocsView()),
      //   () {},
      // ),
      //
      // //
      // _buildSettingsItem(
      //   "logout".tr,
      //   Icons.logout,
      //   () =>
      //       AuthController.to.signOut().then((value) => Utils.whereShouldIGo()),
      // ), // _buildSettingsItem(
      //   "${'select_city'.tr} - ${Get.find<TabHomeMainController>().selectedCity().getMultiLangName()}",
      //   Icons.language,
      //   () => AppGetDialog.showSelctCityDialog(
      //       cityChangedCallBack: (City city) =>
      //           Get.find<TabHomeMainController>().cityChanged(city)),
      // ),
      // _buildSettingsItem(
      //   "change_language".tr,
      //   MaterialCommunityIcons.translate,
      //   () => AppGetDialog.showChangeLangDialog(),
      // ),
      // // _buildSettingsItem(
      // //   'blog'.tr,
      // //   FontAwesome.firefox,
      // //   () => Get.to(
      // //     () => TabChatView(url: "https://www.doctoryab.info/blog"),
      // //   ),
      // // ),
      // _buildSettingsItem(
      //   'my_doctors'.tr,
      //   FontAwesome.stethoscope,
      //   () => Get.to(
      //     () => DoctorsView(
      //       action: DOCTORS_LOAD_ACTION.myDoctors,
      //     ),
      //   ),
      // ),
      // _buildSettingsItem(
      //   'checkup_time'.tr,
      //   FontAwesome.stethoscope,
      //   () => Get.to(
      //     () => TabMeetingTimeView(),
      //   ),
      // ),
      // _buildSettingsItem(
      //   'reports'.tr,
      //   Ionicons.md_document,
      //   () => Get.to(() => TabDocsView()),
      // ),
      //
      // _buildSettingsItem(
      //   'blood_donor'.tr,
      //   Ionicons.md_heart,
      //   () {},
      // ),
      //
      // _buildSettingsItem(
      //   'find_blood_donor'.tr,
      //   AntDesign.medicinebox,
      //   // () => Get.to(() => TabDocsView()),
      //   () {},
      // ),
      //
      // //
      // _buildSettingsItem(
      //   "logout".tr,
      //   Icons.logout,
      //   () =>
      //       AuthController.to.signOut().then((value) => Utils.whereShouldIGo()),
      // ),
    ];
  }

  Widget commonprofilemenu({Function()? onTap, String? title, String? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(icon!,
                    color: AppColors.primary, height: 21, width: 21),
                Spacer(),
                Text(
                  title ?? "",
                  style: AppTextStyle.boldPrimary14,
                ),
                Spacer(),
                Icon(
                  Icons.navigate_next_outlined,
                  color: AppColors.primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      {Color? color, VoidCallback? onTap, required IconData icon}) {
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
