import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/views/messages_list_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_blog_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_more_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_search_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_home_main_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
        body: TabBarView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          // physics: BouncingScrollPhysics(),
          children: <Widget>[
            TabHomeMainView(),
            TabSearchView(),
            MessagesListView(),
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
        bottomNavigationBar: Obx(
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
        ),
      ),
    );
  }
}
