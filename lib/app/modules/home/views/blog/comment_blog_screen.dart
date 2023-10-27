import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_blog_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentView extends GetView<TabBlogController> {
  final Post data;
  const CommentView(this.data, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Background(
      isSecond: true,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              'comments'.tr,
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
          body: GetBuilder<TabBlogController>(
            builder: (controller) {
              return Column(
                children: [
                  //this helps to show the loading of next page

                  Expanded(
                    child: controller.isLoading()
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.commentList.isEmpty
                            ? Center(child: Text("No comments"))
                            : ListView.separated(
                                // reverse: true,
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    left: Get.width * 0.03,
                                    right: Get.width * 0.03),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration:
                                        BoxDecoration(color: AppColors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              controller
                                                  .commentList[index].whoPosted,
                                              style: AppTextStyle.boldBlack16),
                                          Text(
                                              controller
                                                  .commentList[index].text,
                                              style: AppTextStyle.boldBlack16
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, i) =>
                                    const SizedBox(
                                      height: 22,
                                    ),
                                itemCount: controller.commentList.length
                                //  controller.chat.value.messages.length,

                                ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03, vertical: 18.0),
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: AppColors.grey.withOpacity(0.5),
                                      spreadRadius: 0.1,
                                      blurRadius: 5,
                                      offset: Offset(2, 6),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  // onTap: controller.scrollToEnd,
                                  controller: controller.comment,
                                  decoration: InputDecoration(

                                      // suffixIcon: GestureDetector(
                                      //   child: Icon(
                                      //     Icons.emoji_emotions_outlined,
                                      //     color: AppColors.black,
                                      //     size: 18,
                                      //   ),
                                      // ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 14.0),
                                      hintText: 'Add a Comment',
                                      hintStyle: AppTextStyle.regularGrey16,
                                      filled: true,
                                      fillColor: AppColors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                ),
                              )),
                              const SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.comment.text.isEmpty) {
                                    Get.showSnackbar(GetSnackBar(
                                      title: "Error",
                                      message: "Please enter text",
                                      // isDismissible: true,
                                    ));
                                  } else {
                                    controller.commentBlog(
                                        data.id, controller.comment.text);
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.send,
                                    color: AppColors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
