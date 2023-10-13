import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/modules/favourites/treatment_abroad/controllers/treatment_abroad_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TreatmentAbroadView extends GetView<TreatmentAbroadController> {
  TreatmentAbroadView({Key key}) : super(key: key);

  List countryImage = [
    AppImages.turkey,
    AppImages.pakistan,
    AppImages.iran,
    AppImages.india,
  ];
  List countryName = ["Turkiye", "Pakistan", "Iran", "India"];

  List question = [
    "Do you need Visa support?",
    "Do you pick airport service?",
    "Do you need translator?",
    "Do you need accomization?"
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
          title: Text('treatment_abroad'.tr, style: AppTextStyle.boldPrimary20),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primary,
              )),
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
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: h * 0.89,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: h * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: w * 0.2,
                                      child: Divider(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    'choose_country'.tr,
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
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: w,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       offset: Offset(0, 4),
                                        //       blurRadius: 4,
                                        //       color: AppColors.black
                                        //           .withOpacity(0.25))
                                        // ],
                                        border: Border.all(
                                            color: AppColors.primary
                                                .withOpacity(0.4),
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: List.generate(
                                            4,
                                            (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      controller.selectedIndex
                                                          .value = index;
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: controller
                                                                              .selectedIndex
                                                                              .value ==
                                                                          index
                                                                      ? AppColors
                                                                          .primary
                                                                      : AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.4),
                                                                  width: 2),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      countryImage[
                                                                          index]))),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          countryName[index],
                                                          style: AppTextStyle.mediumPrimary10.copyWith(
                                                              color: controller
                                                                          .selectedIndex
                                                                          .value ==
                                                                      index
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.4)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: -7.5,
                                    child: Container(
                                      color: AppColors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          "countries".tr,
                                          style: AppTextTheme.h(11).copyWith(
                                              color: AppColors.lightPurple4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: w * 0.2,
                                      child: Divider(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    'details'.tr,
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
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                maxLines: 3,
                                cursorColor: AppColors.primary,
                                style: AppTextTheme.b(12).copyWith(
                                    color: AppColors.primary.withOpacity(0.5)),
                                decoration: InputDecoration(
                                    labelText: "tell_about".tr,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    labelStyle: AppTextTheme.b(12).copyWith(
                                        color:
                                            AppColors.primary.withOpacity(0.5)),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    isDense: true,
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
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: w * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            color: AppColors.black
                                                .withOpacity(0.25))
                                      ]),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
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
                                height: 5,
                              ),
                              Text(
                                'description'.tr,
                                textAlign: TextAlign.center,
                                style: AppTextTheme.b(11).copyWith(
                                    color: AppColors.primary.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: w * 0.2,
                                      child: Divider(
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    'other_details'.tr,
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
                                        color:
                                            AppColors.primary.withOpacity(0.5),
                                        height: 3,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ...List.generate(question.length, (index) {
                                return Column(
                                  children: [
                                    Text(
                                      question[index],
                                      style: AppTextStyle.boldPrimary14
                                          .copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.8),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.green2
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    AppImages.like),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'yes'.tr.toUpperCase(),
                                                  style: AppTextStyle
                                                      .boldBlack12
                                                      .copyWith(
                                                          color:
                                                              AppColors.green2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.red
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    AppImages.dislike),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'no'.tr.toUpperCase(),
                                                  style: AppTextStyle
                                                      .boldBlack12
                                                      .copyWith(
                                                          color: AppColors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.white,
                                          border:
                                              Border.all(color: AppColors.red),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                                color: AppColors.black
                                                    .withOpacity(0.25))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "cancel".tr,
                                                style: AppTextStyle.boldWhite14
                                                    .copyWith(
                                                        color:
                                                            Color(0xFFFF2B1E)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primary,
                                          border: Border.all(
                                              color: AppColors.primary),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                                color: AppColors.black
                                                    .withOpacity(0.25))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Text(
                                            "submit".tr,
                                            style: AppTextStyle.boldWhite14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
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
        }),
      ),
    );
  }
}
