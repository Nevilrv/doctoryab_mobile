import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/shimmer/stories_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_drugstore_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_hopistal_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_labs_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_home_doctors_view.dart';
import 'package:doctor_yab/app/modules/notification/controllers/notification_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/story_avatar.dart';
import '../../../data/ApiConsts.dart';

class TabHomeMainView extends GetView<TabHomeMainController> {
  TabHomeMainController tabHomeMainController =
      Get.put(TabHomeMainController());
  NotificationController notificationController =
      Get.put(NotificationController())..loadNotification();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 4,
      child: Builder(builder: (context) {
        DefaultTabController.of(context).addListener(() {
          int currentIndex = DefaultTabController.of(context).index;
          if (currentIndex == 0) {
            controller.isHomeScreen.value = true;
          } else {
            controller.isHomeScreen.value = false;
          }
        });

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            return Background(
              isSecond: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.015,
                  ),
                  controller.isHomeScreen.value == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _buildStroies(),
                                Container(),
                              ],
                            ),
                            searchBox(),
                          ],
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: SizedBox(
                        child: TabBar(
                          labelPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          labelColor: Colors.white,
                          onTap: (value) {
                            if (value == 0) {
                              controller.isHomeScreen.value = true;
                            } else {
                              controller.isHomeScreen.value = false;
                            }
                          },
                          unselectedLabelColor: AppColors.black,
                          labelStyle: AppTextStyle.regularWhite12
                              .copyWith(fontWeight: FontWeight.w500),
                          unselectedLabelStyle: AppTextStyle.mediumBlack12
                              .copyWith(fontWeight: FontWeight.w500),
                          indicator: BoxDecoration(
                            color: Get.theme.primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tabs: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text("doctors".tr),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("hospitals".tr)),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text("drug_store".tr)),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Text("labratories".tr)),
                          ],
                        ) /*.size(
                          width: MediaQuery.of(context).size.width > 600 ? 500 : 324,
                        )*/
                        ,
                      )
                          .paddingSymmetric(horizontal: 10, vertical: 8)
                          .bgColor(Colors.white)
                          .radiusAll(30)
                          // .paddingAll(2)
                          .basicShadow(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        TabHomeDoctorsView(),
                        TabHomeHospitalsView(),
                        TabHomeDrugstoreView(),
                        TabHomeLabsView(),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 80,
                  //   color: AppColors.lightGrey,
                  // ),
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  Container searchBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      padding: EdgeInsets.only(top: 13, bottom: 22, left: 17, right: 17),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"hi".tr}, ${SettingsController.savedUserProfile?.name ?? ""}!",
                    style: AppTextStyle.mediumWhite11.copyWith(fontSize: 13),
                  ),
                  Text(
                    "how_do_you_feel_today".tr,
                    style: AppTextStyle.mediumWhite11.copyWith(
                        color: AppColors.white.withOpacity(0.5), fontSize: 13),
                  ),
                ],
              ),
              Spacer(),
              Stack(
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
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.searchDoctor,
            style: AppTextStyle.mediumWhite11.copyWith(fontSize: 13),
            cursorColor: AppColors.white,
            readOnly: true,
            onTap: () {
              Get.toNamed(Routes.SEARCH_DOCTOR);
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              hintText: "search_doctor".tr,
              hintStyle: AppTextStyle.mediumWhite11.copyWith(fontSize: 13),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(11),
                child: SvgPicture.asset(AppImages.search),
              ),
              filled: true,
              fillColor: AppColors.white.withOpacity(0.1),
              constraints: BoxConstraints(maxHeight: 38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStroies() {
    return Flexible(
      child: Obx(
        () => SizedBox(
          height: 90,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: controller.dataList.value == null
                ? StoriesShimmer().paddingVertical(8)
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StoryAvatar(
                          assetPath:
                              "${ApiConsts.hostUrl}${controller.dataList()?.data?[index].img}",
                          isActive: true,
                          onTap: () {
                            // controller.resetStrories();
                            return controller.onTapStoryAvatar(
                                // controller.dataList.value.data[index],
                                index);
                          },
                        ),
                      ],
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dataList()!.data!.length,
                  ),
            // : Stories(
            //     displayProgress: true,
            //     showStoryName: false,
            //     showStoryNameOnFullPage: false,
            //     showThumbnailOnFullPage: false,
            //     autoPlayDuration: Duration(seconds: 5),
            //     storyItemList: [
            //         // First group of stories
            //         StoryItem(
            //             name: "",
            //             thumbnail: NetworkImage(
            //               "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
            //             ),
            //             stories: [
            //               // First story
            //               Scaffold(
            //                 body: Container(
            //                   decoration: BoxDecoration(
            //                     image: DecorationImage(
            //                       fit: BoxFit.cover,
            //                       image: NetworkImage(
            //                         "https://wallpaperaccess.com/full/16568.png",
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               // Second story in first group
            //             ]),
            //         // Second story group
            //         StoryItem(
            //           name: "",
            //           thumbnail: NetworkImage(
            //             "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
            //           ),
            //           stories: [
            //             Scaffold(
            //               body: Center(
            //                 child: Text(
            //                   "That's it, Folks !",
            //                   style: TextStyle(
            //                     color: Color(0xff777777),
            //                     fontSize: 25,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ]),
          ),
        ),
      ),
    );
  }
}
