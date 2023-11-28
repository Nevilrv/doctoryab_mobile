import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/favourites/favourites_screen_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/views/messages_list_view.dart';
import 'package:doctor_yab/app/modules/home/views/blog/tab_blog_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_home_main_view.dart';
import 'package:doctor_yab/app/modules/home/views/profile/tab_more_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var data = Get.arguments;

  List bottomBarItem = [
    AppImages.home,
    AppImages.message,
    AppImages.heart,
    AppImages.enquiry,
    AppImages.profile
  ];
  @override
  Widget build(BuildContext context) {
    log("SettingsController.savedUserProfile.sId-SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.id}");
    log("SettingsController.savedUserProfile.userToken--------------> ${SettingsController.userToken}");

    return WillPopScope(
      onWillPop: () async {
        // return controller.pageController.index == 3
        //     ? controller.webViewController.canGoBack()
        //     : true;

        if (controller.pageController.index == 3 &&
            await controller.webViewController.canGoBack()) {
          controller.webViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.primary,
          elevation: 0,
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(),
              // physics: BouncingScrollPhysics(),
              children: <Widget>[
                TabHomeMainView(),
                MessagesListView(),
                // TabSearchView(),
                FavouritesScreenView(),
                TabBlogView(),

                // TabMyDoctorsView(),
                // DoctorsView(
                //   action: DOCTORS_LOAD_ACTION.myDoctors,
                // ),
                // TabDocsView(),
                TabMoreView(),
                // ProfileUpdateView(
                //     // height: AppThemeConsts.getWindowHeightInSafeArea(context)
                //     )
              ],
            ),
            Positioned(bottom: 20, left: 20, right: 20, child: BottomBarView())
          ],
        ),

        // PageView(
        //   onPageChanged: (index) {
        //     Timer(Duration(milliseconds: 1), () {
        //       print(index);
        //       controller.selectedIndex.value = index;
        //     });
        //   },
        //   children: controller.screens,
        //   controller: controller.pageController,
        // ),
        /* Obx(
          () => BottomNavigationBar(
            iconSize: 22,
            elevation: 0,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            type: BottomNavigationBarType.shifting,
            currentIndex: controller.selectedIndex.value,
            backgroundColor: AppColors.primary,
            onTap: (index) {
              controller.selectedIndex.value = index;
              controller.pageController.animateTo(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            items: [
              BottomNavigationBarItem(
                  icon:
                      // Tab(
                      //   icon:
                      Icon(AntDesign.home).paddingAll(4),
                  // ),
                  // Icon(Icons.home),
                  label: 'home_page'.tr,
                  backgroundColor: AppColors.primary),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.search1).paddingAll(4),
                label: 'search'.tr,
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.message1).paddingAll(4),
                label: 'chat'.tr,
                backgroundColor: AppColors.primary,
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(FontAwesome.stethoscope),
              //   label: 'my_doctors'.tr,
              //   backgroundColor: AppColors.primary,
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Ionicons.md_document),
              //   label: 'reports'.tr,
              //   backgroundColor: AppColors.primary,
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper).paddingAll(4),
                label: 'blog'.tr,
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(SimpleLineIcons.menu).paddingAll(4),
                label: 'more'.tr,
                backgroundColor: AppColors.primary,
              ),
            ],
          ).radiusAll(15).paddingExceptTop(16).paddingOnly(top: 8),
        )*/
      ),
    );
  }
}

class BottomBarView extends StatelessWidget {
  bool isHomeScreen = true;
  bool isBlueBottomBar = false;
  bool isBlueBackground = false;

