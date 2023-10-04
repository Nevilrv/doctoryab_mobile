import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/shimmer/stories_shimmer.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_drugstore_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_hopistal_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_labs_view.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/modules/home/views/tab_home_doctors_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

import '../../../components/story_avatar.dart';
import '../../../data/ApiConsts.dart';

class TabHomeMainView extends GetView<TabHomeMainController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Background(
          isSecond: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildStroies(),
                  Container(),
                ],
              ),

              // SizedBox(height: 20),
              //HIDE Change city
              //TODO remove this after moved to other page
              // if (2 == 3)
              //   Container(
              //     // height: 50,
              //     // width: 140,
              //     // decoration: BoxDecoration(
              //     //     border: Border.all(color: AppColors.lgt),
              //     //     borderRadius: BorderRadius.circular(15)),
              //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //     child: Obx(
              //       () => OutlinedButton.icon(
              //         icon: Text(
              //           controller.selectedCity().getMultiLangName(),
              //           style: TextStyle(color: AppColors.lgt),
              //         ).paddingSymmetric(horizontal: 4, vertical: 10),
              //         onPressed: () {
              //           AppGetDialog.showSelctCityDialog(
              //               cityChangedCallBack: (City city) =>
              //                   controller.cityChanged(city));
              //         },
              //         label: Icon(
              //           Icons.arrow_drop_down,
              //           color: AppColors.lgt,
              //         ),
              //         style: OutlinedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           // side: BorderSide(width: 2,),
              //         ),
              //         // style: ButtonStyle(),
              //       ),
              //     ),
              //   ).paddingStart(context, 15).paddingOnly(top: 15, bottom: 8),
              Utils.searchBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: SizedBox(
                    child: TabBar(
                      labelPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      labelColor: Colors.white,
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
                        // Text("doctors".tr),
                        // Text("hospitals".tr),
                        // Text("drug_store".tr),
                        // Text("labratories".tr),
                        FittedBox(child: Text("doctors".tr), fit: BoxFit.cover),
                        FittedBox(child: Text("hospitals".tr)),
                        FittedBox(child: Text("drug_store".tr)),
                        FittedBox(child: Text("labratories".tr)),
                        // Text("doctors".tr),
                        // Text("doctors".tr),
                        // Text("doctors".tr),
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
              SizedBox(height: 8),
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
            ],
          ),
        ),
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
                              "${ApiConsts.hostUrl}${controller.dataList().data[index].img}",
                          isActive: true,
                          onTap: () {
                            // controller.resetStrories();
                            return controller.onTapStoryAvatar(
                                // controller.dataList.value.data[index],
                                index);
                          },
                        ),
                        Text(
                          "Serra",
                          style:
                              AppTextStyle.regularBlack8.copyWith(fontSize: 13),
                        )
                      ],
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dataList().data.length,
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
