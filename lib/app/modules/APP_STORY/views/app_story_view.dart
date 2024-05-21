import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../utils/utils.dart';
import '../controllers/app_story_controller.dart';

class AppStoryView extends GetView<AppStoryController> {
  const AppStoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,

      ///TODO make this compatible to RTL
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            StoryView(
              controller: controller.storyC!,
              progressPosition: ProgressPosition.top,
              onComplete: () => Get.back(),
              storyItems: [
                // StoryItem.inlineProviderImage(
                //   CachedNetworkImageProvider(
                //     Utils.getFullPathOfAssets(controller.story.img),
                //   ),
                // ),

                ...controller.stories.data!
                    .map(
                      (e) => StoryItem.inlineProviderImage(
                        CachedNetworkImageProvider(
                          Utils.getFullPathOfAssets(e.img!),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
            Positioned(
              top: kToolbarHeight * 1.2,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Container(
                    //   height: 42,
                    //   width: 42,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.white,
                    //     image: DecorationImage(
                    //       image: CachedNetworkImageProvider(
                    //         Utils.getFullPathOfAssets(controller.story.img),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Text(
                    //   'doctorserra',
                    //   // style: AppTextStyle.boldWhite16
                    //   //     .copyWith(fontWeight: FontWeight.w700),
                    // ),
                    // const SizedBox(
                    //   width: 8,
                    // ),
                    // Text(
                    //   '3h',
                    //   // style: AppTextStyle.regularWhite12,
                    // ),
                    // const Spacer(),
                    // IconButton(
                    //     onPressed: () => Get.back(),
                    //     icon: Icon(
                    //       Icons.close,
                    //       color: AppColors.primary,
                    //     )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
