import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/modules/home/controllers/appointmtnet_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AppointmentFeedbackScreen extends StatelessWidget {
  History? history;

  AppointmentFeedbackScreen({Key? key, this.history}) : super(key: key);

  List question = [
    "Are you satify from Doctor examination and manner?",
    "How do you rate doctor expertise and knowledge?",
    "How do you rate cleanliness?"
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('give_feedback'.tr, style: AppTextStyle.boldPrimary20.copyWith(fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
            // child: RotatedBox(
            //   quarterTurns: SettingsController.appLanguge == "English" ? 0 : 2,
            //   child: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
            // ),
          ),
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(Routes.NOTIFICATION);
          //       },
          //       child: SvgPicture.asset(
          //         AppImages.blackBell,
          //         height: 24,
          //         width: 24,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(child: GetBuilder<AppointmentHistoryController>(
          builder: (controller) {
            return Container(
              height: h * 0.89,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        Container(
                            height: h * 0.7,
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.white,
                              boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: AppColors.black.withOpacity(0.25))],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.black,
                                        // height: 65,
                                        // width: 65,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightGrey),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: "${ApiConsts.hostUrl}${history?.doctor?[0].photo}",
                                            height: h * 0.11,
                                            width: h * 0.11,
                                            fit: BoxFit.cover,
                                            placeholder: (_, __) {
                                              return Image.asset(
                                                "assets/png/person-placeholder.jpg",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            errorWidget: (_, __, ___) {
                                              return Image.asset(
                                                "assets/png/person-placeholder.jpg",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 10),
                                              Text(
                                                "${history?.doctor?[0].name}",
                                                style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                              ),
                                              Text(
                                                "${history?.doctor?[0].category?.title}",
                                                style: AppTextTheme.h(11)
                                                    .copyWith(color: AppColors.primary.withOpacity(0.5), fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 17,
                                                    initialRating: double.parse(
                                                        "${history?.doctor?[0].averageRatings == null || history?.doctor?[0].averageRatings == "" ? "0" : history?.doctor?[0].averageRatings.toString()}"),
                                                    // minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                    itemBuilder: (context, _) => Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      // size: 10,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  SizedBox(width: 4),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('-----SJSJSJ');
                                                      // Get.toNamed(
                                                      //   Routes.REVIEW,
                                                      //   arguments: [
                                                      //     "Doctor_Review",
                                                      //     history.doctor[0]
                                                      //   ],
                                                      // );
                                                    },
                                                    child: Text(
                                                      '(${history?.doctor?[0].totalFeedbacks == null ? 0 : history?.doctor?[0].totalFeedbacks}) ${"reviews".tr}',
                                                      style: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        'reviews_question'.tr,
                                        style: AppTextTheme.b(11).copyWith(color: AppColors.primary.withOpacity(0.5)),
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
                                    height: h * 0.01,
                                  ),
                                  ...List.generate(
                                      question.length,
                                      (index) => Column(
                                            children: [
                                              Text(
                                                question[index],
                                                style: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                              ),
                                              SizedBox(
                                                height: h * 0.005,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(color: AppColors.yellow2.withOpacity(0.2)),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  child: RatingBar.builder(
                                                    // ignoreGestures: true,
                                                    itemSize: 25,
                                                    initialRating: index == 0
                                                        ? controller.sRating
                                                        : index == 1
                                                            ? controller.eRating
                                                            : controller.cRating,
                                                    // minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                    itemBuilder: (context, _) => Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      // size: 10,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      if (index == 0) {
                                                        controller.sRating = rating;
                                                      } else if (index == 1) {
                                                        controller.eRating = rating;
                                                      } else {
                                                        controller.cRating = rating;
                                                      }
                                                      controller.update();
                                                      print(rating);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * 0.02,
                                              ),
                                            ],
                                          )),
                                  TextField(
                                    maxLines: 3,
                                    controller: controller.comment,
                                    cursorColor: AppColors.primary,
                                    style: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                    decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelText: "Evaluate the appointment experience".tr,
                                        labelStyle: AppTextTheme.b(12).copyWith(color: AppColors.primary.withOpacity(0.5)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2))),
                                  ),
                                  // SizedBox(
                                  //   height: h * 0.03,
                                  // ),
                                  Spacer(),
                                  controller.isLoading1 == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: AppColors.primary,
                                        ))
                                      : GestureDetector(
                                          onTap: () {
                                            if (controller.comment.text.isEmpty) {
                                              Utils.commonSnackbar(text: "please_add_review".tr, context: context);
                                            } else {
                                              controller.addDocFeedback(context: context, doctorId: history?.doctor?[0].datumId);
                                            }
                                            // Get.to(AppointmentFeedbackScreen());
                                          },
                                          child: Container(
                                            width: w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: AppColors.primary,
                                                boxShadow: [
                                                  BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: AppColors.black.withOpacity(0.25))
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              child: Center(
                                                child: Text(
                                                  "submit_a_reviews".tr,
                                                  style: AppTextStyle.boldWhite10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: BottomBarView(
                      isHomeScreen: false,
                      isBlueBottomBar: true,
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
