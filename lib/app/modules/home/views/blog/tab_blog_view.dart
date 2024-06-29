import 'dart:convert';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_blog_controller.dart';
import 'package:doctor_yab/app/modules/home/views/blog/comment_blog_screen.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'blog_details_screen.dart';

/// NEW Blog View

class TabBlogView extends StatefulWidget {
  const TabBlogView({super.key});

  @override
  State<TabBlogView> createState() => _TabBlogViewState();
}

class _TabBlogViewState extends State<TabBlogView> {
  TabBlogController tabBlogController = Get.put(TabBlogController());

  @override
  void initState() {
    if (Get.arguments != null) {
      if (Get.arguments['id'] != null) {
        if (Get.arguments['id'] == "notification") {
          tabBlogController.isBottom = true;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.boxPurple2.withOpacity(0.1),
      body: GetBuilder<TabBlogController>(
          init: TabBlogController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primary,
                  child: Center(
                    child: Text(
                      'medical_blog'.tr,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: w,
                  height: Get.height * 0.12,
                  child: ListView.builder(
                    itemCount: controller.tabTitles.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        height: Get.height * 0.6,
                        width: Get.width * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  controller.selected.value = index;
                                  controller.update();
                                  controller.pagingController = PagingController<int, Post>(firstPageKey: 1);
                                  controller.changeSelectedCategory(index);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height * 0.06,
                                      width: Get.height * 0.07,
                                      // width: 50,
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: controller.selected.value == index ? Color(0xff72D6FE) : AppColors.white,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Center(
                                        child: Image.network(
                                          '${ApiConsts.hostUrl}${controller.tabTitles[index].photo}',
                                          height: Get.height * 0.07,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.008),
                                    Container(
                                      height: Get.height * 0.025,
                                      width: Get.height * 0.07,
                                      padding: EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                          color: controller.selected.value == index ? Color(0xff72D6FE) : AppColors.white,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          SettingsController.appLanguge == 'English'
                                              ? '${controller.tabTitles[index].categoryEnglish}'
                                              : SettingsController.appLanguge == 'پشتو'
                                                  ? '${controller.tabTitles[index].categoryPashto}'
                                                  : '${controller.tabTitles[index].categoryDari}',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Container(
                              height: 8,
                              width: MediaQuery.of(context).size.width * 0.42,
                              // margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(top: 1.5, bottom: 1.5, left: 1.5, right: 1.5),
                              color: AppColors.primary,
                              child: controller.selected.value == index
                                  ? Container(
                                      color: AppColors.white,
                                    )
                                  : Container(
                                      color: AppColors.primary,
                                    ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: h * 0.72,
                  child: PagedListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (c, i) {
                      if ((i + 1) % 5 == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Stack(
                            children: [
                              Container(
                                child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      height: Get.height * 0.2,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      onPageChanged: (index, reason) {
                                        controller.adIndex = index;
                                        controller.update();
                                      },
                                    ),
                                    items: controller.adList
                                        .map((item) => GestureDetector(
                                              onTap: () async {
                                                if (!await launchUrl(Uri.parse(item.link!))) {
                                                  throw Exception('Could not launch ${item.link}');
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                                      // margin: EdgeInsets.all(5.0),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                        child: Image.network(
                                                          "${ApiConsts.hostUrl}${item.img}",
                                                          fit: BoxFit.cover,
                                                          width: 1000.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    right: SettingsController.appLanguge != "English" ? null : 10,
                                                    left: SettingsController.appLanguge == "English" ? null : 10,
                                                    child: SettingsController.appLanguge != "English"
                                                        ? Transform(
                                                            alignment: Alignment.center,
                                                            transform: Matrix4.rotationY(math.pi),
                                                            child: Image.asset(
                                                              AppImages.promote,
                                                              height: 18,
                                                              width: 18,
                                                              color: AppColors.white,
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            AppImages.promote,
                                                            height: 18,
                                                            width: 18,
                                                            color: AppColors.white,
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList()),
                              ),
                              Positioned(
                                bottom: Get.height * 0.017,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      controller.adList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              controller.adIndex == index ? AppColors.primary : AppColors.primary.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(height: 15);
                      }
                    },
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Post>(
                      itemBuilder: (context, item, index) {
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                // height: h * 0.2,
                                width: w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 5),
                                    //   child: CircleAvatar(
                                    //     radius: 25,
                                    //     backgroundImage: NetworkImage(
                                    //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
                                    //     ),
                                    //     onBackgroundImageError:
                                    //         (exception, stackTrace) {
                                    //       return Image.asset(
                                    //         "assets/png/person-placeholder.jpg",
                                    //         fit: BoxFit.cover,
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  BlogDetailsScreen(
                                                    post: controller.postList[index],
                                                    index: index,
                                                  ),
                                                );
                                                // controller.showDescription(index);
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      SettingsController.appLanguge == 'English'
                                                          ? "${controller.postList[index].blogTitleEnglish}"
                                                          : SettingsController.appLanguge == 'پشتو'
                                                              ? "${controller.postList[index].blogTitlePashto}"
                                                              : '${controller.postList[index].blogTitleDari}',
                                                      style: AppTextTheme.h(14).copyWith(
                                                        color: AppColors.primary,
                                                      ),
                                                      // maxLines: 1,
                                                    ),
                                                  ),
                                                  //  controller.postList[index]
                                                  //              .isPublished ==
                                                  //          true
                                                  //      ? SvgPicture.asset(
                                                  //         AppImages.check,
                                                  //      )
                                                  //   : SizedBox()
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // color: AppColors.red,
                                                  child: Flexible(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                          BlogDetailsScreen(
                                                            post: controller.postList[index],
                                                            index: index,
                                                          ),
                                                        );
                                                      },
                                                      child: Text("${controller.postList[index].name}",
                                                          style: AppTextTheme.h(11)
                                                              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w400)
                                                          // maxLines: 1,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                                Icon(
                                                  Icons.circle,
                                                  size: 3,
                                                  color: AppColors.primary,
                                                ),
                                                SizedBox(width: 3),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "${calculateTime(DateTime.parse(controller.postList[index].createAt.toString()))} ",
                                                        // maxLines: 1,
                                                        // overflow:
                                                        // TextOverflow.clip,
                                                        style: AppTextTheme.h(11).copyWith(
                                                          color: AppColors.primary,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    // Icon(
                                                    //   Icons.circle,
                                                    //   size: 3,
                                                    //   color: AppColors.primary,
                                                    // )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Get.to(BlogDetailsScreen(
                                  post: controller.postList[index],
                                  index: index,
                                ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: AspectRatio(
                                  //width: w * 0.7,
                                  //height: h * 0.33,
                                  aspectRatio: 1024 / 500,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${ApiConsts.hostUrl}${controller.postList[index].img}",
                                        ),
                                        fit: BoxFit.cover,
                                        // onError: (exception, stackTrace) {
                                        //   log('================== ON ERROR CALLED ==================');
                                        //   return Image.asset(
                                        //     "assets/png/person-placeholder.jpg",
                                        //     fit: BoxFit.cover,
                                        //   );
                                        // },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 5),
                            //   child: CircleAvatar(
                            //     radius: h * 0.1,
                            //     backgroundImage: NetworkImage(
                            //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
                            //     ),
                            //     onBackgroundImageError:
                            //         (exception, stackTrace) {
                            //       return Image.asset(
                            //         "assets/png/person-placeholder.jpg",
                            //         fit: BoxFit.cover,
                            //       );
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 10),

                            controller.showDesc == index
                                ? HtmlWidget(
                                    controller.postList[index].descEnglish ?? "",
                                    // customTextAlign: (_) =>
                                    //     SettingsController.appLanguge == "English"
                                    //         ? TextAlign.left
                                    //         : TextAlign.right,
                                    // textStyle: TextStyle(
                                    //   textAlign:
                                    //   SettingsController.appLanguge ==
                                    //       "English"
                                    //       ? TextAlign.left
                                    //       : TextAlign.right,
                                    // ),
                                    // onImageError: (exception, stackTrace) {
                                    //   return Image.network(
                                    //       "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                                    // },
                                  )

                                // controller.postList[index].desc.length < 10
                                //     ?

                                /// Old Package ********************
                                // Html(
                                //         data: controller.postList[index].descEnglish,
                                //         // customTextAlign: (_) =>
                                //         //     SettingsController.appLanguge == "English"
                                //         //         ? TextAlign.left
                                //         //         : TextAlign.right,
                                //         style: {
                                //           'html': Style(
                                //             textAlign:
                                //                 SettingsController.appLanguge ==
                                //                         "English"
                                //                     ? TextAlign.left
                                //                     : TextAlign.right,
                                //           ),
                                //         },
                                //         // onImageError: (exception, stackTrace) {
                                //         //   return Image.network(
                                //         //       "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                                //         // },
                                //       )

                                ///  **********************
                                // ShowMoreLessHTML(
                                //         htmlContent: controller.postList[index]
                                //             .desc, // Replace with your HTML content
                                //         maxLines:
                                //             1, // Specify the number of lines to display initially
                                //       ),
                                : SizedBox(),

                            // ReadMoreText(
                            //   parse(controller.postList[index].desc).body.text,
                            //   numLines: 5,
                            //   readMoreText: "...see more",
                            //   readLessText: '  see less',
                            // ),
                            // Html(
                            //   data: controller.postList[index].desc,
                            //   onImageError: (exception, stackTrace) {
                            //     return Image.network(
                            //         "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                            //   },
                            // ),

                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.like1,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        controller.postList[index].likes!.length.toString(),
                                        style: AppTextTheme.h(14)
                                            .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${controller.postList[index].comments!.length.toString()} ",
                                        style: AppTextTheme.h(14)
                                            .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "comment".tr,
                                        style: AppTextTheme.h(14)
                                            .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.circle,
                                        size: 5,
                                        color: AppColors.primary.withOpacity(0.7),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${controller.postList[index].shares!.length.toString()} ",
                                        style: AppTextTheme.h(14)
                                            .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "shares".tr,
                                        style: AppTextTheme.h(14)
                                            .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.primary.withOpacity(0.7),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.postList[index].likes!.contains(SettingsController.userId.toString())) {
                                              controller.postList[index].likes?.remove(SettingsController.userId);
                                            } else {
                                              controller.postList[index].likes?.add(SettingsController.userId);
                                            }

                                            controller.update();
                                            controller.likeBlog(controller.postList[index].id!, index, controller.postList[index]);
                                          },
                                          child: Row(
                                            children: [
                                              controller.postList[index].likes!.contains(SettingsController.userId.toString())
                                                  ? SvgPicture.asset(
                                                      AppImages.likeFill,
                                                      width: 20,
                                                      height: 20,
                                                      color: AppColors.primary.withOpacity(0.7),
                                                    )
                                                  : SvgPicture.asset(
                                                      AppImages.like2,
                                                      width: 20,
                                                      height: 20,
                                                      color: AppColors.primary.withOpacity(0.7),
                                                    ),
                                              SizedBox(width: 5),
                                              Text(
                                                "like".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              CommentView(index),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.comment,
                                                width: 24,
                                                height: 24,
                                                color: AppColors.primary.withOpacity(0.7),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "comment".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            final result = await Share.shareWithResult(SettingsController.appLanguge == 'English'
                                                ? parse(controller.postList[index].descEnglish).body!.text
                                                : SettingsController.appLanguge == 'پشتو'
                                                    ? parse(controller.postList[index].descPashto).body!.text
                                                    : parse(controller.postList[index].descDari).body!.text);
                                            if (result.status == ShareResultStatus.success) {
                                              controller.postList[index].shares!.add(SettingsController.userId);
                                              controller.update();
                                              controller.shareBlog(controller.postList[index].id!, index, controller.postList[index]);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.share,
                                                width: 24,
                                                height: 24,
                                                color: AppColors.primary.withOpacity(0.7),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "share".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.primary.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
                      noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
                      firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                        controller: controller.pagingController,
                      ),
                    ),
                    // itemBuilder: (context, index) {
                    //   return ListTile(
                    //     title: Text(controller.postsList[index].blogTitle),
                    //     subtitle: Text(controller.postsList[index].desc),
                    //   );
                    // },
                  ),
                ),
              ],
            );
          }),
    );
  }

  static String calculateTime(DateTime time) {
    Duration compare(DateTime x, DateTime y) {
      return Duration(microseconds: (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());
    }

    DateTime x = DateTime.now();
    DateTime y = time;

    Duration diff = compare(x, y);
    int days = diff.inDays;
    int hours = diff.inHours;
    int minutes = diff.inMinutes;

    String result = '';
    if (days > 365) {
      result = '${(days / 365).floor().toString()}y ago';
    } else if (days > 30) {
      result = '${(days / 30).floor().toString()}m ago';
    } else if (days > 7) {
      result = '${(days / 7).floor().toString()}w ago';
    } else if (days > 1) {
      result = '${(days / 1).floor().toString()}d ago';
    } else if (hours > 1) {
      result = '${hours}h ago';
    } else if (minutes > 1) {
      result = '${minutes}m ago';
    } else {
      result = 'Now';
    }

    return result;
  }
}

class ShowMoreLessHTML extends StatefulWidget {
  final String? htmlContent;
  final int maxLines;

  ShowMoreLessHTML({this.htmlContent, this.maxLines = 1});

  @override
  _ShowMoreLessHTMLState createState() => _ShowMoreLessHTMLState();
}

class _ShowMoreLessHTMLState extends State<ShowMoreLessHTML> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HtmlWidget(
          isExpanded ? widget.htmlContent ?? "" : _getTruncatedHtmlContent(),
          // customTextAlign: (_) => SettingsController.appLanguge == "English"
          //     ? TextAlign.left
          //     : TextAlign.right,

          // textStyle: TextStyle(
          //   textAlign: SettingsController.appLanguge == "English" ? TextAlign.left : TextAlign.right,
          // ),
        ),

        /// old html package

        // Html(
        //   data: isExpanded ? widget.htmlContent : _getTruncatedHtmlContent(),
        //   // customTextAlign: (_) => SettingsController.appLanguge == "English"
        //   //     ? TextAlign.left
        //   //     : TextAlign.right,
        //
        //   style: {
        //     'html': Style(
        //       textAlign: SettingsController.appLanguge == "English"
        //           ? TextAlign.left
        //           : TextAlign.right,
        //     ),
        //   },
        // ),

        /// ********************

        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? '....Show less' : 'Show more....',
            style: AppTextStyle.boldGrey14.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  String _getTruncatedHtmlContent() {
    if (widget.htmlContent!.isEmpty) return widget.htmlContent!;

    final document = parse(widget.htmlContent);
    final buffer = StringBuffer();
    final text = document.body?.text;

    if (text != null) {
      final lines = LineSplitter.split(text).take(widget.maxLines);
      for (final line in lines) {
        buffer.writeln(line);
      }
    }

    return buffer.toString();
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabBlogController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          child: Obx(() => ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: controller.tabTitles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changeSelectedCategory(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index ? AppColors.primary : AppColors.primary.withOpacity(0.06),
                        // border: Border.all(
                        //   color: AppColors.primary,
                        //   width: 1,
                        // ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: Text(
                          controller.tabTitles[index].categoryEnglish!,
                          style: AppTextTheme.m(16).copyWith(
                            color: controller.selectedIndex.value == index ? Colors.white : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ).paddingHorizontal(4);
                },
              )),
        ),
        // const Divider(height: 1, thickness: 1),
        Expanded(
          // Wrap Column with Expanded
          child: PagedListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (c, i) {
              return SizedBox(height: 15);
            },
            // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            pagingController: controller.pagingController,

            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) {
                // var item = controller.latestVideos[index];
                return _buildItemView(context, item);
              },
              noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
              noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
              firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                controller: controller.pagingController,
              ),
            ),
            // itemBuilder: (context, index) {
            //   return ListTile(
            //     title: Text(controller.postsList[index].blogTitle),
            //     subtitle: Text(controller.postsList[index].desc),
            //   );
            // },
          ),
        ),
        const SizedBox(
          height: 80.0,
        ),
      ],
    );
  }

  Widget _buildItemView(BuildContext context, Post item) {
    return PostItemView(item);
  }
}

