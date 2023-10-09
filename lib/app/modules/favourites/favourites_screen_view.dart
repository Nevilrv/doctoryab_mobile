import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/shimmer/stories_shimmer.dart';
import 'package:doctor_yab/app/components/story_avatar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FavouritesScreenView extends GetView<TabHomeMainController> {
  FavouritesScreenView({Key key}) : super(key: key);

  final List<Map<String, dynamic>> gridData = [
    {
      "color": AppColors.lightOrange,
      "title": "drug_database",
      "image": AppImages.pills,
      "routes": Routes.DRUGS_DATABASE
    },
    {
      "color": AppColors.lightGreen,
      "title": "disease_treatment",
      "image": AppImages.bandage,
      "routes": Routes.DISEASE_TREATMENT
    },
    {
      "color": AppColors.lightRed,
      "title": "blood_donation",
      "image": AppImages.blood,
      "routes": Routes.BLOOD_DONATION
    },
    {
      "color": AppColors.lightBlue,
      "title": "treatment_abroad",
      "image": AppImages.airplane,
      "routes": Routes.TREATMENT_ABROAD
    },
    {
      "color": AppColors.lightBlue2,
      "title": "pregnancy_tracker",
      "image": AppImages.baby,
      "routes": Routes.PREGNANCY_TRACKER
    },
    {
      "color": AppColors.lightYellow,
      "title": "checkup_packages",
      "image": AppImages.microscope,
      "routes": Routes.CHECKUP_PACKAGES
    }
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Background(
        isSecond: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [_buildStories()],
            ),
            Utils.searchBox(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15).copyWith(bottom: 0),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          AppImages.backArrow,
                          height: 24,
                        ),
                        Text(
                          "navigation".tr,
                          style: AppTextStyle.boldPrimary14,
                        ),
                        SvgPicture.asset(
                          AppImages.closeCircle,
                          height: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GridView.builder(
                          itemCount: gridData.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 9,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(gridData[index]["routes"]);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 8)
                                    .copyWith(bottom: 0),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: h * 0.107,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: gridData[index]["color"],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          gridData[index]["image"],
                                          height: 63,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Center(
                                          child: Text(
                                            gridData[index]["title"]
                                                .toString()
                                                .tr,
                                            style: AppTextStyle.boldBlack13
                                                .copyWith(height: 1.2),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridShimmer(double height, double width) {
    return Shimmer.fromColors(
      period: Duration(seconds: 1),
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: () {
          var _tmpList = <Widget>[];
          for (int i = 0; i < 3; i++) {
            var _rowChilds = <Widget>[];
            for (int j = 0; j < 2; j++) {
              _rowChilds.add(
                Container(
                  height: height * 0.164,
                  width: width * 0.350,
                  color: Colors.white,
                ).radiusAll(5).paddingAll(4),
              );
            }
            _tmpList.add(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: _rowChilds,
              ),
            );
          }
          return _tmpList;
        }(),
      ),
    );
  }

  Widget _buildStories() {
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
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) => StoryAvatar(
                      assetPath:
                          "${ApiConsts.hostUrl}${controller.dataList().data[index].img}",
                      isActive: true,
                      onTap: () {
                        return controller.onTapStoryAvatar(index);
                      },
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dataList().data.length,
                  ),
          ),
        ),
      ),
    );
  }
}

/// PAGED GRIDVIEW
// Expanded(
//   child: PagedGridView(
//     pagingController: controller.pagingController,
//     physics: BouncingScrollPhysics(),
//     gridDelegate:
//         SliverGridDelegateWithFixedCrossAxisCount(
//       childAspectRatio: 132 / 169,
//       crossAxisCount:
//           MediaQuery.of(context).size.width < 300
//               ? 1
//               : MediaQuery.of(context).size.width > 600
//                   ? 3
//                   : 2,
//     ),
//     builderDelegate: PagedChildBuilderDelegate<Category>(
//       itemBuilder: (BuildContext context, item, int i) {
//         return Container(
//           height: height * 0.164,
//           width: width * 0.350,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AspectRatio(
//                 aspectRatio: 1,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(5),
//                     color: Utils.hexToColor(
//                       item.background,
//                       defaultColorIfInvalid:
//                           AppColors.disabledButtonColor,
//                     ).withOpacity(1),
//                   ),
//                   child: Center(
//                     child: SizedBox(
//                       height: 65,
//                       // width: 20,
//                       child: Container(),
//                     ),
//                   ),
//                 ),
//               ),
//               // Spacer(),
//               Expanded(
//                 child: Center(
//                   child: FittedBox(
//                     child: AutoSizeText(
//                       item.title,
//                       maxLines: 2,
//                       minFontSize: 10,
//                       maxFontSize: 12,
//                       style: TextStyle(
//                           color: AppColors.lightBlack),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//               ),
//               // Spacer(),
//             ],
//           ),
//         );
//       },
//       noItemsFoundIndicatorBuilder: (_) =>
//           PagingNoItemFountList(),
//       firstPageErrorIndicatorBuilder: (context) =>
//           PagingErrorView(
//         controller: controller.pagingController,
//       ),
//       firstPageProgressIndicatorBuilder: (_) =>
//           gridShimmer(height, width),
//       newPageProgressIndicatorBuilder: (_) => CityShimmer(
//         linesCount: 2,
//       ),
//     ),
//   ),
// ),
