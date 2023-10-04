import 'package:doctor_yab/app/components/shimmer/stories_shimmer.dart';
import 'package:doctor_yab/app/components/story_avatar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_main_controller.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/background.dart';
import '../../../theme/AppColors.dart';
import '../../../utils/app_text_styles.dart';
import '../controllers/messages_list_controller.dart';

class MessagesListView extends GetView<MessagesListController> {
  MessagesListView({Key key}) : super(key: key);

  TabHomeMainController tabHomeMainController =
      Get.put(TabHomeMainController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.white),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: AppTextStyle.boldPrimary20,
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
                children: [_buildStroies(tabHomeMainController)],
              ),
              Utils.searchBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStroies(TabHomeMainController storyContorller) {
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
