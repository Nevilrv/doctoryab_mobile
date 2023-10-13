import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/controllers/pregnancy_tracker_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TabCalendarView extends GetView<PregnancyTrackerController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(
                top: 48,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 17, bottom: 32),
                          child: Text(
                            "baby_growing".tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.boldWhite25.copyWith(height: 1),
                          ),
                        ),
                      ),
                      Container(
                        height: h * 0.0605,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Your Baby is Now",
                                style: AppTextStyle.boldPrimary14.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary.withOpacity(0.8)),
                              ),
                              Text(
                                " 1 Month",
                                style: AppTextStyle.boldPrimary14.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                AppImages.circleInfo,
                                color: AppColors.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -50,
                    child: Image.asset(
                      AppImages.baby1,
                      height: h * 0.15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey3)),
              child: Container(
                // width: w,
                decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Stages Of Pregnancy",
                    style: AppTextStyle.boldWhite15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey3),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        Text(
                          "your_due_date".tr,
                          style: AppTextStyle.boldWhite16
                              .copyWith(color: AppColors.grey4),
                        ),
                        Text(
                          "23 December 2023",
                          style:
                              AppTextStyle.boldPrimary24.copyWith(fontSize: 25),
                        ),
                        Text("Saturday", style: AppTextStyle.boldBlack16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your baby’s star will be",
                              style: AppTextStyle.boldWhite16
                                  .copyWith(color: AppColors.grey4),
                            ),
                            Text(" Capricorn",
                                style: AppTextStyle.boldPrimary16),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.grey3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "calculate_date".tr,
                      style: AppTextStyle.boldWhite12.copyWith(
                          color: AppColors.grey4,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: AppColors.grey3,
            ),
            ExpansionTile(
              backgroundColor: AppColors.yellow3,
              collapsedBackgroundColor: AppColors.yellow3,
              collapsedIconColor: AppColors.white,
              iconColor: AppColors.white,
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: AppColors.yellow3)),
              title: Text(
                "1ST TRIMASTER",
                style: AppTextStyle.boldWhite15,
              ),
              children: <Widget>[
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.yellow3),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.yellow3, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.yellow3,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.yellow3,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.yellow3),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.yellow3, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.yellow3,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.yellow3,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.yellow3),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.yellow3, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.yellow3,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              backgroundColor: AppColors.pink,
              collapsedBackgroundColor: AppColors.pink,
              collapsedIconColor: AppColors.white,
              iconColor: AppColors.white,
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: AppColors.pink)),
              title: Text(
                "1ST TRIMASTER",
                style: AppTextStyle.boldWhite15,
              ),
              children: <Widget>[
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.pink),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.pink, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.pink,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.pink,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.pink),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.pink, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.pink,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.pink,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.pink),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.pink, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.pink,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              backgroundColor: AppColors.orange,
              collapsedBackgroundColor: AppColors.orange,
              collapsedIconColor: AppColors.white,
              iconColor: AppColors.white,
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: AppColors.orange)),
              title: Text(
                "1ST TRIMASTER",
                style: AppTextStyle.boldWhite15,
              ),
              children: <Widget>[
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.orange),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.orange, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.orange,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.orange),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.orange, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.orange,
                ),
                Container(
                  width: w * 0.89,
                  color: AppColors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.babySvg,
                            color: AppColors.orange),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "01 April 2023",
                              style: AppTextStyle.boldBlack14.copyWith(
                                  color: AppColors.orange, fontSize: 15),
                            ),
                            Text("Your baby is concived",
                                style: AppTextStyle.boldBlack14.copyWith(
                                    color: AppColors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Spacer(),
                        Text("fertilization_process".tr,
                            style: AppTextStyle.boldBlack14.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 10,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
