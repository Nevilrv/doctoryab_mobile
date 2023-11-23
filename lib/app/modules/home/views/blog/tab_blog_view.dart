import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/blog_like_res_model.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/home/views/blog/comment_blog_screen.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../components/paging_indicators/dotdot_nomore_items.dart';
import '../../../../components/paging_indicators/no_item_list.dart';
import '../../../../components/paging_indicators/paging_error_view.dart';
import '../../../../components/spacialAppBar.dart';
import '../../../../controllers/settings_controller.dart';
import '../../../../data/models/post.dart';
import '../../../../routes/app_pages.dart';
import '../../../../theme/AppColors.dart';
import '../../../../theme/TextTheme.dart';
import '../../../../utils/utils.dart';
import '../../controllers/tab_blog_controller.dart';
import 'package:html/parser.dart' show parse;

class TabBlogView extends GetView<TabBlogController> {
  List tab = ["Dentists", "Gyne", "Pediatric"];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'medical_blog'.tr,
          textAlign: TextAlign.center,
          style: AppTextStyle.boldPrimary20,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              AppImages.blackBell,
              height: 24,
            ),
          )
        ],
      ),
      body: Obx(() {
        return /* controller.isLoading.value == true
            ? Center(child: CircularProgressIndicator())
            :*/
            Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      controller.tabTitles.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                controller.tabIndex.value = index;
                                controller.changeSelectedCategory(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: controller.tabIndex.value != index
                                        ? AppColors.lightGrey
                                        : AppColors.primary,
                                    border: Border.all(
                                        color:
                                            controller.tabIndex.value != index
                                                ? AppColors.lightGrey
                                                : AppColors.primary)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  child: Center(
                                    child: Container(
                                        width: w * 0.25,
                                        child: Center(
                                            child: Text(
                                          controller.tabTitles[index].category,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              controller.tabIndex.value != index
                                                  ? AppTextStyle.boldPrimary14
                                                  : AppTextStyle.boldWhite14,
                                        ))),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ),
            GetBuilder<TabBlogController>(
              builder: (controller) {
                return Container(
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
                                        .map((item) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                // margin: EdgeInsets.all(5.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  child: Image.network(
                                                      "${ApiConsts.hostUrl}${item.img}",
                                                      fit: BoxFit.cover,
                                                      width: 1000.0),
                                                ),
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
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    controller.adIndex == index
                                                        ? AppColors.primary
                                                        : AppColors.primary
                                                            .withOpacity(0.2),
                                              ),
                                            )),
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

                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    pagingController: controller.pagingController,

                    builderDelegate: PagedChildBuilderDelegate<Post>(
                      itemBuilder: (context, item, index) {
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                // height: h * 0.2,
                                width: w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          "${ApiConsts.hostUrl}${controller.postList[index].img}",
                                        ),
                                        onBackgroundImageError:
                                            (exception, stackTrace) {
                                          return Image.asset(
                                            "assets/png/person-placeholder.jpg",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "${controller.postList[index].blogTitle}",
                                                    style: AppTextTheme.h(14)
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                    ),
                                                    // maxLines: 1,
                                                  ),
                                                ),
                                                controller.postList[index]
                                                            .isPublished ==
                                                        true
                                                    ? SvgPicture.asset(
                                                        AppImages.check)
                                                    : SizedBox()
                                              ],
                                            ),
                                            Container(
                                              // color: AppColors.red,
                                              child: Text(
                                                  "${controller.postList[index].name}",
                                                  style: AppTextTheme.h(11)
                                                      .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w400)
                                                  // maxLines: 1,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "${calculateTime(controller.postList[index].createAt)} ",
                                                  style: AppTextTheme.h(11)
                                                      .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  size: 3,
                                                  color: AppColors.primary,
                                                )
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
                            SizedBox(height: 10),
                            controller.postList[index].desc.length < 10
                                ? Html(
                                    data: controller.postList[index].desc,
                                    onImageError: (exception, stackTrace) {
                                      return Image.network(
                                          "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                                    },
                                  )
                                : ShowMoreLessHTML(
                                    htmlContent: controller.postList[index]
                                        .desc, // Replace with your HTML content
                                    maxLines:
                                        5, // Specify the number of lines to display initially
                                  ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                        controller.postList[index].likes.length
                                            .toString(),
                                        style: AppTextTheme.h(14).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${controller.postList[index].comments.length.toString()} ",
                                        style: AppTextTheme.h(14).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "comment".tr,
                                        style: AppTextTheme.h(14).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.circle,
                                        size: 5,
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${controller.postList[index].shares.length.toString()} ",
                                        style: AppTextTheme.h(14).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "shares".tr,
                                        style: AppTextTheme.h(14).copyWith(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColors.primary.withOpacity(0.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.postList[index].likes
                                                .contains(SettingsController
                                                    .userId
                                                    .toString())) {
                                              controller.postList[index].likes
                                                  .remove(SettingsController
                                                      .userId);
                                            } else {
                                              controller.postList[index].likes
                                                  .add(SettingsController
                                                      .userId);
                                            }

                                            controller.update();
                                            controller.likeBlog(
                                                controller.postList[index].id,
                                                index,
                                                controller.postList[index]);
                                          },
                                          child: Row(
                                            children: [
                                              controller.postList[index].likes
                                                      .contains(
                                                          SettingsController
                                                              .userId
                                                              .toString())
                                                  ? SvgPicture.asset(
                                                      AppImages.likeFill,
                                                      width: 20,
                                                      height: 20,
                                                      color: AppColors.primary
                                                          .withOpacity(0.5),
                                                    )
                                                  : SvgPicture.asset(
                                                      AppImages.like2,
                                                      width: 20,
                                                      height: 20,
                                                      color: AppColors.primary
                                                          .withOpacity(0.5),
                                                    ),
                                              SizedBox(width: 5),
                                              Text(
                                                "like".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                color: AppColors.primary
                                                    .withOpacity(0.5),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "comment".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            final result =
                                                await Share.shareWithResult(
                                                    controller
                                                        .postList[index].desc);

                                            if (result.status ==
                                                ShareResultStatus.success) {
                                              controller.postList[index].shares
                                                  .add(SettingsController
                                                      .userId);

                                              controller.update();
                                              controller.shareBlog(
                                                  controller.postList[index].id,
                                                  index,
                                                  controller.postList[index]);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.share,
                                                width: 24,
                                                height: 24,
                                                color: AppColors.primary
                                                    .withOpacity(0.5),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "share".tr,
                                                style: AppTextTheme.h(14)
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.primary.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      noMoreItemsIndicatorBuilder: (_) =>
                          DotDotPagingNoMoreItems(),
                      noItemsFoundIndicatorBuilder: (_) =>
                          PagingNoItemFountList(),
                      firstPageErrorIndicatorBuilder: (context) =>
                          PagingErrorView(
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
                );
              },
            ),
            // Container(
            //   height: h * 0.72,
            //   child: SingleChildScrollView(
            //     physics: BouncingScrollPhysics(),
            //     child: Column(
            //         children: List.generate(4, (index) {
            //       return Column(
            //         children: [
            //           index == 0
            //               ? Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       horizontal: 20, vertical: 10),
            //                   child: BannerView(),
            //                 )
            //               : SizedBox(),
            //           SizedBox(height: 10),
            //           Padding(
            //             padding:
            //                 const EdgeInsets.symmetric(horizontal: 20),
            //             child: Container(
            //               // height: h * 0.2,
            //               width: w,
            //               child: Row(
            //                 children: [
            //                   CircleAvatar(
            //                     radius: 25,
            //                     backgroundImage: NetworkImage(
            //                         "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg"),
            //                   ),
            //                   Expanded(
            //                     flex: 3,
            //                     child: Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 5),
            //                       child: Column(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           // SizedBox(height: 10),
            //                           Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.center,
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               Flexible(
            //                                 child: Text(
            //                                   "Afghan Hospital",
            //                                   style: AppTextTheme.h(14)
            //                                       .copyWith(
            //                                           color: AppColors
            //                                               .primary),
            //                                 ),
            //                               ),
            //                               SvgPicture.asset(
            //                                   AppImages.check)
            //                             ],
            //                           ),
            //                           Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.center,
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               Text(
            //                                 "4h ago ",
            //                                 style: AppTextTheme.h(11)
            //                                     .copyWith(
            //                                         color:
            //                                             AppColors.primary,
            //                                         fontWeight:
            //                                             FontWeight.w400),
            //                               ),
            //                               Icon(
            //                                 Icons.circle,
            //                                 size: 3,
            //                                 color: AppColors.primary,
            //                               )
            //                             ],
            //                           ),
            //                           SizedBox(height: 2),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Icon(
            //                     Icons.more_vert,
            //                     color: AppColors.primary,
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //           SizedBox(height: 10),
            //           Padding(
            //             padding:
            //                 const EdgeInsets.symmetric(horizontal: 20),
            //             child: ExpandableText(
            //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            //               expandText: 'Read more',
            //               collapseText: 'Read less',
            //               maxLines: 3,
            //               linkColor: AppColors.grey.withOpacity(0.6),
            //               style: AppTextStyle.boldPrimary11.copyWith(
            //                   fontWeight: FontWeight.w500,
            //                   color: AppColors.black),
            //             ),
            //           ),
            //           SizedBox(height: 10),
            //           Container(
            //             height: h * 0.3,
            //             width: w,
            //             child: Image.network(
            //                 "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
            //                 fit: BoxFit.cover),
            //           ),
            //           SizedBox(height: 10),
            //           Padding(
            //             padding:
            //                 const EdgeInsets.symmetric(horizontal: 10),
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Image.asset(
            //                       AppImages.like1,
            //                       width: 20,
            //                       height: 20,
            //                     ),
            //                     SizedBox(width: 5),
            //                     Text(
            //                       "6.9K ",
            //                       style: AppTextTheme.h(14).copyWith(
            //                           color: AppColors.primary
            //                               .withOpacity(0.5),
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                     Spacer(),
            //                     Text(
            //                       "2.9K ",
            //                       style: AppTextTheme.h(14).copyWith(
            //                           color: AppColors.primary
            //                               .withOpacity(0.5),
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                     Text(
            //                       "comment".tr,
            //                       style: AppTextTheme.h(14).copyWith(
            //                           color: AppColors.primary
            //                               .withOpacity(0.5),
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                     SizedBox(width: 5),
            //                     Icon(
            //                       Icons.circle,
            //                       size: 5,
            //                       color:
            //                           AppColors.primary.withOpacity(0.5),
            //                     ),
            //                     SizedBox(width: 5),
            //                     Text(
            //                       "20 ",
            //                       style: AppTextTheme.h(14).copyWith(
            //                           color: AppColors.primary
            //                               .withOpacity(0.5),
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                     Text(
            //                       "shares".tr,
            //                       style: AppTextTheme.h(14).copyWith(
            //                           color: AppColors.primary
            //                               .withOpacity(0.5),
            //                           fontWeight: FontWeight.w400),
            //                     )
            //                   ],
            //                 ),
            //                 Divider(
            //                   color: AppColors.primary.withOpacity(0.5),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       horizontal: 10),
            //                   child: Row(
            //                     children: [
            //                       SvgPicture.asset(
            //                         AppImages.like2,
            //                         width: 20,
            //                         height: 20,
            //                         color: AppColors.primary
            //                             .withOpacity(0.5),
            //                       ),
            //                       SizedBox(width: 5),
            //                       Text(
            //                         "like".tr,
            //                         style: AppTextTheme.h(14).copyWith(
            //                             color: AppColors.primary
            //                                 .withOpacity(0.5),
            //                             fontWeight: FontWeight.w400),
            //                       ),
            //                       Spacer(),
            //                       SvgPicture.asset(
            //                         AppImages.comment,
            //                         width: 24,
            //                         height: 24,
            //                         color: AppColors.primary
            //                             .withOpacity(0.5),
            //                       ),
            //                       SizedBox(width: 5),
            //                       Text(
            //                         "comment".tr,
            //                         style: AppTextTheme.h(14).copyWith(
            //                             color: AppColors.primary
            //                                 .withOpacity(0.5),
            //                             fontWeight: FontWeight.w400),
            //                       ),
            //                       Spacer(),
            //                       SvgPicture.asset(
            //                         AppImages.share,
            //                         width: 24,
            //                         height: 24,
            //                         color: AppColors.primary
            //                             .withOpacity(0.5),
            //                       ),
            //                       SizedBox(width: 5),
            //                       Text(
            //                         "share".tr,
            //                         style: AppTextTheme.h(14).copyWith(
            //                             color: AppColors.primary
            //                                 .withOpacity(0.5),
            //                             fontWeight: FontWeight.w400),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Divider(
            //                   color: AppColors.primary.withOpacity(0.5),
            //                 ),
            //               ],
            //             ),
            //           )
            //         ],
            //       );
            //     })),
            //   ),
            // )
          ],
        );
      }),
    );
    // return Scaffold(
    //   appBar: AppAppBar.specialAppBar(
    //     "blog".tr,
    //     showLeading: false,
    //   ),
    //   body: Obx(() {
    //     // if (controller.isLoading.value) {
    //     //   return const Center(child: CircularProgressIndicator());
    //     // } else {
    //     return IndexedStack(
    //       index: !controller.isLoading() ? 0 : 1,
    //       children: [
    //         RefreshIndicator(
    //           onRefresh: () => Future.sync(
    //             () async {
    //               Utils.resetPagingController(controller.pagingController);
    //               await Future.delayed(Duration.zero, () {
    //                 controller.blogCancelToken.cancel();
    //                 controller.categoriesCancelToken.cancel();
    //               });
    //               controller.blogCancelToken = new CancelToken();
    //               controller.categoriesCancelToken = new CancelToken();
    //               controller.selectedIndex.value = 0;
    //               controller.isLoading(true);
    //
    //               controller.loadCategories(
    //                   // controller.pagingController.firstPageKey,
    //                   );
    //             },
    //           ),
    //           child: _body(controller: controller),
    //         ),
    //         Center(
    //           child: CircularProgressIndicator(
    //             color: Colors.grey,
    //           ),
    //         ).bgColor(Colors.white),
    //       ],
    //     );
    //   }
    //       // },
    //       ),
    // );
  }

  static String calculateTime(DateTime time) {
    Duration compare(DateTime x, DateTime y) {
      return Duration(
          microseconds:
              (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());
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
  final String htmlContent;
  final int maxLines;

  ShowMoreLessHTML({this.htmlContent, this.maxLines = 5});

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
        Html(
          data: isExpanded ? widget.htmlContent : _getTruncatedHtmlContent(),

          // style: {
          //   'body': Style(
          //     fontSize: FontSize(14.0),
          //   ),
          // },
        ),
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
    if (widget.htmlContent.isEmpty) return widget.htmlContent;

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

class _body extends StatelessWidget {
  const _body({
    Key key,
    @required this.controller,
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
                    onTap: () => controller.changeSelectedCategory(index),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.06),
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
                          controller.tabTitles[index].category,
                          style: AppTextTheme.m(16).copyWith(
                            color: controller.selectedIndex.value == index
                                ? Colors.white
                                : AppColors.primary,
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
  PostItemView(this.item, {Key key}) : super(key: key);
  final Post item;

  @override
  State<PostItemView> createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  bool _isExpanded = false;
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
              String html = widget.item?.desc ?? "";
              var document = parse(html);
              String text =
                  parse(document.body?.text ?? "").documentElement?.text ?? "";
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
                        widget.item?.blogTitle ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                          "${text.length > 100 ? (text.substring(0, 100) + ' ...') : text}"),
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
