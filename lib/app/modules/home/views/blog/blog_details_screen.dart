import 'dart:convert';
import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_blog_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart' show parse;
import 'comment_blog_screen.dart';

class BlogDetailsScreen extends StatefulWidget {
  final Post? post;
  final int? index;

  BlogDetailsScreen({Key? key, this.post, this.index}) : super(key: key);

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    log('widget.post ---------->>>>>>>> ${jsonEncode(widget.post)}');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            SettingsController.appLanguge == 'English'
                ? "${widget.post!.blogTitleEnglish}"
                : SettingsController.appLanguge == 'پشتو'
                    ? "${widget.post!.blogTitlePashto}"
                    : '${widget.post!.blogTitleDari}',
            style: AppTextStyle.boldWhite18,
          ),
        ),
        body: GetBuilder<TabBlogController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   height: Get.height * 0.02,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 5),
                //   child: AspectRatio(
                //     //width: w * 0.7,
                //     //height: h * 0.33,
                //     aspectRatio: 1024 / 500,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.indigo,
                //         borderRadius: BorderRadius.circular(15),
                //         image: DecorationImage(
                //           image: NetworkImage(
                //             "${ApiConsts.hostUrl}${widget.post.img}",
                //           ),
                //           fit: BoxFit.cover,
                //           onError: (exception, stackTrace) {
                //             log('================== ON ERROR CALLED ==================');
                //             return Image.asset(
                //               "assets/png/person-placeholder.jpg",
                //               fit: BoxFit.cover,
                //             );
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Container(height: Get.height * 0.02),
                Expanded(
                  child: Container(
                    // height: Get.height * 0.46,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          HtmlWidget(
                            SettingsController.appLanguge == 'English'
                                ? "${widget.post!.descEnglish}"
                                : SettingsController.appLanguge == 'پشتو'
                                    ? "${widget.post!.descPashto}"
                                    : '${widget.post!.descDari}',
                            // textStyle:TextStyle(
                            //   textAlign: SettingsController.appLanguge == "English" ? TextAlign.left : TextAlign.right,
                            // ),
                          ),

                          /// Old Flutter Html Package

                          // Html(
                          //   data: SettingsController.appLanguge == 'English'
                          //       ? "${widget.post!.descEnglish}"
                          //       : SettingsController.appLanguge == 'پشتو'
                          //           ? "${widget.post!.descPashto}"
                          //           : '${widget.post!.descDari}',
                          //   style: {
                          //     'html': Style(
                          //       textAlign: SettingsController.appLanguge == "English" ? TextAlign.left : TextAlign.right,
                          //     ),
                          //   },
                          //
                          //   // customTextAlign: (_) =>
                          //   //     SettingsController.appLanguge == "English"
                          //   //         ? TextAlign.left
                          //   //         : TextAlign.right,
                          //   // onImageError: (exception, stackTrace) {
                          //   //   return Image.network(
                          //   //       "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg");
                          //   // },
                          // ),
                        ],
                      ),
                    ),
                    // color: AppColors.red,
                  ),
                ),
                // Spacer(),
                Container(height: Get.height * 0.03),
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
                            widget.post!.likes!.length.toString(),
                            style: AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          Text(
                            "${widget.post!.comments!.length.toString()} ",
                            style: AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "comment".tr,
                            style: AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.circle,
                            size: 5,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${widget.post!.shares!.length.toString()} ",
                            style: AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "shares".tr,
                            style: AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
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
                                if (widget.post!.likes!.contains(SettingsController.userId.toString())) {
                                  widget.post!.likes!.remove(SettingsController.userId);
                                } else {
                                  widget.post!.likes!.add(SettingsController.userId);
                                }

                                controller.update();
                                controller.likeBlog(widget.post!.id!, widget.index!, widget.post!);
                              },
                              child: Row(
                                children: [
                                  widget.post!.likes!.contains(SettingsController.userId.toString())
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
                                    style:
                                        AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  CommentView(widget.index!),
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
                                    style:
                                        AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                final result = await Share.shareWithResult(
                                  SettingsController.appLanguge == 'English'
                                      ? parse(widget.post!.descEnglish).body!.text
                                      : SettingsController.appLanguge == 'پشتو'
                                          ? parse(widget.post!.descPashto).body!.text
                                          : parse(widget.post!.descDari).body!.text,
                                );
                                if (result.status == ShareResultStatus.success) {
                                  widget.post!.shares!.add(SettingsController.userId);
                                  controller.update();
                                  controller.shareBlog(widget.post!.id!, widget.index!, widget.post!);
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
                                    style:
                                        AppTextTheme.h(14).copyWith(color: AppColors.primary.withOpacity(0.7), fontWeight: FontWeight.w400),
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
                ),
                Container(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          );
        })
        // backgroundColor: AppColors.boxPurple2.withOpacity(0.1),
        );
  }
}
