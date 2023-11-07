import 'package:doctor_yab/app/modules/home/controllers/comp_sugge_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SuggestionScreen extends GetView<ComplaintSuggestionController> {
  const SuggestionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/png/bg_blue2.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('suggestion'.tr),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              )),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                AppImages.bellwhite,
                height: 24,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Container(
                      height: h * 0.7,
                      width: w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.black.withOpacity(0.25))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: w * 0.2,
                                    child: Divider(
                                      color: AppColors.primary.withOpacity(0.5),
                                      height: 3,
                                    )),
                                SizedBox(
                                  width: w * 0.02,
                                ),
                                Text(
                                  'suggestion_subject'.tr,
                                  style: AppTextTheme.b(11).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                ),
                                SizedBox(
                                  width: w * 0.02,
                                ),
                                Container(
                                    width: w * 0.2,
                                    child: Divider(
                                      color: AppColors.primary.withOpacity(0.5),
                                      height: 3,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            TextField(
                              cursorColor: AppColors.primary,
                              controller: controller.sTitle,
                              style: AppTextTheme.b(12).copyWith(
                                  color: AppColors.primary.withOpacity(0.5)),
                              decoration: InputDecoration(
                                  labelText: "topic_title".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: AppTextTheme.b(12).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary
                                              .withOpacity(0.4),
                                          width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary
                                              .withOpacity(0.4),
                                          width: 2))),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            TextField(
                              maxLines: 10,
                              cursorColor: AppColors.primary,
                              controller: controller.sDesc,
                              style: AppTextTheme.b(12).copyWith(
                                  color: AppColors.primary.withOpacity(0.5)),
                              decoration: InputDecoration(
                                  labelText: "suggestion_body".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: AppTextTheme.b(12).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary
                                              .withOpacity(0.4),
                                          width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: AppColors.primary
                                              .withOpacity(0.4),
                                          width: 2))),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.image.value = null;
                                controller.pickImage();
                              },
                              child: Container(
                                width: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.primary,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color:
                                              AppColors.black.withOpacity(0.25))
                                    ]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(AppImages.attachment,
                                            height: 21, width: 21),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "add_attachment".tr,
                                          style: AppTextStyle.boldWhite10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Text(
                              'description'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextTheme.b(11).copyWith(
                                  color: AppColors.primary.withOpacity(0.5)),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (controller.sTitle.text.isEmpty) {
                                  Utils.commonSnackbar(
                                      context: context,
                                      text: "Please enter title");
                                } else if (controller.sDesc.text.isEmpty) {
                                  Utils.commonSnackbar(
                                      context: context,
                                      text: "Please enter description");
                                } else {
                                  controller.suggestionApi(context);
                                }
                              },
                              child: Container(
                                width: w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.primary,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color:
                                              AppColors.black.withOpacity(0.25))
                                    ]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Text(
                                      "submit".tr,
                                      style: AppTextStyle.boldWhite10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                      width: w * 0.6,
                      child: Divider(
                        color: AppColors.white.withOpacity(0.5),
                        thickness: 1,
                        height: 3,
                      )),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: BottomBarView(
                isHomeScreen: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
