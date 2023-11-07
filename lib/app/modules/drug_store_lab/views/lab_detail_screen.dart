import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LabDetailScreen extends GetView<DrugStoreController> {
  Labs item;
  LabDetailScreen({
    Key key,
    this.item,
  }) : super(key: key);
// class HospitalNewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.specialAppBar("labratories".tr,
            backgroundColor: Colors.transparent,
            action: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(AppImages.blackBell),
            )),

        body: Stack(
          children: [
            ProfileViewNew(
              address: item.address,
              reviewTitle: "laboratories_reviews",
              photo: "${ApiConsts.hostUrl}${item.photo}",
              star: 4,
              geometry: item.geometry,
              name: item.name ?? "",
              phoneNumbers: item.phone[0],
              numberOfusersRated: 5,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                        border: Border.all(color: AppColors.primary)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                      child: Center(
                        child: Container(
                            width: w * 0.25,
                            child: Center(
                                child: Text(
                              "services_list".tr,
                              style: AppTextStyle.boldWhite10,
                            ))),
                      ),
                    ),
                  ),
                  Container(
                    height: h * 0.495,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 10),
                      child: item.checkUp.isEmpty
                          ? Center(
                              child: Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.2),
                              child: Text("no_result_found".tr),
                            ))
                          : Column(
                              children: [
                                ...List.generate(
                                    item.checkUp.length,
                                    (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${item.checkUp[index].title ?? ""}",
                                                    style: AppTextStyle
                                                        .boldPrimary12,
                                                  ),
                                                  Container(
                                                    width: Get.width * 0.6,
                                                    child: Text(
                                                      "${item.checkUp[index].content ?? ""}",
                                                      style: AppTextStyle
                                                          .boldPrimary11
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.primary,
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: Center(
                                                    child: Text(
                                                      "${item.checkUp[index].price} Afghani",
                                                      style: AppTextStyle
                                                          .boldWhite12,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                              ],
                            ),
                    ),
                  )

                  // TabBar(
                  //   controller: controller.tabController,
                  //   labelColor: AppColors.black2,
                  //   unselectedLabelColor: AppColors.lgt,
                  //   isScrollable: true,
                  //   tabs: [
                  //     Text("doctors".tr).paddingVertical(8),
                  //     Text("services_list".tr),
                  //     // Text("reviews".tr),
                  //     Text("about".tr),
                  //   ],
                  // )
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BottomBarView(
                  isHomeScreen: false,
                ))
          ],
        ),

        // body: ProfileViewNew(
        //   address: controller.hospital.address,
        //   photo: controller.hospital.photo,
        //   star: controller.hospital.stars,
        //   geometry: controller.hospital.geometry,
        //   name: controller.hospital.name,
        //   phoneNumbers: [controller.hospital.phone],
        //   numberOfusersRated: controller.hospital.usersStaredCount,
        //   child: TabMainView(),
        // ),
      ),
    );
  }
}