class PostItemView extends StatefulWidget {
  PostItemView(this.item, {Key? key}) : super(key: key);
  final Post item;

  @override
  State<PostItemView> createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  bool isExpanded = false;
  var short = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.item?.blogTitle ?? ""),
        // SizedBox(height: 20),
        Wrap(
          // direction: Axis.vertical,
          children: [
            Container(
                // height: containerHeight > 200 ? 300 : null,
                child: () {
              String html = widget.item?.descEnglish ?? "";
              var document = parse(html);
              String text = parse(document.body?.text ?? "").documentElement?.text ?? "";
              // print(text);

              //if (text.length > 100) {
              // return Text(text.substring(0, 100));
              //}

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // margin: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.blogTitleEnglish ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text("${text.length > 100 ? (text.substring(0, 100) + ' ...') : text}"),
                      SizedBox(height: 20),
                      //TODO share and like function
                      if (1 == 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.chat_bubble_outline),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {},
                            ),
                          ],
                        ),

                      Row(),
                    ],
                  ),
                ),
              ).onTap(() {
                Get.toNamed(Routes.BLOG_FULL_PAGE, arguments: widget.item);
              });

              // return Html(
              //   // customRender: (node, children) {
              //   //   return node.Container();
              //   // },

              //   data: widget.item?.desc ?? "",
              //   //TODO fix this for english posts
              //   customTextAlign: (elem) => TextAlign.right,
              // );
            }()),
          ],
        ),
      ],
    );

    // return ListTile(
    //   title: Text(widget.item?.blogTitle ?? ""),
    //   subtitle: Stack(
    //     children: [
    //       if (_isExpanded)
    //         Html(
    //           data: widget.item.desc,
    //           customTextAlign: (elem) => TextAlign.right,
    //         ),
    //       if (!_isExpanded)
    //         Positioned(
    //           bottom: 0,
    //           right: 0,
    //           child: Container(
    //             color: Colors.white.withOpacity(0.8),
    //             child: TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _isExpanded = true;
    //                 });
    //               },
    //               child: Text(
    //                 'See More',
    //                 style: TextStyle(color: Colors.blue),
    //               ),
    //             ),
    //           ),
    //         ),
    //       if (_isExpanded)
    //         Positioned(
    //           bottom: 0,
    //           right: 0,
    //           child: Container(
    //             color: Colors.white.withOpacity(0.8),
    //             child: TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _isExpanded = false;
    //                 });
    //               },
    //               child: Text(
    //                 'See Less',
    //                 style: TextStyle(color: Colors.blue),
    //               ),
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
  }
}

