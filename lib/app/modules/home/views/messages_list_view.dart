import 'package:auto_size_text/auto_size_text.dart';
import 'package:doctor_yab/app/components/shimmer/city_shimmer.dart';
import 'package:doctor_yab/app/components/shimmer/stories_shimmer.dart';
import 'package:doctor_yab/app/components/story_avatar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/background.dart';
import '../../../components/category_item.dart';
import '../../../components/paging_indicators/no_item_list.dart';
import '../../../components/paging_indicators/paging_error_view.dart';
import '../../../components/shimmer/categories_grid_shimmer.dart';
import '../../../controllers/booking_controller.dart';
import '../../../data/models/categories_model.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/AppColors.dart';
import '../../../utils/app_text_styles.dart';
import '../controllers/messages_list_controller.dart';

class MessagesListView extends GetView<MessagesListController> {
  MessagesListView({Key key}) : super(key: key);

  TabHomeMainController tabHomeMainController =
      Get.put(TabHomeMainController());

  List<Map<String, dynamic>> gridData = [
    {"color": "", "title": "Drug Database", "image": AppImages.pills},
    {"color": "", "title": "Disease and Treatment", "image": AppImages.bandage},
    {"color": "", "title": "Blood Donation", "image": AppImages.blood},
    {"color": "", "title": "Treatment Abroad", "image": AppImages.airplane},
    {"color": "", "title": "Pregnancy Tracker", "image": AppImages.baby},
    {"color": "", "title": "Checkup Packages", "image": AppImages.microscope}
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.white),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: AppTextStyle.semiBoldPrimary20,
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
            actionsIconTheme: IconThemeData(
              color: AppColors.primary,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      child: Background(
        isSecond: false,
        child: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [_buildStories(tabHomeMainController)],
              ),
              Utils.searchBox(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 28),
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
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
                            "Navigation",
                            style: AppTextStyle.semiBoldPrimary14,
                          ),
                          SvgPicture.asset(
                            AppImages.closeCircle,
                            height: 24,
                          ),
                        ],
                      ),
                      SizedBox(height: 23),
                      Expanded(
                        child: PagedGridView(
                          pagingController: controller.pagingController,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 132 / 169,
                            crossAxisCount:
                                MediaQuery.of(context).size.width < 300
                                    ? 1
                                    : MediaQuery.of(context).size.width > 600
                                        ? 3
                                        : 2,
                          ),
                          builderDelegate: PagedChildBuilderDelegate<Category>(
                            itemBuilder: (BuildContext context, item, int i) {
                              return Container(
                                height: height * 0.164,
                                width: width * 0.350,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Utils.hexToColor(
                                            item.background,
                                            defaultColorIfInvalid:
                                                AppColors.disabledButtonColor,
                                          ).withOpacity(1),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            height: 65,
                                            // width: 20,
                                            child: Container(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                    Expanded(
                                      child: Center(
                                        child: FittedBox(
                                          child: AutoSizeText(
                                            item.title,
                                            maxLines: 2,
                                            minFontSize: 10,
                                            maxFontSize: 12,
                                            style: TextStyle(
                                                color: AppColors.lightBlack),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                  ],
                                ),
                              );
                            },
                            noItemsFoundIndicatorBuilder: (_) =>
                                PagingNoItemFountList(),
                            firstPageErrorIndicatorBuilder: (context) =>
                                PagingErrorView(
                              controller: controller.pagingController,
                            ),
                            firstPageProgressIndicatorBuilder: (_) =>
                                gridShimmer(height, width),
                            newPageProgressIndicatorBuilder: (_) => CityShimmer(
                              linesCount: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildStories(TabHomeMainController storyContorller) {
    return Flexible(
      child: Obx(
        () => SizedBox(
          height: 90,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: storyContorller.dataList.value == null
                ? StoriesShimmer().paddingVertical(8)
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) => StoryAvatar(
                      assetPath:
                          "${ApiConsts.hostUrl}${storyContorller.dataList().data[index].img}",
                      isActive: true,
                      onTap: () {
                        // controller.resetStrories();
                        return storyContorller.onTapStoryAvatar(
                            // controller.dataList.value.data[index],
                            index);
                      },
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: storyContorller.dataList().data.length,
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