  BottomBarView(
      {Key key, this.isHomeScreen, this.isBlueBackground, this.isBlueBottomBar})
      : super(key: key);
  List bottomBarItem = [
    AppImages.home,
    AppImages.message,
    AppImages.heart,
    AppImages.enquiry,
    AppImages.profile
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return isBlueBackground == true
            ? Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(bottomBarItem.length, (index) {
                      return index == 2
                          ? GestureDetector(
                              onTap: () {
                                log("isHomeScreen--------------> ${isHomeScreen}");
                                if (isHomeScreen == false) {
                                  Get.offAllNamed(Routes.HOME,
                                      arguments: {'id': index});
                                }
                                controller.setIndex(index);
                                controller.selectedIndex = index;

                                controller.pageController.animateTo(index,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: Container(
                                height: 65,
                                width: 65,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    SizedBox(),
                                    Positioned(
                                      bottom: 15,
                                      child: Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  bottomBarItem[index],
                                                  color: AppColors.white,
                                                  height: 30,
                                                  width: 30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                log("isHomeScreen--------------> ${isHomeScreen}");
                                log("index--------------> ${index}");
                                if (isHomeScreen == false) {
                                  log("isHomeScreen--------------> ${isHomeScreen}");

                                  Get.offAllNamed(Routes.HOME,
                                      arguments: {'id': index});
                                }

                                controller.setIndex(index);
                                controller.selectedIndex = index;
                                controller.pageController.animateTo(index,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: Container(
                                height: 60,
                                width: Get.width * 0.1,
                                color: AppColors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      bottomBarItem[index],
                                      height: 24,
                                      width: 24,
                                      color: controller.selectedIndex == index
                                          ? AppColors.primary
                                          : AppColors.primaryLight,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.selectedIndex == index
                                        ? CircleAvatar(
                                            radius: 2,
                                            backgroundColor:
                                                controller.selectedIndex ==
                                                        index
                                                    ? AppColors.primary
                                                    : AppColors.primary,
                                          )
                                        : SizedBox(
                                            height: 4,
                                          ),
                                    SizedBox(
                                      height: 9,
                                    )
                                  ],
                                ),
                              ),
                            );
                    }),
                  ),
                ))
            : isBlueBottomBar == true
                ? Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(bottomBarItem.length, (index) {
                          return index == 2
                              ? GestureDetector(
                                  onTap: () {
                                    log("isHomeScreen--------------> ${isHomeScreen}");
                                    if (isHomeScreen == false) {
                                      Get.offAllNamed(Routes.HOME,
                                          arguments: {'id': index});
                                    }
                                    controller.setIndex(index);
                                    controller.selectedIndex = index;

                                    controller.pageController.animateTo(index,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        SizedBox(),
                                        Positioned(
                                          bottom: 15,
                                          child: Container(
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Container(
                                                height: 55,
                                                width: 55,
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      bottomBarItem[index],
                                                      color: AppColors.primary,
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    log("isHomeScreen--------------> ${isHomeScreen}");
                                    log("index--------------> ${index}");
                                    if (isHomeScreen == false) {
                                      log("isHomeScreen--------------> ${isHomeScreen}");

                                      Get.offAllNamed(Routes.HOME,
                                          arguments: {'id': index});
                                    }

                                    controller.setIndex(index);
                                    controller.selectedIndex = index;
                                    controller.pageController.animateTo(index,
                                        duration: Duration(milliseconds: 10),
                                        curve: Curves.ease);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: Get.width * 0.1,
                                    // height: 60,
                                    // color: AppColors.red,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          bottomBarItem[index],
                                          height: 24,
                                          width: 24,
                                          color:
                                              controller.selectedIndex == index
                                                  ? AppColors.white
                                                  : AppColors.primaryLight,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        controller.selectedIndex == index
                                            ? CircleAvatar(
                                                radius: 2,
                                                backgroundColor:
                                                    controller.selectedIndex ==
                                                            index
                                                        ? AppColors.white
                                                        : AppColors.primary,
                                              )
                                            : SizedBox(
                                                height: 4,
                                              ),
                                        SizedBox(
                                          height: 9,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ))
                : Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: controller.selectedIndex == 4
                            ? AppColors.white
                            : AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(bottomBarItem.length, (index) {
                          return index == 2
                              ? GestureDetector(
                                  onTap: () {
                                    log("isHomeScreen--------------> ${isHomeScreen}");
                                    if (isHomeScreen == false) {
                                      Get.offAllNamed(Routes.HOME,
                                          arguments: {'id': index});
                                    }
                                    controller.setIndex(index);
                                    controller.selectedIndex = index;

                                    controller.pageController.animateTo(index,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        SizedBox(),
                                        Positioned(
                                          bottom: 15,
                                          child: Container(
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color:
                                                    controller.selectedIndex ==
                                                            4
                                                        ? AppColors.white
                                                        : AppColors.primary,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Container(
                                                height: 55,
                                                width: 55,
                                                decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedIndex ==
                                                            4
                                                        ? AppColors.primary
                                                        : AppColors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      bottomBarItem[index],
                                                      color: controller
                                                                  .selectedIndex ==
                                                              4
                                                          ? AppColors.white
                                                          : AppColors.primary,
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    log("isHomeScreen--------------> ${isHomeScreen}");
                                    log("index--------------> ${index}");
                                    if (isHomeScreen == false) {
                                      log("isHomeScreen--------------> ${isHomeScreen}");

                                      Get.offAllNamed(Routes.HOME,
                                          arguments: {'id': index});
                                    }

                                    controller.setIndex(index);
                                    controller.selectedIndex = index;
                                    controller.pageController.animateTo(index,
                                        duration: Duration(milliseconds: 10),
                                        curve: Curves.ease);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: Get.width * 0.1,
                                    // color: AppColors.red,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          bottomBarItem[index],
                                          height: 24,
                                          width: 24,
                                          color: controller.selectedIndex ==
                                                  index
                                              ? controller.selectedIndex == 4
                                                  ? AppColors.primary
                                                  : AppColors.white
                                              : AppColors.primaryLight,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        controller.selectedIndex == index
                                            ? CircleAvatar(
                                                radius: 2,
                                                backgroundColor: controller
                                                            .selectedIndex ==
                                                        index
                                                    ? controller.selectedIndex ==
                                                            4
                                                        ? AppColors.primary
                                                        : AppColors.white
                                                    : AppColors.primary,
                                              )
                                            : SizedBox(
                                                height: 4,
                                              ),
                                        SizedBox(
                                          height: 9,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ));
      },
    );
  }
}