/// Old Blog View

// ignore: must_be_immutable
// class TabBlogView extends GetView<TabBlogController> {
//   TabBlogView({Key? key}) : super(key: key) {
//     if (Get.arguments != null) {
//       if (Get.arguments['id'] != null) {
//         if (Get.arguments['id'] == "notification") {
//           controller.isBottom = true;
//         }
//       }
//     }
//   }
//
//   TabBlogController tabBlogController = Get.put(TabBlogController());
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     /// NEW
//     return Scaffold(
//       backgroundColor: AppColors.boxPurple2.withOpacity(0.1),
//       body: GetBuilder<TabBlogController>(
//           init: TabBlogController(),
//           builder: (controller) {
//             return Column(
//               children: [
//                 Container(
//                   height: 75,
//                   width: MediaQuery.of(context).size.width,
//                   color: AppColors.primary,
//                   child: Center(
//                     child: Text(
//                       'medical_blog'.tr,
//                       style: TextStyle(
//                         color: AppColors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                     height: 15
//                 ),
//                 SizedBox(
//                   width: w,
//                   height: Get.height * 0.12,
//                   child: ListView.builder(
//                     itemCount: controller.tabTitles.length,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         height: Get.height * 0.6,
//                         width: Get.width * 0.2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   controller.selected.value = index;
//                                   controller.update();
//                                   controller.pagingController = PagingController<int, Post>(firstPageKey: 1);
//                                   controller.changeSelectedCategory(index);
//                                 },
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: Get.height * 0.06,
//                                       width: Get.height * 0.07,
//                                       // width: 50,
//                                       // padding: EdgeInsets.symmetric(
//                                       //     horizontal: 5, vertical: 5),
//                                       decoration: BoxDecoration(
//                                           color: controller.selected.value == index ? Color(0xff72D6FE) : AppColors.white,
//                                           borderRadius: BorderRadius.circular(5)),
//                                       child: Center(
//                                         child: Image.network(
//                                           '${ApiConsts.hostUrl}${controller.tabTitles[index].photo}',
//                                           height: Get.height * 0.07,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: Get.height * 0.008),
//                                     Container(
//                                       height: Get.height * 0.025,
//                                       width: Get.height * 0.07,
//                                       padding: EdgeInsets.symmetric(horizontal: 2),
//                                       decoration: BoxDecoration(
//                                           color: controller.selected.value == index ? Color(0xff72D6FE) : AppColors.white,
//                                           borderRadius: BorderRadius.circular(5)),
//                                       child: Center(
//                                         child: Text(
//                                           SettingsController.appLanguge == 'English'
//                                               ? '${controller.tabTitles[index].categoryEnglish}'
//                                               : SettingsController.appLanguge == 'پشتو'
//                                               ? '${controller.tabTitles[index].categoryPashto}'
//                                               : '${controller.tabTitles[index].categoryDari}',
//                                           maxLines: 2,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: Get.height * 0.01),
//                             Container(
//                               height: 8,
//                               width: MediaQuery.of(context).size.width * 0.42,
//                               // margin: EdgeInsets.only(top: 10),
//                               padding: EdgeInsets.only(top: 1.5, bottom: 1.5, left: 1.5, right: 1.5),
//                               color: AppColors.primary,
//                               child: controller.selected.value == index
//                                   ? Container(
//                                 color: AppColors.white,
//                               )
//                                   : Container(
//                                 color: AppColors.primary,
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   height: h * 0.72,
//                   child: PagedListView.separated(
//                     physics: BouncingScrollPhysics(),
//                     separatorBuilder: (c, i) {
//                       if ((i + 1) % 5 == 0) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Stack(
//                             children: [
//                               Container(
//                                 child: CarouselSlider(
//                                     options: CarouselOptions(
//                                       autoPlay: true,
//                                       height: Get.height * 0.2,
//                                       viewportFraction: 1.0,
//                                       enlargeCenterPage: false,
//                                       onPageChanged: (index, reason) {
//                                         controller.adIndex = index;
//                                         controller.update();
//                                       },
//                                     ),
//                                     items: controller.adList
//                                         .map((item) => GestureDetector(
//                                       onTap: () async {
//                                         if (!await launchUrl(Uri.parse(item.link!))) {
//                                           throw Exception('Could not launch ${item.link}');
//                                         }
//                                       },
//                                       child: Stack(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 5),
//                                             child: Container(
//                                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                                               // margin: EdgeInsets.all(5.0),
//                                               child: ClipRRect(
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                 child: Image.network(
//                                                   "${ApiConsts.hostUrl}${item.img}",
//                                                   fit: BoxFit.cover,
//                                                   width: 1000.0,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 10,
//                                             right: SettingsController.appLanguge != "English" ? null : 10,
//                                             left: SettingsController.appLanguge == "English" ? null : 10,
//                                             child: SettingsController.appLanguge != "English"
//                                                 ? Transform(
//                                               alignment: Alignment.center,
//                                               transform: Matrix4.rotationY(math.pi),
//                                               child: Image.asset(
//                                                 AppImages.promote,
//                                                 height: 18,
//                                                 width: 18,
//                                                 color: AppColors.white,
//                                               ),
//                                             )
//                                                 : Image.asset(
//                                               AppImages.promote,
//                                               height: 18,
//                                               width: 18,
//                                               color: AppColors.white,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ))
//                                         .toList()),
//                               ),
//                               Positioned(
//                                 bottom: Get.height * 0.017,
//                                 left: 0,
//                                 right: 0,
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: List.generate(
//                                       controller.adList.length,
//                                           (index) => Padding(
//                                         padding: const EdgeInsets.only(left: 3),
//                                         child: CircleAvatar(
//                                           radius: 5,
//                                           backgroundColor:
//                                           controller.adIndex == index ? AppColors.primary : AppColors.primary.withOpacity(0.2),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       } else {
//                         return SizedBox(height: 15);
//                       }
//                     },
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     pagingController: controller.pagingController,
//                     builderDelegate: PagedChildBuilderDelegate<Post>(
//                       itemBuilder: (context, item, index) {
//                         return Column(
//                           children: [
//                             SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10),
//                               child: Container(
//                                 // height: h * 0.2,
//                                 width: w,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Padding(
//                                     //   padding: const EdgeInsets.only(top: 5),
//                                     //   child: CircleAvatar(
//                                     //     radius: 25,
//                                     //     backgroundImage: NetworkImage(
//                                     //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
//                                     //     ),
//                                     //     onBackgroundImageError:
//                                     //         (exception, stackTrace) {
//                                     //       return Image.asset(
//                                     //         "assets/png/person-placeholder.jpg",
//                                     //         fit: BoxFit.cover,
//                                     //       );
//                                     //     },
//                                     //   ),
//                                     // ),
//                                     Expanded(
//                                       flex: 3,
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             // SizedBox(height: 10),
//                                             InkWell(
//                                               onTap: () {
//                                                 Get.to(
//                                                   BlogDetailsScreen(
//                                                     post: controller.postList[index],
//                                                     index: index,
//                                                   ),
//                                                 );
//                                                 // controller.showDescription(index);
//                                               },
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Flexible(
//                                                     child: Text(
//                                                       SettingsController.appLanguge == 'English'
//                                                           ? "${controller.postList[index].blogTitleEnglish}"
//                                                           : SettingsController.appLanguge == 'پشتو'
//                                                           ? "${controller.postList[index].blogTitlePashto}"
//                                                           : '${controller.postList[index].blogTitleDari}',
//                                                       style: AppTextTheme.h(14).copyWith(
//                                                         color: AppColors.primary,
//                                                       ),
//                                                       // maxLines: 1,
//                                                     ),
//                                                   ),
//                                                   //  controller.postList[index]
//                                                   //              .isPublished ==
//                                                   //          true
//                                                   //      ? SvgPicture.asset(
//                                                   //         AppImages.check,
//                                                   //      )
//                                                   //   : SizedBox()
//                                                 ],
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Container(
//                                                   // color: AppColors.red,
//                                                   child: Flexible(
//                                                     child: GestureDetector(
//                                                       onTap: () {
//                                                         Get.to(
//                                                           BlogDetailsScreen(
//                                                             post: controller.postList[index],
//                                                             index: index,
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: Text("${controller.postList[index].name}",
//                                                           style: AppTextTheme.h(11)
//                                                               .copyWith(color: AppColors.primary, fontWeight: FontWeight.w400)
//                                                         // maxLines: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 3),
//                                                 Icon(
//                                                   Icons.circle,
//                                                   size: 3,
//                                                   color: AppColors.primary,
//                                                 ),
//                                                 SizedBox(width: 3),
//                                                 Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     Flexible(
//                                                       child: Text(
//                                                         "${calculateTime(DateTime.parse(controller.postList[index].createAt.toString()))} ",
//                                                         // maxLines: 1,
//                                                         // overflow:
//                                                         // TextOverflow.clip,
//                                                         style: AppTextTheme.h(11).copyWith(
//                                                           color: AppColors.primary,
//                                                           fontWeight: FontWeight.w400,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     // Icon(
//                                                     //   Icons.circle,
//                                                     //   size: 3,
//                                                     //   color: AppColors.primary,
//                                                     // )
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // SizedBox(height: 10),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(BlogDetailsScreen(
//                                   post: controller.postList[index],
//                                   index: index,
//                                 ));
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 5),
//                                 child: AspectRatio(
//                                   //width: w * 0.7,
//                                   //height: h * 0.33,
//                                   aspectRatio: 1024 / 500,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.indigo,
//                                       image: DecorationImage(
//                                         image: NetworkImage(
//                                           "${ApiConsts.hostUrl}${controller.postList[index].img}",
//                                         ),
//                                         fit: BoxFit.cover,
//                                         // onError: (exception, stackTrace) {
//                                         //   log('================== ON ERROR CALLED ==================');
//                                         //   return Image.asset(
//                                         //     "assets/png/person-placeholder.jpg",
//                                         //     fit: BoxFit.cover,
//                                         //   );
//                                         // },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(top: 5),
//                             //   child: CircleAvatar(
//                             //     radius: h * 0.1,
//                             //     backgroundImage: NetworkImage(
//                             //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
//                             //     ),
//                             //     onBackgroundImageError:
//                             //         (exception, stackTrace) {
//                             //       return Image.asset(
//                             //         "assets/png/person-placeholder.jpg",
//                             //         fit: BoxFit.cover,
//                             //       );
//                             //     },
//                             //   ),
//                             // ),
//                             SizedBox(height: 10),
//
//                             controller.showDesc == index
//                                 ? HtmlWidget(
//                               controller.postList[index].descEnglish ?? "",
//                               // customTextAlign: (_) =>
//                               //     SettingsController.appLanguge == "English"
//                               //         ? TextAlign.left
//                               //         : TextAlign.right,
//                               // textStyle: TextStyle(
//                               //   textAlign:
//                               //   SettingsController.appLanguge ==
//                               //       "English"
//                               //       ? TextAlign.left
//                               //       : TextAlign.right,
//                               // ),
//                               // onImageError: (exception, stackTrace) {
//                               //   return Image.network(
//                               //       "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
//                               // },
//                             )
//
//                             // controller.postList[index].desc.length < 10
//                             //     ?
//
//                             /// Old Package ********************
//                             // Html(
//                             //         data: controller.postList[index].descEnglish,
//                             //         // customTextAlign: (_) =>
//                             //         //     SettingsController.appLanguge == "English"
//                             //         //         ? TextAlign.left
//                             //         //         : TextAlign.right,
//                             //         style: {
//                             //           'html': Style(
//                             //             textAlign:
//                             //                 SettingsController.appLanguge ==
//                             //                         "English"
//                             //                     ? TextAlign.left
//                             //                     : TextAlign.right,
//                             //           ),
//                             //         },
//                             //         // onImageError: (exception, stackTrace) {
//                             //         //   return Image.network(
//                             //         //       "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
//                             //         // },
//                             //       )
//
//                             ///  **********************
//                             // ShowMoreLessHTML(
//                             //         htmlContent: controller.postList[index]
//                             //             .desc, // Replace with your HTML content
//                             //         maxLines:
//                             //             1, // Specify the number of lines to display initially
//                             //       ),
//                                 : SizedBox(),
//
//                             // ReadMoreText(
//                             //   parse(controller.postList[index].desc).body.text,
//                             //   numLines: 5,
//                             //   readMoreText: "...see more",
//                             //   readLessText: '  see less',
//                             // ),
//                             // Html(
//                             //   data: controller.postList[index].desc,
//                             //   onImageError: (exception, stackTrace) {
//                             //     return Image.network(
//                             //         "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
//                             //   },
//                             // ),
//
//                             SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         AppImages.like1,
//                                         width: 20,
//                                         height: 20,
//                                       ),
//                                       SizedBox(width: 5),
//                                       Text(
//                                         controller.postList[index].likes!.length.toString(),
//                                         style: AppTextTheme.h(14)
//                                             .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "${controller.postList[index].comments!.length.toString()} ",
//                                         style: AppTextTheme.h(14)
//                                             .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                       ),
//                                       Text(
//                                         "comment".tr,
//                                         style: AppTextTheme.h(14)
//                                             .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                       ),
//                                       SizedBox(width: 5),
//                                       Icon(
//                                         Icons.circle,
//                                         size: 5,
//                                         color: AppColors.primary.withOpacity(0.7),
//                                       ),
//                                       SizedBox(width: 5),
//                                       Text(
//                                         "${controller.postList[index].shares!.length.toString()} ",
//                                         style: AppTextTheme.h(14)
//                                             .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                       ),
//                                       Text(
//                                         "shares".tr,
//                                         style: AppTextTheme.h(14)
//                                             .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   ),
//                                   Divider(
//                                     color: AppColors.primary.withOpacity(0.7),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                                     child: Row(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             if (controller.postList[index].likes!.contains(SettingsController.userId.toString())) {
//                                               controller.postList[index].likes?.remove(SettingsController.userId);
//                                             } else {
//                                               controller.postList[index].likes?.add(SettingsController.userId);
//                                             }
//
//                                             controller.update();
//                                             controller.likeBlog(controller.postList[index].id!, index, controller.postList[index]);
//                                           },
//                                           child: Row(
//                                             children: [
//                                               controller.postList[index].likes!.contains(SettingsController.userId.toString())
//                                                   ? SvgPicture.asset(
//                                                 AppImages.likeFill,
//                                                 width: 20,
//                                                 height: 20,
//                                                 color: AppColors.primary.withOpacity(0.7),
//                                               )
//                                                   : SvgPicture.asset(
//                                                 AppImages.like2,
//                                                 width: 20,
//                                                 height: 20,
//                                                 color: AppColors.primary.withOpacity(0.7),
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "like".tr,
//                                                 style: AppTextTheme.h(14)
//                                                     .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Get.to(
//                                               CommentView(index),
//                                             );
//                                           },
//                                           child: Row(
//                                             children: [
//                                               SvgPicture.asset(
//                                                 AppImages.comment,
//                                                 width: 24,
//                                                 height: 24,
//                                                 color: AppColors.primary.withOpacity(0.7),
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "comment".tr,
//                                                 style: AppTextTheme.h(14)
//                                                     .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         GestureDetector(
//                                           onTap: () async {
//                                             final result = await Share.shareWithResult(SettingsController.appLanguge == 'English'
//                                                 ? parse(controller.postList[index].descEnglish).body!.text
//                                                 : SettingsController.appLanguge == 'پشتو'
//                                                 ? parse(controller.postList[index].descPashto).body!.text
//                                                 : parse(controller.postList[index].descDari).body!.text);
//                                             if (result.status == ShareResultStatus.success) {
//                                               controller.postList[index].shares!.add(SettingsController.userId);
//                                               controller.update();
//                                               controller.shareBlog(controller.postList[index].id!, index, controller.postList[index]);
//                                             }
//                                           },
//                                           child: Row(
//                                             children: [
//                                               SvgPicture.asset(
//                                                 AppImages.share,
//                                                 width: 24,
//                                                 height: 24,
//                                                 color: AppColors.primary.withOpacity(0.7),
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "share".tr,
//                                                 style: AppTextTheme.h(14)
//                                                     .copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Divider(
//                                     color: AppColors.primary.withOpacity(0.7),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         );
//                       },
//                       noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
//                       noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
//                       firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
//                         controller: controller.pagingController,
//                       ),
//                     ),
//                     // itemBuilder: (context, index) {
//                     //   return ListTile(
//                     //     title: Text(controller.postsList[index].blogTitle),
//                     //     subtitle: Text(controller.postsList[index].desc),
//                     //   );
//                     // },
//                   ),
//                 ),
//               ],
//             );
//           }
//       ),
//     );
//
//     /// OLD
//     // return Scaffold(
//     //   backgroundColor: Colors.white,
//     //   appBar: AppBar(
//     //     backgroundColor: Colors.transparent,
//     //     title: Text(
//     //       'medical_blog'.tr,
//     //       textAlign: TextAlign.center,
//     //       style: AppTextStyle.boldPrimary16,
//     //     ),
//     //     centerTitle: true,
//     //     elevation: 0,
//     //     // actions: [
//     //     //   Padding(
//     //     //     padding: const EdgeInsets.symmetric(horizontal: 20),
//     //     //     child: GestureDetector(
//     //     //       onTap: () {
//     //     //         Get.toNamed(Routes.NOTIFICATION);
//     //     //       },
//     //     //       child: SvgPicture.asset(
//     //     //         AppImages.blackBell,
//     //     //         height: 24,
//     //     //         width: 24,
//     //     //       ),
//     //     //     ),
//     //     //   )
//     //     // ],
//     //   ),
//     //   // appBar: AppBar(
//     //   //   backgroundColor: Colors.transparent,
//     //   //   title: Text(
//     //   //     'medical_blog'.tr,
//     //   //     textAlign: TextAlign.center,
//     //   //     style: AppTextStyle.boldPrimary16,
//     //   //   ),
//     //   //   centerTitle: true,
//     //   //   elevation: 0,
//     //   //   // actions: [
//     //   //   //   Padding(
//     //   //   //     padding: const EdgeInsets.symmetric(horizontal: 20),
//     //   //   //     child: GestureDetector(
//     //   //   //       onTap: () {
//     //   //   //         Get.toNamed(Routes.NOTIFICATION);
//     //   //   //       },
//     //   //   //       child: SvgPicture.asset(
//     //   //   //         AppImages.blackBell,
//     //   //   //         height: 24,
//     //   //   //         width: 24,
//     //   //   //       ),
//     //   //   //     ),
//     //   //   //   )
//     //   //   // ],
//     //   // ),
//     //   body: Obx(
//     //     () {
//     //       return /* controller.isLoading.value == true
//     //         ? Center(child: CircularProgressIndicator())
//     //         :*/
//     //           Stack(
//     //         children: [
//     //           Column(
//     //             children: [
//     //               Padding(
//     //                 padding: const EdgeInsets.symmetric(
//     //                     horizontal: 20, vertical: 10),
//     //                 child: SingleChildScrollView(
//     //                   scrollDirection: Axis.horizontal,
//     //                   physics: BouncingScrollPhysics(),
//     //                   child: Row(
//     //                     mainAxisAlignment: MainAxisAlignment.center,
//     //                     children: List.generate(
//     //                         controller.tabTitles.length,
//     //                         (index) => Padding(
//     //                               padding: const EdgeInsets.only(right: 10),
//     //                               child: GestureDetector(
//     //                                 onTap: () {
//     //                                   controller.tabIndex.value = index;
//     //                                   controller.changeSelectedCategory(index);
//     //                                 },
//     //                                 child: Container(
//     //                                   decoration: BoxDecoration(
//     //                                       borderRadius:
//     //                                           BorderRadius.circular(20),
//     //                                       color:
//     //                                           controller.tabIndex.value != index
//     //                                               ? AppColors.lightGrey
//     //                                               : AppColors.primary,
//     //                                       border: Border.all(
//     //                                           color:
//     //                                               controller.tabIndex.value !=
//     //                                                       index
//     //                                                   ? AppColors.lightGrey
//     //                                                   : AppColors.primary)),
//     //                                   child: Padding(
//     //                                     padding: const EdgeInsets.symmetric(
//     //                                         horizontal: 10, vertical: 8),
//     //                                     child: Center(
//     //                                       child: Container(
//     //                                           //width: w * 0.35,
//     //                                           child: Center(
//     //                                               child: Text(
//     //                                         controller
//     //                                             .tabTitles[index].category,
//     //                                         maxLines: 1,
//     //                                         overflow: TextOverflow.ellipsis,
//     //                                         style: controller.tabIndex.value !=
//     //                                                 index
//     //                                             ? AppTextStyle.boldPrimary14
//     //                                             : AppTextStyle.boldWhite14,
//     //                                       ))),
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                             )),
//     //                   ),
//     //                 ),
//     //               ),
//     //               GetBuilder<TabBlogController>(
//     //                 builder: (controller) {
//     //                   return Container(
//     //                     height: h * 0.72,
//     //                     child: PagedListView.separated(
//     //                       physics: BouncingScrollPhysics(),
//     //                       separatorBuilder: (c, i) {
//     //                         if ((i + 1) % 5 == 0) {
//     //                           return Padding(
//     //                             padding: const EdgeInsets.only(top: 10),
//     //                             child: Stack(
//     //                               children: [
//     //                                 Container(
//     //                                   child: CarouselSlider(
//     //                                       options: CarouselOptions(
//     //                                         autoPlay: true,
//     //                                         height: Get.height * 0.2,
//     //                                         viewportFraction: 1.0,
//     //                                         enlargeCenterPage: false,
//     //                                         onPageChanged: (index, reason) {
//     //                                           controller.adIndex = index;
//     //                                           controller.update();
//     //                                         },
//     //                                       ),
//     //                                       items: controller.adList
//     //                                           .map((item) => Padding(
//     //                                                 padding:
//     //                                                     const EdgeInsets.only(
//     //                                                         left: 5),
//     //                                                 child: Container(
//     //                                                   decoration: BoxDecoration(
//     //                                                       borderRadius:
//     //                                                           BorderRadius
//     //                                                               .circular(
//     //                                                                   15)),
//     //                                                   // margin: EdgeInsets.all(5.0),
//     //                                                   child: ClipRRect(
//     //                                                     borderRadius:
//     //                                                         BorderRadius.all(
//     //                                                             Radius.circular(
//     //                                                                 15.0)),
//     //                                                     child: Image.network(
//     //                                                       "${ApiConsts.hostUrl}${item.img}",
//     //                                                       fit: BoxFit.cover,
//     //                                                       width: 1000.0,
//     //                                                     ),
//     //                                                   ),
//     //                                                 ),
//     //                                               ))
//     //                                           .toList()),
//     //                                 ),
//     //                                 Positioned(
//     //                                   bottom: Get.height * 0.017,
//     //                                   left: 0,
//     //                                   right: 0,
//     //                                   child: Center(
//     //                                     child: Row(
//     //                                       mainAxisAlignment:
//     //                                           MainAxisAlignment.center,
//     //                                       children: List.generate(
//     //                                         controller.adList.length,
//     //                                         (index) => Padding(
//     //                                           padding: const EdgeInsets.only(
//     //                                               left: 3),
//     //                                           child: CircleAvatar(
//     //                                             radius: 5,
//     //                                             backgroundColor:
//     //                                                 controller.adIndex == index
//     //                                                     ? AppColors.primary
//     //                                                     : AppColors.primary
//     //                                                         .withOpacity(0.2),
//     //                                           ),
//     //                                         ),
//     //                                       ),
//     //                                     ),
//     //                                   ),
//     //                                 )
//     //                               ],
//     //                             ),
//     //                           );
//     //                         } else {
//     //                           return SizedBox(height: 15);
//     //                         }
//     //                       },
//     //
//     //                       // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
//     //                       padding:
//     //                           EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//     //                       pagingController: controller.pagingController,
//     //
//     //                       builderDelegate: PagedChildBuilderDelegate<Post>(
//     //                         itemBuilder: (context, item, index) {
//     //                           return Column(
//     //                             children: [
//     //                               SizedBox(height: 10),
//     //                               Padding(
//     //                                 padding: const EdgeInsets.symmetric(
//     //                                     horizontal: 10),
//     //                                 child: Container(
//     //                                   // height: h * 0.2,
//     //                                   width: w,
//     //                                   child: Row(
//     //                                     crossAxisAlignment:
//     //                                         CrossAxisAlignment.start,
//     //                                     children: [
//     //                                       // Padding(
//     //                                       //   padding: const EdgeInsets.only(top: 5),
//     //                                       //   child: CircleAvatar(
//     //                                       //     radius: 25,
//     //                                       //     backgroundImage: NetworkImage(
//     //                                       //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
//     //                                       //     ),
//     //                                       //     onBackgroundImageError:
//     //                                       //         (exception, stackTrace) {
//     //                                       //       return Image.asset(
//     //                                       //         "assets/png/person-placeholder.jpg",
//     //                                       //         fit: BoxFit.cover,
//     //                                       //       );
//     //                                       //     },
//     //                                       //   ),
//     //                                       // ),
//     //                                       Expanded(
//     //                                         flex: 3,
//     //                                         child: Padding(
//     //                                           padding:
//     //                                               const EdgeInsets.symmetric(
//     //                                                   horizontal: 5),
//     //                                           child: Column(
//     //                                             mainAxisAlignment:
//     //                                                 MainAxisAlignment.center,
//     //                                             crossAxisAlignment:
//     //                                                 CrossAxisAlignment.center,
//     //                                             children: [
//     //                                               // SizedBox(height: 10),
//     //                                               InkWell(
//     //                                                 onTap: () {
//     //                                                   controller
//     //                                                       .showDescription(
//     //                                                           index);
//     //                                                 },
//     //                                                 child: Row(
//     //                                                   mainAxisAlignment:
//     //                                                       MainAxisAlignment
//     //                                                           .center,
//     //                                                   crossAxisAlignment:
//     //                                                       CrossAxisAlignment
//     //                                                           .center,
//     //                                                   mainAxisSize:
//     //                                                       MainAxisSize.min,
//     //                                                   children: [
//     //                                                     Flexible(
//     //                                                       child: Text(
//     //                                                         "${controller.postList[index].blogTitle}",
//     //                                                         style:
//     //                                                             AppTextTheme.h(
//     //                                                                     14)
//     //                                                                 .copyWith(
//     //                                                           color: AppColors
//     //                                                               .primary,
//     //                                                         ),
//     //                                                         // maxLines: 1,
//     //                                                       ),
//     //                                                     ),
//     //                                                     //  controller.postList[index]
//     //                                                     //              .isPublished ==
//     //                                                     //          true
//     //                                                     //      ? SvgPicture.asset(
//     //                                                     //         AppImages.check,
//     //                                                     //      )
//     //                                                     //   : SizedBox()
//     //                                                   ],
//     //                                                 ),
//     //                                               ),
//     //                                               Row(
//     //                                                 mainAxisAlignment:
//     //                                                     MainAxisAlignment
//     //                                                         .center,
//     //                                                 crossAxisAlignment:
//     //                                                     CrossAxisAlignment
//     //                                                         .center,
//     //                                                 children: [
//     //                                                   Container(
//     //                                                     // color: AppColors.red,
//     //                                                     child: Flexible(
//     //                                                       child: Text(
//     //                                                           "${controller.postList[index].name}",
//     //                                                           style: AppTextTheme.h(11).copyWith(
//     //                                                               color: AppColors
//     //                                                                   .primary,
//     //                                                               fontWeight:
//     //                                                                   FontWeight
//     //                                                                       .w400)
//     //                                                           // maxLines: 1,
//     //                                                           ),
//     //                                                     ),
//     //                                                   ),
//     //                                                   SizedBox(width: 3),
//     //                                                   Icon(
//     //                                                     Icons.circle,
//     //                                                     size: 3,
//     //                                                     color:
//     //                                                         AppColors.primary,
//     //                                                   ),
//     //                                                   SizedBox(width: 3),
//     //                                                   Row(
//     //                                                     mainAxisAlignment:
//     //                                                         MainAxisAlignment
//     //                                                             .center,
//     //                                                     crossAxisAlignment:
//     //                                                         CrossAxisAlignment
//     //                                                             .center,
//     //                                                     mainAxisSize:
//     //                                                         MainAxisSize.min,
//     //                                                     children: [
//     //                                                       Flexible(
//     //                                                         child: Text(
//     //                                                           "${calculateTime(controller.postList[index].createAt)} ",
//     //                                                           // maxLines: 1,
//     //                                                           // overflow:
//     //                                                           // TextOverflow.clip,
//     //                                                           style:
//     //                                                               AppTextTheme
//     //                                                                       .h(11)
//     //                                                                   .copyWith(
//     //                                                             color: AppColors
//     //                                                                 .primary,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .w400,
//     //                                                           ),
//     //                                                         ),
//     //                                                       ),
//     //                                                       // Icon(
//     //                                                       //   Icons.circle,
//     //                                                       //   size: 3,
//     //                                                       //   color: AppColors.primary,
//     //                                                       // )
//     //                                                     ],
//     //                                                   ),
//     //                                                 ],
//     //                                               ),
//     //                                             ],
//     //                                           ),
//     //                                         ),
//     //                                       ),
//     //                                     ],
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                               // SizedBox(height: 10),
//     //                               Padding(
//     //                                 padding: EdgeInsets.only(top: 5),
//     //                                 child: AspectRatio(
//     //                                   //width: w * 0.7,
//     //                                   //height: h * 0.33,
//     //                                   aspectRatio: 1024 / 500,
//     //                                   child: Container(
//     //                                     decoration: BoxDecoration(
//     //                                       color: Colors.indigo,
//     //                                       image: DecorationImage(
//     //                                         image: NetworkImage(
//     //                                           "${ApiConsts.hostUrl}${controller.postList[index].img}",
//     //                                         ),
//     //                                         fit: BoxFit.cover,
//     //                                         onError: (exception, stackTrace) {
//     //                                           log('================== ON ERROR CALLED ==================');
//     //                                           return Image.asset(
//     //                                             "assets/png/person-placeholder.jpg",
//     //                                             fit: BoxFit.cover,
//     //                                           );
//     //                                         },
//     //                                       ),
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                               // Padding(
//     //                               //   padding: const EdgeInsets.only(top: 5),
//     //                               //   child: CircleAvatar(
//     //                               //     radius: h * 0.1,
//     //                               //     backgroundImage: NetworkImage(
//     //                               //       "${ApiConsts.hostUrl}${controller.postList[index].img}",
//     //                               //     ),
//     //                               //     onBackgroundImageError:
//     //                               //         (exception, stackTrace) {
//     //                               //       return Image.asset(
//     //                               //         "assets/png/person-placeholder.jpg",
//     //                               //         fit: BoxFit.cover,
//     //                               //       );
//     //                               //     },
//     //                               //   ),
//     //                               // ),
//     //                               SizedBox(height: 10),
//     //
//     //                               controller.showDesc == index
//     //                                   ?
//     //                                   // controller.postList[index].desc.length < 10
//     //                                   //     ?
//     //                                   Html(
//     //                                       data: controller.postList[index].desc,
//     //                                       customTextAlign: (_) =>
//     //                                           SettingsController.appLanguge ==
//     //                                                   "English"
//     //                                               ? TextAlign.left
//     //                                               : TextAlign.right,
//     //                                       onImageError:
//     //                                           (exception, stackTrace) {
//     //                                         return Image.network(
//     //                                             "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
//     //                                       },
//     //                                     )
//     //
//     //                                   // ShowMoreLessHTML(
//     //                                   //         htmlContent: controller.postList[index]
//     //                                   //             .desc, // Replace with your HTML content
//     //                                   //         maxLines:
//     //                                   //             1, // Specify the number of lines to display initially
//     //                                   //       ),
//     //                                   : SizedBox(),
//     //
//     //                               // ReadMoreText(
//     //                               //   parse(controller.postList[index].desc).body.text,
//     //                               //   numLines: 5,
//     //                               //   readMoreText: "...see more",
//     //                               //   readLessText: '  see less',
//     //                               // ),
//     //                               // Html(
//     //                               //   data: controller.postList[index].desc,
//     //                               //   onImageError: (exception, stackTrace) {
//     //                               //     return Image.network(
//     //                               //         "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
//     //                               //   },
//     //                               // ),
//     //
//     //                               SizedBox(height: 10),
//     //                               Padding(
//     //                                 padding: const EdgeInsets.symmetric(
//     //                                     horizontal: 10),
//     //                                 child: Column(
//     //                                   children: [
//     //                                     Row(
//     //                                       children: [
//     //                                         Image.asset(
//     //                                           AppImages.like1,
//     //                                           width: 20,
//     //                                           height: 20,
//     //                                         ),
//     //                                         SizedBox(width: 5),
//     //                                         Text(
//     //                                           controller
//     //                                               .postList[index].likes.length
//     //                                               .toString(),
//     //                                           style: AppTextTheme.h(14)
//     //                                               .copyWith(
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                   fontWeight:
//     //                                                       FontWeight.w400),
//     //                                         ),
//     //                                         Spacer(),
//     //                                         Text(
//     //                                           "${controller.postList[index].comments.length.toString()} ",
//     //                                           style: AppTextTheme.h(14)
//     //                                               .copyWith(
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                   fontWeight:
//     //                                                       FontWeight.w400),
//     //                                         ),
//     //                                         Text(
//     //                                           "comment".tr,
//     //                                           style: AppTextTheme.h(14)
//     //                                               .copyWith(
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                   fontWeight:
//     //                                                       FontWeight.w400),
//     //                                         ),
//     //                                         SizedBox(width: 5),
//     //                                         Icon(
//     //                                           Icons.circle,
//     //                                           size: 5,
//     //                                           color: AppColors.primary
//     //                                               .withOpacity(0.7),
//     //                                         ),
//     //                                         SizedBox(width: 5),
//     //                                         Text(
//     //                                           "${controller.postList[index].shares.length.toString()} ",
//     //                                           style: AppTextTheme.h(14)
//     //                                               .copyWith(
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                   fontWeight:
//     //                                                       FontWeight.w400),
//     //                                         ),
//     //                                         Text(
//     //                                           "shares".tr,
//     //                                           style: AppTextTheme.h(14)
//     //                                               .copyWith(
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                   fontWeight:
//     //                                                       FontWeight.w400),
//     //                                         )
//     //                                       ],
//     //                                     ),
//     //                                     Divider(
//     //                                       color: AppColors.primary
//     //                                           .withOpacity(0.7),
//     //                                     ),
//     //                                     Padding(
//     //                                       padding: const EdgeInsets.symmetric(
//     //                                           horizontal: 10),
//     //                                       child: Row(
//     //                                         children: [
//     //                                           GestureDetector(
//     //                                             onTap: () {
//     //                                               if (controller
//     //                                                   .postList[index].likes
//     //                                                   .contains(
//     //                                                       SettingsController
//     //                                                           .userId
//     //                                                           .toString())) {
//     //                                                 controller
//     //                                                     .postList[index].likes
//     //                                                     .remove(
//     //                                                         SettingsController
//     //                                                             .userId);
//     //                                               } else {
//     //                                                 controller
//     //                                                     .postList[index].likes
//     //                                                     .add(SettingsController
//     //                                                         .userId);
//     //                                               }
//     //
//     //                                               controller.update();
//     //                                               controller.likeBlog(
//     //                                                   controller
//     //                                                       .postList[index].id,
//     //                                                   index,
//     //                                                   controller
//     //                                                       .postList[index]);
//     //                                             },
//     //                                             child: Row(
//     //                                               children: [
//     //                                                 controller.postList[index]
//     //                                                         .likes
//     //                                                         .contains(
//     //                                                             SettingsController
//     //                                                                 .userId
//     //                                                                 .toString())
//     //                                                     ? SvgPicture.asset(
//     //                                                         AppImages.likeFill,
//     //                                                         width: 20,
//     //                                                         height: 20,
//     //                                                         color: AppColors
//     //                                                             .primary
//     //                                                             .withOpacity(
//     //                                                                 0.7),
//     //                                                       )
//     //                                                     : SvgPicture.asset(
//     //                                                         AppImages.like2,
//     //                                                         width: 20,
//     //                                                         height: 20,
//     //                                                         color: AppColors
//     //                                                             .primary
//     //                                                             .withOpacity(
//     //                                                                 0.7),
//     //                                                       ),
//     //                                                 SizedBox(width: 5),
//     //                                                 Text(
//     //                                                   "like".tr,
//     //                                                   style: AppTextTheme.h(14)
//     //                                                       .copyWith(
//     //                                                           color: AppColors
//     //                                                               .primary
//     //                                                               .withOpacity(
//     //                                                                   0.7),
//     //                                                           fontWeight:
//     //                                                               FontWeight
//     //                                                                   .w400),
//     //                                                 ),
//     //                                               ],
//     //                                             ),
//     //                                           ),
//     //                                           Spacer(),
//     //                                           GestureDetector(
//     //                                             onTap: () {
//     //                                               Get.to(
//     //                                                 CommentView(index),
//     //                                               );
//     //                                             },
//     //                                             child: Row(
//     //                                               children: [
//     //                                                 SvgPicture.asset(
//     //                                                   AppImages.comment,
//     //                                                   width: 24,
//     //                                                   height: 24,
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                 ),
//     //                                                 SizedBox(width: 5),
//     //                                                 Text(
//     //                                                   "comment".tr,
//     //                                                   style: AppTextTheme.h(14)
//     //                                                       .copyWith(
//     //                                                           color: AppColors
//     //                                                               .primary
//     //                                                               .withOpacity(
//     //                                                                   0.7),
//     //                                                           fontWeight:
//     //                                                               FontWeight
//     //                                                                   .w400),
//     //                                                 ),
//     //                                               ],
//     //                                             ),
//     //                                           ),
//     //                                           Spacer(),
//     //                                           GestureDetector(
//     //                                             onTap: () async {
//     //                                               final result = await Share
//     //                                                   .shareWithResult(
//     //                                                 parse(controller
//     //                                                         .postList[index]
//     //                                                         .desc)
//     //                                                     .body
//     //                                                     .text,
//     //                                               );
//     //                                               if (result.status ==
//     //                                                   ShareResultStatus
//     //                                                       .success) {
//     //                                                 controller
//     //                                                     .postList[index].shares
//     //                                                     .add(SettingsController
//     //                                                         .userId);
//     //                                                 controller.update();
//     //                                                 controller.shareBlog(
//     //                                                     controller
//     //                                                         .postList[index].id,
//     //                                                     index,
//     //                                                     controller
//     //                                                         .postList[index]);
//     //                                               }
//     //                                             },
//     //                                             child: Row(
//     //                                               children: [
//     //                                                 SvgPicture.asset(
//     //                                                   AppImages.share,
//     //                                                   width: 24,
//     //                                                   height: 24,
//     //                                                   color: AppColors.primary
//     //                                                       .withOpacity(0.7),
//     //                                                 ),
//     //                                                 SizedBox(width: 5),
//     //                                                 Text(
//     //                                                   "share".tr,
//     //                                                   style: AppTextTheme.h(14)
//     //                                                       .copyWith(
//     //                                                           color: AppColors
//     //                                                               .primary
//     //                                                               .withOpacity(
//     //                                                                   0.7),
//     //                                                           fontWeight:
//     //                                                               FontWeight
//     //                                                                   .w400),
//     //                                                 ),
//     //                                               ],
//     //                                             ),
//     //                                           ),
//     //                                         ],
//     //                                       ),
//     //                                     ),
//     //                                     Divider(
//     //                                       color: AppColors.primary
//     //                                           .withOpacity(0.7),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               )
//     //                             ],
//     //                           );
//     //                         },
//     //                         noMoreItemsIndicatorBuilder: (_) =>
//     //                             DotDotPagingNoMoreItems(),
//     //                         noItemsFoundIndicatorBuilder: (_) =>
//     //                             PagingNoItemFountList(),
//     //                         firstPageErrorIndicatorBuilder: (context) =>
//     //                             PagingErrorView(
//     //                           controller: controller.pagingController,
//     //                         ),
//     //                       ),
//     //                       // itemBuilder: (context, index) {
//     //                       //   return ListTile(
//     //                       //     title: Text(controller.postsList[index].blogTitle),
//     //                       //     subtitle: Text(controller.postsList[index].desc),
//     //                       //   );
//     //                       // },
//     //                     ),
//     //                   );
//     //                 },
//     //               ),
//     //               // Container(
//     //               //   height: h * 0.72,
//     //               //   child: SingleChildScrollView(
//     //               //     physics: BouncingScrollPhysics(),
//     //               //     child: Column(
//     //               //         children: List.generate(4, (index) {
//     //               //       return Column(
//     //               //         children: [
//     //               //           index == 0
//     //               //               ? Padding(
//     //               //                   padding: const EdgeInsets.symmetric(
//     //               //                       horizontal: 20, vertical: 10),
//     //               //                   child: BannerView(),
//     //               //                 )
//     //               //               : SizedBox(),
//     //               //           SizedBox(height: 10),
//     //               //           Padding(
//     //               //             padding:
//     //               //                 const EdgeInsets.symmetric(horizontal: 20),
//     //               //             child: Container(
//     //               //               // height: h * 0.2,
//     //               //               width: w,
//     //               //               child: Row(
//     //               //                 children: [
//     //               //                   CircleAvatar(
//     //               //                     radius: 25,
//     //               //                     backgroundImage: NetworkImage(
//     //               //                         "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg"),
//     //               //                   ),
//     //               //                   Expanded(
//     //               //                     flex: 3,
//     //               //                     child: Padding(
//     //               //                       padding: const EdgeInsets.symmetric(
//     //               //                           horizontal: 5),
//     //               //                       child: Column(
//     //               //                         mainAxisAlignment:
//     //               //                             MainAxisAlignment.start,
//     //               //                         crossAxisAlignment:
//     //               //                             CrossAxisAlignment.start,
//     //               //                         children: [
//     //               //                           // SizedBox(height: 10),
//     //               //                           Row(
//     //               //                             mainAxisAlignment:
//     //               //                                 MainAxisAlignment.start,
//     //               //                             crossAxisAlignment:
//     //               //                                 CrossAxisAlignment.center,
//     //               //                             mainAxisSize: MainAxisSize.min,
//     //               //                             children: [
//     //               //                               Flexible(
//     //               //                                 child: Text(
//     //               //                                   "Afghan Hospital",
//     //               //                                   style: AppTextTheme.h(14)
//     //               //                                       .copyWith(
//     //               //                                           color: AppColors
//     //               //                                               .primary),
//     //               //                                 ),
//     //               //                               ),
//     //               //                               SvgPicture.asset(
//     //               //                                   AppImages.check)
//     //               //                             ],
//     //               //                           ),
//     //               //                           Row(
//     //               //                             mainAxisAlignment:
//     //               //                                 MainAxisAlignment.start,
//     //               //                             crossAxisAlignment:
//     //               //                                 CrossAxisAlignment.center,
//     //               //                             mainAxisSize: MainAxisSize.min,
//     //               //                             children: [
//     //               //                               Text(
//     //               //                                 "4h ago ",
//     //               //                                 style: AppTextTheme.h(11)
//     //               //                                     .copyWith(
//     //               //                                         color:
//     //               //                                             AppColors.primary,
//     //               //                                         fontWeight:
//     //               //                                             FontWeight.w400),
//     //               //                               ),
//     //               //                               Icon(
//     //               //                                 Icons.circle,
//     //               //                                 size: 3,
//     //               //                                 color: AppColors.primary,
//     //               //                               )
//     //               //                             ],
//     //               //                           ),
//     //               //                           SizedBox(height: 2),
//     //               //                         ],
//     //               //                       ),
//     //               //                     ),
//     //               //                   ),
//     //               //                   Icon(
//     //               //                     Icons.more_vert,
//     //               //                     color: AppColors.primary,
//     //               //                   )
//     //               //                 ],
//     //               //               ),
//     //               //             ),
//     //               //           ),
//     //               //           SizedBox(height: 10),
//     //               //           Padding(
//     //               //             padding:
//     //               //                 const EdgeInsets.symmetric(horizontal: 20),
//     //               //             child: ExpandableText(
//     //               //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
//     //               //               expandText: 'Read more',
//     //               //               collapseText: 'Read less',
//     //               //               maxLines: 3,
//     //               //               linkColor: AppColors.grey.withOpacity(0.6),
//     //               //               style: AppTextStyle.boldPrimary11.copyWith(
//     //               //                   fontWeight: FontWeight.w500,
//     //               //                   color: AppColors.black),
//     //               //             ),
//     //               //           ),
//     //               //           SizedBox(height: 10),
//     //               //           Container(
//     //               //             height: h * 0.3,
//     //               //             width: w,
//     //               //             child: Image.network(
//     //               //                 "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
//     //               //                 fit: BoxFit.cover),
//     //               //           ),
//     //               //           SizedBox(height: 10),
//     //               //           Padding(
//     //               //             padding:
//     //               //                 const EdgeInsets.symmetric(horizontal: 10),
//     //               //             child: Column(
//     //               //               children: [
//     //               //                 Row(
//     //               //                   children: [
//     //               //                     Image.asset(
//     //               //                       AppImages.like1,
//     //               //                       width: 20,
//     //               //                       height: 20,
//     //               //                     ),
//     //               //                     SizedBox(width: 5),
//     //               //                     Text(
//     //               //                       "6.9K ",
//     //               //                       style: AppTextTheme.h(14).copyWith(
//     //               //                           color: AppColors.primary
//     //               //                               .withOpacity(0.5),
//     //               //                           fontWeight: FontWeight.w400),
//     //               //                     ),
//     //               //                     Spacer(),
//     //               //                     Text(
//     //               //                       "2.9K ",
//     //               //                       style: AppTextTheme.h(14).copyWith(
//     //               //                           color: AppColors.primary
//     //               //                               .withOpacity(0.5),
//     //               //                           fontWeight: FontWeight.w400),
//     //               //                     ),
//     //               //                     Text(
//     //               //                       "comment".tr,
//     //               //                       style: AppTextTheme.h(14).copyWith(
//     //               //                           color: AppColors.primary
//     //               //                               .withOpacity(0.5),
//     //               //                           fontWeight: FontWeight.w400),
//     //               //                     ),
//     //               //                     SizedBox(width: 5),
//     //               //                     Icon(
//     //               //                       Icons.circle,
//     //               //                       size: 5,
//     //               //                       color:
//     //               //                           AppColors.primary.withOpacity(0.5),
//     //               //                     ),
//     //               //                     SizedBox(width: 5),
//     //               //                     Text(
//     //               //                       "20 ",
//     //               //                       style: AppTextTheme.h(14).copyWith(
//     //               //                           color: AppColors.primary
//     //               //                               .withOpacity(0.5),
//     //               //                           fontWeight: FontWeight.w400),
//     //               //                     ),
//     //               //                     Text(
//     //               //                       "shares".tr,
//     //               //                       style: AppTextTheme.h(14).copyWith(
//     //               //                           color: AppColors.primary
//     //               //                               .withOpacity(0.5),
//     //               //                           fontWeight: FontWeight.w400),
//     //               //                     )
//     //               //                   ],
//     //               //                 ),
//     //               //                 Divider(
//     //               //                   color: AppColors.primary.withOpacity(0.5),
//     //               //                 ),
//     //               //                 Padding(
//     //               //                   padding: const EdgeInsets.symmetric(
//     //               //                       horizontal: 10),
//     //               //                   child: Row(
//     //               //                     children: [
//     //               //                       SvgPicture.asset(
//     //               //                         AppImages.like2,
//     //               //                         width: 20,
//     //               //                         height: 20,
//     //               //                         color: AppColors.primary
//     //               //                             .withOpacity(0.5),
//     //               //                       ),
//     //               //                       SizedBox(width: 5),
//     //               //                       Text(
//     //               //                         "like".tr,
//     //               //                         style: AppTextTheme.h(14).copyWith(
//     //               //                             color: AppColors.primary
//     //               //                                 .withOpacity(0.5),
//     //               //                             fontWeight: FontWeight.w400),
//     //               //                       ),
//     //               //                       Spacer(),
//     //               //                       SvgPicture.asset(
//     //               //                         AppImages.comment,
//     //               //                         width: 24,
//     //               //                         height: 24,
//     //               //                         color: AppColors.primary
//     //               //                             .withOpacity(0.5),
//     //               //                       ),
//     //               //                       SizedBox(width: 5),
//     //               //                       Text(
//     //               //                         "comment".tr,
//     //               //                         style: AppTextTheme.h(14).copyWith(
//     //               //                             color: AppColors.primary
//     //               //                                 .withOpacity(0.5),
//     //               //                             fontWeight: FontWeight.w400),
//     //               //                       ),
//     //               //                       Spacer(),
//     //               //                       SvgPicture.asset(
//     //               //                         AppImages.share,
//     //               //                         width: 24,
//     //               //                         height: 24,
//     //               //                         color: AppColors.primary
//     //               //                             .withOpacity(0.5),
//     //               //                       ),
//     //               //                       SizedBox(width: 5),
//     //               //                       Text(
//     //               //                         "share".tr,
//     //               //                         style: AppTextTheme.h(14).copyWith(
//     //               //                             color: AppColors.primary
//     //               //                                 .withOpacity(0.5),
//     //               //                             fontWeight: FontWeight.w400),
//     //               //                       ),
//     //               //                     ],
//     //               //                   ),
//     //               //                 ),
//     //               //                 Divider(
//     //               //                   color: AppColors.primary.withOpacity(0.5),
//     //               //                 ),
//     //               //               ],
//     //               //             ),
//     //               //           )
//     //               //         ],
//     //               //       );
//     //               //     })),
//     //               //   ),
//     //               // )
//     //             ],
//     //           ),
//     //           Positioned(
//     //             bottom: 20,
//     //             right: 20,
//     //             left: 20,
//     //             child: BottomBarView(
//     //               isHomeScreen: false,
//     //               isBlueBottomBar: true,
//     //             ),
//     //           )
//     //         ],
//     //       );
//     //     },
//     //   ),
//     // );
//
//     ///
//     // return Scaffold(
//     //   appBar: AppAppBar.specialAppBar(
//     //     "blog".tr,
//     //     showLeading: false,
//     //   ),
//     //   body: Obx(() {
//     //     // if (controller.isLoading.value) {
//     //     //   return const Center(child: CircularProgressIndicator());
//     //     // } else {
//     //     return IndexedStack(
//     //       index: !controller.isLoading() ? 0 : 1,
//     //       children: [
//     //         RefreshIndicator(
//     //           onRefresh: () => Future.sync(
//     //             () async {
//     //               Utils.resetPagingController(controller.pagingController);
//     //               await Future.delayed(Duration.zero, () {
//     //                 controller.blogCancelToken.cancel();
//     //                 controller.categoriesCancelToken.cancel();
//     //               });
//     //               controller.blogCancelToken = new CancelToken();
//     //               controller.categoriesCancelToken = new CancelToken();
//     //               controller.selectedIndex.value = 0;
//     //               controller.isLoading(true);
//     //
//     //               controller.loadCategories(
//     //                   // controller.pagingController.firstPageKey,
//     //                   );
//     //             },
//     //           ),
//     //           child: _body(controller: controller),
//     //         ),
//     //         Center(
//     //           child: CircularProgressIndicator(
//     //             color: Colors.grey,
//     //           ),
//     //         ).bgColor(Colors.white),
//     //       ],
//     //     );
//     //   }
//     //       // },
//     //       ),
//     // );
//   }
//
//   static String calculateTime(DateTime time) {
//     Duration compare(DateTime x, DateTime y) {
//       return Duration(microseconds: (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());
//     }
//
//     DateTime x = DateTime.now();
//     DateTime y = time;
//
//     Duration diff = compare(x, y);
//     int days = diff.inDays;
//     int hours = diff.inHours;
//     int minutes = diff.inMinutes;
//
//     String result = '';
//     if (days > 365) {
//       result = '${(days / 365).floor().toString()}y ago';
//     } else if (days > 30) {
//       result = '${(days / 30).floor().toString()}m ago';
//     } else if (days > 7) {
//       result = '${(days / 7).floor().toString()}w ago';
//     } else if (days > 1) {
//       result = '${(days / 1).floor().toString()}d ago';
//     } else if (hours > 1) {
//       result = '${hours}h ago';
//     } else if (minutes > 1) {
//       result = '${minutes}m ago';
//     } else {
//       result = 'Now';
//     }
//
//     return result;
//   }
// }
